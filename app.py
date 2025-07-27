from flask import Flask, render_template, g, redirect, request, session
from flask_session import Session
import sqlite3
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, get_db_connection

# Configure app
app = Flask(__name__)

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False         # Sessions expire when the browser is closed
app.config["SESSION_TYPE"] = "filesystem"       # Store session data in files
Session(app)                                    # Initialize Flask-Session

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

    # if not session["user_id"]:



    return render_template("index.html", rows=rows)

@app.route("/register", methods=["POST", "GET"])
def register():
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == "POST":
        if not request.form.get("username"):
            return apology("must provide username")
           
        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 400)

        # Ensure confirmation of password was submitted and matches original password
        elif not request.form.get("confirmation"):
            return apology("must provide password", 400)

        elif not request.form.get("password") == request.form.get("confirmation"):
            return apology("confirmation does not match password", 400)
        
        # Query database for username
        cursor.execute(
            "SELECT * FROM users WHERE username = ?", [request.form.get("username")]
        )
        conn.commit()

        users = cursor.fetchall()

        # If username already exists apology and ask to choose another username
        if len(users) == 1:
            return apology("that username is already in use, please choose another", 400)
        
        if request.form.get("email"):
            # Insert new user with email into database
                cursor.execute(
                    "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)", [request.form.get("username"), request.form.get("email"), generate_password_hash(request.form.get("password"))]
                    )
                conn.commit()
                
        else:
            # Insert new user without email into database
                cursor.execute(
                    "INSERT INTO users (username, password_hash) VALUES (?, ?)", [request.form.get("username"), generate_password_hash(request.form.get("password"))]
                    )
                conn.commit()
                
        return redirect("/")

    else:
        return render_template("register.html")
    

@app.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        return render_template("login.html")







    else:
        return render_template("login.html")



