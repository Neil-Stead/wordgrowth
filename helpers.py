from flask import redirect, render_template, session, g, url_for
from functools import wraps
import sqlite3, re, os
from urllib.parse import urlparse, parse_qs
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
import psycopg2
import psycopg2.extras
from dotenv import load_dotenv
load_dotenv()  # take environment variables from .env.

# Pick up DATABASE_URL from environment variables (Render will set this automatically)
DATABASE_URL = "postgresql://postgres:qwerty@localhost:5432/wordgrowth"
print("Using DATABASE_URL:", DATABASE_URL)

def get_db_connection():
    if 'db' not in g:
        g.db = psycopg2.connect(DATABASE_URL, cursor_factory=psycopg2.extras.RealDictCursor)
    return g.db

### IS THIS CORRECT SEEMS TO BE THE CONNECTION FOR RENDER AND NOT LOCAL ENVIRONMENT

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

def apology(message, code=400):
    """Render message as an apology to user."""

    def escape(s):
        """
        Escape special characters.

        https://github.com/jacebrowning/memegen#special-characters
        """
        for old, new in [
            ("-", "--"),
            (" ", "-"),
            ("_", "__"),
            ("?", "~q"),
            ("%", "~p"),
            ("#", "~h"),
            ("/", "~s"),
            ('"', "''"),
        ]:
            s = s.replace(old, new)
        return s

    return render_template("apology.html", top=code, bottom=escape(message))

def parse_time_string(t_str):
    """Convert YouTube/Vimeo style times like '90', '1m30s' into seconds."""
    if t_str.isdigit():
        return int(t_str)
    total_seconds = 0
    match = re.match(r'(?:(\d+)h)?(?:(\d+)m)?(?:(\d+)s)?', t_str)
    if match:
        hours = int(match.group(1) or 0)
        minutes = int(match.group(2) or 0)
        seconds = int(match.group(3) or 0)
        total_seconds = hours * 3600 + minutes * 60 + seconds
    return total_seconds or None

def classify_media_url(url):
    """
    Classify a media URL as video, article, or null.
    If video, extract platform, video ID, and start time.
    """
    if not url:
        return {
            "media_type": None,
            "platform": None,
            "video_id": None,
            "start_time": None
        }

    parsed = urlparse(url)
    hostname = parsed.hostname or ""
    query_params = parse_qs(parsed.query)

    # ---- YouTube ----
    if "youtube.com" in hostname or "youtu.be" in hostname:
        if "youtu.be" in hostname:
            video_id = parsed.path.lstrip("/")
        else:
            video_id = query_params.get("v", [None])[0]

        # Start time
        start_time = None
        if "t" in query_params:
            start_time = parse_time_string(query_params["t"][0])
        elif parsed.fragment.startswith("t="):
            start_time = parse_time_string(parsed.fragment[2:])

        return {
            "media_type": "video",
            "platform": "youtube",
            "video_id": video_id,
            "start_time": start_time
        }

    # ---- Vimeo ----
    elif "vimeo.com" in hostname:
        match = re.search(r"vimeo\.com/(?:video/)?(\d+)", url)
        video_id = match.group(1) if match else None

        start_time = None
        if parsed.fragment.startswith("t="):
            start_time = parse_time_string(parsed.fragment[2:])

        return {
            "media_type": "video",
            "platform": "vimeo",
            "video_id": video_id,
            "start_time": start_time
        }

    # ---- Articles or other URLs ----
    return {
        "media_type": "article",
        "platform": None,
        "video_id": None,
        "start_time": None,
        "article_excerpt": url
    }


def highlight_word(text, word):
    """
    Highlight all case-insensitive instances of 'word' in 'text'
    using <mark> tags. Only matches whole words.
    """
    if not text or not word:
        return text
    
    pattern = re.compile(re.escape(word), flags=re.IGNORECASE)
    return pattern.sub(lambda m: f"<strong>{m.group(0)}</strong>", text)