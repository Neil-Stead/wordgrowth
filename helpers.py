from flask import redirect, render_template, session, g, url_for
from functools import wraps
import sqlite3, re
from urllib.parse import urlparse, parse_qs

DATABASE = "db/vocab.db"

def get_db_connection():
    if 'db' not in g:
        g.db = sqlite3.connect(DATABASE)
        g.db.execute("PRAGMA foreign_keys = ON")  # Enables foreign key checks
        g.db.row_factory = sqlite3.Row # enables dictionaries to be returned not just tuples
    return g.db

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

def extract_youtube_id(url):
    match = re.search(r'(?:v=|\/embed\/|\.be\/)([\w\-]{11})', url)
    return match.group(1) if match else None

def convert_youtube_url_to_embed(url):
    """
    Converts a YouTube URL into an embeddable format,
    preserving timestamp if present.
    Returns a full embed URL (string), or None if invalid.
    """
    if not url:
        return None
    
    match = re.search(r'(?:youtu\.be/|v=|embed/)([a-zA-Z0-9_-]{11})', url)
    if not match:
        return None

    video_id = match.group(1)

    # Parse timestamp from URL query (e.g., ?t=2264)
    parsed_url = urlparse(url)
    query_params = parse_qs(parsed_url.query)
    timestamp = query_params.get('t', [None])[0]

    # Build embed URL
    embed_url = f"https://www.youtube.com/embed/{video_id}"
    if timestamp and timestamp.isdigit():
        embed_url += f"?start={timestamp}"

    return embed_url

def extract_youtube_id_and_timestamp(url):
    """
    Extracts the YouTube video ID and optional timestamp (start time in seconds)
    from various YouTube URL formats.
    
    Returns a dictionary: { 'video_id': '...', 'start_time': '...' or None }
    """
    if not url:
        return {'video_id': None, 'start_time': None}

    # Extract video ID (works with youtu.be, watch?v=, embed/)
    match = re.search(r'(?:youtu\.be/|v=|embed/)([a-zA-Z0-9_-]{11})', url)
    video_id = match.group(1) if match else None

    # Parse the timestamp (?t=2264)
    parsed_url = urlparse(url)
    query_params = parse_qs(parsed_url.query)
    timestamp = query_params.get('t', [None])[0]

    return {
        'video_id': video_id,
        'start_time': timestamp
    }


def classify_media_url(url):
    url = url.lower()
    if 'youtube.com' in url or 'youtu.be' in url or 'vimeo.com' in url:
        return 'video'
    return 'article'

def highlight_word(text, word):
    """
    Highlight all case-insensitive instances of 'word' in 'text'
    using <mark> tags. Only matches whole words.
    """
    if not text or not word:
        return text
    
    pattern = re.compile(re.escape(word), flags=re.IGNORECASE)
    return pattern.sub(lambda m: f"<strong>{m.group(0)}</strong>", text)