from flask import Flask, request, jsonify
from flask_cors import CORS  # Импортируем CORS
import psycopg2

app = Flask(__name__)

# Разрешаем CORS для всех доменов (не рекомендуется для продакшн)
CORS(app)

# Пример подключения к базе данных PostgreSQL
def get_db_connection():
    conn = psycopg2.connect(
        dbname='postgres',
        user='postgres',
        password='123',
        host='localhost',
        port='5432'
    )
    return conn

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    # Получаем дополнительные данные
    firstname = data.get('firstname')
    lastname = data.get('lastname')
    email = data.get('email')
    password = data.get('password')
    user_role = data.get('userRole')  # Получаем роль пользователя

    if not all([firstname, lastname, email, password, user_role]):
        return jsonify({'message': 'All fields are required'}), 400

    # Пример добавления пользователя в базу данных
    conn = get_db_connection()
    cursor = conn.cursor()

    # Вставляем все данные в таблицу
    cursor.execute("""
        INSERT INTO users (firstname, lastname, email, password, user_role)
        VALUES (%s, %s, %s, %s, %s)
    """, (firstname, lastname, email, password, user_role))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({'message': 'User registered successfully'}), 200


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data['email']
    password = data['password']

    # Пример проверки пользователя в базе данных
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE email = %s AND password = %s", (email, password))
    user = cursor.fetchone()
    cursor.close()
    conn.close()

    if user:
        # Возвращаем email в ответе
        return jsonify({'message': 'Login successful', 'email': email}), 200
    else:
        return jsonify({'message': 'Invalid email or password'}), 400


if __name__ == '__main__':
    app.run(debug=True)
