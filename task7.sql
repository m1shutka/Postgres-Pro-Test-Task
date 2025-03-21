-- Запрос для вывода курсов со средним баллом, отсортированных по убыванию
SELECT c.c_no AS course_id, c.title AS course_title, ROUND(AVG(e.score)::NUMERIC, 2) AS avg_score
FROM courses c
LEFT JOIN exams e ON c.c_no = e.c_no
GROUP BY c.c_no
ORDER BY avg_score DESC NULLS LAST;