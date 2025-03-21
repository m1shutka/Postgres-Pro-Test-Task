-- Таблица Students
CREATE TABLE IF NOT EXISTS students (
    s_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    start_year INTEGER NOT NULL
);

-- Таблица Courses
CREATE TABLE IF NOT EXISTS courses (
    c_no INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    hours INTEGER NOT NULL
);

-- Таблица Exams
CREATE TABLE IF NOT EXISTS exams (
    s_id INTEGER,
    c_no INTEGER,
    score NUMERIC(5, 2) NOT NULL CHECK (score BETWEEN 0 AND 100),
    PRIMARY KEY (s_id, c_no),
    FOREIGN KEY (s_id) 
        REFERENCES students(s_id)
        ON DELETE CASCADE,
    FOREIGN KEY (c_no) 
        REFERENCES courses(c_no)
        ON DELETE CASCADE
);