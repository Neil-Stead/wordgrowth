from flask import Flask, render_template, g
import sqlite3

# Configure app
app = Flask(__name__)


DATABASE = "db/vocab.db"

def get_db_connection():
    if 'db' not in g:
        g.db = sqlite3.connect(DATABASE)
    return g.db

@app.teardown_appcontext
def close_db_connection(exception):
    db = g.pop('db', None)
    if db is not None:
        db.close()


@app.route("/")
def show_words():    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vocabulary LIMIT 5")
    rows = cursor.fetchall()
    return render_template("index.html", rows=rows)

