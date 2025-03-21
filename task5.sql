-- Запрос для поиска студентов без сданных экзаменов
SELECT s.s_id, s.name, s.start_year
FROM students s
LEFT JOIN exams e ON s.s_id = e.s_id
WHERE e.s_id IS NULL;