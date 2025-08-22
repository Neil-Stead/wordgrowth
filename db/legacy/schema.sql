CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    username VARCHAR(22) NOT NULL UNIQUE, 
    email VARCHAR(44) NOT NULL UNIQUE, 
    password_hash VARCHAR(20) NOT NULL
    ); 

CREATE TABLE IF NOT EXISTS "vocabulary" (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    user_id INTEGER, 
    word TEXT NOT NULL, 
    definition TEXT, 
    notes TEXT, 
    example_sentence TEXT,  
    FOREIGN KEY (user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS media (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word_id INTEGER NOT NULL,
    article_excerpt TEXT,
    media_type TEXT,
    platform TEXT,       -- e.g. 'youtube', 'vimeo', 'article'
    video_id TEXT,       -- ID of the video without full URL
    start_time INTEGER,  -- Start time in seconds
    FOREIGN KEY (word_id) REFERENCES vocabulary (id)
    );
