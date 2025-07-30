from flask import Flask, render_template, g, redirect, request, session, url_for
from flask_session import Session
import sqlite3
from werkzeug.security import check_password_hash, generate_password_hash
from helpers import apology, get_db_connection, login_required, extract_youtube_id

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

    if not session.get("user_id"):
        return redirect(url_for("login"))
    
    else:

        cursor.execute(
            "SELECT * FROM users WHERE id = ?", [session['user_id']]
            )
        user = cursor.fetchone()

        cursor.execute(
            "SELECT * FROM vocabulary WHERE user_id = ?", [session['user_id']]
            )
        rows = cursor.fetchall()
        
        return render_template("index.html", rows=rows, user=user)


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
                
        return redirect("/login.html")

    else:
        return render_template("register.html")
    

@app.route("/login", methods=["POST", "GET"])
def login():
    conn = get_db_connection()
    cursor = conn.cursor()

    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        cursor.execute(
            "SELECT * FROM users WHERE username = ?", [request.form.get("username")]
        )
        rows = cursor.fetchall()

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(
            rows[0]["password_hash"], request.form.get("password")
        ):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")

@app.route("/account", methods=["GET", "POST"])
def account():
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == "POST":

        # Ensure password was submitted
        if not request.form.get("current_password"):
            return apology("must provide password", 403)

        # Ensure confirmation of password was submitted and matches original password
        elif not request.form.get("new_password"):
            return apology("must provide new password", 403)

        elif not request.form.get("new_password") == request.form.get("confirm_password"):
            return apology("confirmation does not match new password", 403)

        # Query database for password
        cursor.execute(
            "SELECT * FROM users WHERE id = ?", [session["user_id"]]
        )
        user = cursor.fetchone()

        # check password is correct
        if not user or not check_password_hash(
            user["password_hash"], request.form.get("current_password")
        ):
            return apology("invalid password", 403)

        # Update password in database

        else:

            new_password_hash = generate_password_hash(request.form.get("new_password"))

            cursor.execute(
                "UPDATE users SET password_hash = ? WHERE id = ?", [new_password_hash, session["user_id"]]
                )
            conn.commit()

        # Remember which user has logged in
        session["user_id"] = user["id"]

        return redirect("/")

    # Allow user to change password
    else:

        # Display users username

        cursor.execute(
            "SELECT * FROM users WHERE id = ?", [session["user_id"]]
            )
        username = cursor.fetchone()

        return render_template("/account.html", username=username)


@app.route("/new_word", methods=["POST", "GET"])
@login_required
def new_word():
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == "POST":
        word = request.form['word']
        definition = request.form['definition']
        example_sentence = request.form.get('example_sentence')
        media_url = request.form.get('example_media')
        media_type = classify_media_url(media_url)
        article_excerpt = ''
        vid_id = ''

        if not word:
            return apology("must provide word")
            
        # Ensure definition was submitted
        if not definition:
            return apology("must provide definition", 400)
        
        if media_type == 'video':
            vid_id = extract_youtube_id(media_url)
            media_url = vid_id
        elif media_type == 'article':
            try:
                article_data = get_article_data(media_url)
                article_excerpt = article_data['summary'] or article_data['text']
            except Exception as e:
                print("Failed to parse article:", e)
                article_excerpt = '[Could not load article content]'

        else:
        # Insert new word into database
            cursor.execute(
                "INSERT INTO vocabulary (user_id, word, definition, notes, example_sentence, example_media, media_type, article_excerpt) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [session["user_id"], word, definition, request.form.get("notes"), example_sentence, media_url, media_type, article_excerpt]
                )
            conn.commit()
            
            new_id = cursor.lastrowid
                
        return redirect(url_for("word_view", word_id=new_id))

    else:
        return render_template("new_word.html")
    

@app.route("/word_view/<int:word_id>")
@login_required
def word_view(word_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vocabulary WHERE id=?", [word_id])
    word = cursor.fetchone()

    if word is None:
        return apology("word not found")
    
    if word["example_media"]:
        vid_id = extract_youtube_id(word["example_media"])

        print(vid_id)

        return  render_template("word_view.html", word=word, vid_id=vid_id)
    
    else:
        return  render_template("word_view.html", word=word)
    

@app.route("/word_edit/<int:word_id>", methods=["POST", "GET"])
@login_required
def word_edit(word_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vocabulary WHERE id=?", [word_id])
    word = cursor.fetchone()

    if request.method == "POST":
        # update word into database

        # Use the submitted value if provided; otherwise, keep the old value
        updated_word = request.form.get("word") or word["word"]
        updated_definition = request.form.get("definition") or word["definition"]
        updated_notes = request.form.get("notes") or word["notes"]
        updated_example_sentence = request.form.get("example_sentence") or word["example_sentence"]
        updated_example_media = request.form.get("example_media") or word["example_media"]

        cursor.execute(
            "UPDATE vocabulary SET user_id = ?, word = ?, definition = ?, notes = ?, example_sentence = ?, example_media = ? WHERE id = ?", 
                [
                session["user_id"], 
                updated_word, 
                updated_definition, 
                updated_notes, 
                updated_example_sentence, 
                updated_example_media, 
                word_id
                ]
            )
        conn.commit()
                
        return redirect(url_for("word_view", word_id=word["id"]))
    
    else:
  
        return  render_template("word_edit.html", word=word)
