-- Запрос для получения списка студентов с количеством сданных экзаменов
SELECT s.s_id, s.name, s.start_year, count(*) as exams_passed
FROM students s
LEFT JOIN exams e ON s.s_id = e.s_id
WHERE e.s_id IS NOT NULL
GROUP BY s.s_id;