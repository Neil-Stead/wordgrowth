CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(22) NOT NULL UNIQUE,
    email VARCHAR(44) UNIQUE,
    password_hash VARCHAR(600) NOT NULL  -- Increased for bcrypt hashes
);

CREATE TABLE vocabulary (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    word TEXT NOT NULL,
    definition TEXT,
    notes TEXT,
    example_sentence TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE media (
    id SERIAL PRIMARY KEY,
    word_id INTEGER NOT NULL,
    article_excerpt TEXT,
    media_type VARCHAR(10) CHECK (media_type IN ('youtube', 'vimeo', 'article')),
    video_id TEXT,
    start_time INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    platform VARCHAR(30),
    FOREIGN KEY (word_id) REFERENCES vocabulary(id) ON DELETE CASCADE
);