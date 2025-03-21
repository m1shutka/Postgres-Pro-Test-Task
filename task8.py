from faker import Faker
import psycopg2
import random
from dotenv import load_dotenv
import os

load_dotenv()

# Настройки подключения к PostgreSQL
DB_CONFIG = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("USER"),
    "password": os.getenv("PASSWORD"),
    "host": os.getenv("HOST"),
    "port": os.getenv("PORT")
}

# Инициализация Faker для генерации данных
fake = Faker("ru_RU")

def generate_students(num=10):
    """Генерация студентов"""

    students = []

    for _ in range(num):
        students.append((
            fake.unique.random_int(min=1000, max=9999),   # Уникальный s_id
            fake.last_name() + " " + fake.first_name(),   # Имя
            fake.random_int(min=2018, max=2023)           # Год поступления
        ))

    return students

def generate_courses():
    """Генерация курсов"""

    courses = [
        (101, "Математика", 120),
        (102, "Физика", 90),
        (103, "Программирование", 150),
        (104, "История", 80),
        (105, "Биология", 100)
    ]

    return courses

def generate_exams(students, courses, max_exams_per_student=5):
    """Генерация экзаменов"""

    exams = []

    for student in students:

        num_exams = random.randint(0, max_exams_per_student)
        selected_courses = random.sample(courses, min(num_exams, len(courses)))

        for course in selected_courses:
            exams.append((
                student[0],             # s_id студента
                course[0],              # c_no курса
                round(random.uniform(40, 100), 2)  # Оценка (40-100)
            ))

    return exams

if __name__ == "__main__":

    # Подключение к базе и заполнение данных
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor()

        # Генерация данных
        students = generate_students(20)    # 20 студентов
        courses = generate_courses()        # 5 курсов
        exams = generate_exams(students, courses)

        # Вставка студентов
        cur.executemany("INSERT INTO students (s_id, name, start_year) VALUES (%s, %s, %s) ON CONFLICT DO NOTHING", students)

        # Вставка курсов
        cur.executemany("INSERT INTO courses (c_no, title, hours) VALUES (%s, %s, %s) ON CONFLICT DO NOTHING", courses)

        # Вставка экзаменов
        cur.executemany("INSERT INTO exams (s_id, c_no, score) VALUES (%s, %s, %s) ON CONFLICT DO NOTHING", exams)

        conn.commit()
        print(f"Добавлено: {len(students)} студентов, {len(courses)} курсов, {len(exams)} экзаменов.")

    except Exception as e:
        print(f"Ошибка: {e}")
        conn.rollback()

    finally:
        if conn:
            cur.close()
            conn.close()