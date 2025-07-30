from flask import redirect, render_template, session, g, url_for
from functools import wraps
import sqlite3, re
from newspaper import Article

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

def classify_media_url(url):
    url = url.lower()
    if 'youtube.com' in url or 'youtu.be' in url or 'vimeo.com' in url:
        return 'video'
    return 'article'

def get_article_data(url):
    article = Article(url)
    article.download()
    article.parse()
    article.nlp()
    return {
        'title': article.title,
        'summary': article.summary,
        'text': article.text[:500]  # optional: just first few lines
    }
