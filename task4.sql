-- Добавление данных в таблицу Students
INSERT INTO students (s_id, name, start_year)
VALUES
    (1, 'Иванов Алексей', 2020),
    (2, 'Петрова Мария', 2021),
    (3, 'Сидоров Дмитрий', 2022)
ON CONFLICT (s_id) DO NOTHING;

-- Добавление данных в таблицу Courses
INSERT INTO courses (c_no, title, hours)
VALUES
    (101, 'Математика', 120),
    (102, 'Физика', 90),
    (103, 'Программирование', 150)
ON CONFLICT (c_no) DO NOTHING;

-- Добавление данных в таблицу Exams
INSERT INTO exams (s_id, c_no, score)
VALUES
    (1, 101, 85.5),
    (1, 102, 92.0),
    (2, 101, 78.3),
    (3, 103, 88.9)
ON CONFLICT (s_id, c_no) DO NOTHING;