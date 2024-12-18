import psycopg2
import jwt
import datetime
from flask import Flask, request, jsonify
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash

# Настройка Flask и CORS
app = Flask(__name__)
CORS(app)

# Конфигурация для JWT
app.config['SECRET_KEY'] = 'your_secret_key'  # Замените на свой секретный ключ

# Подключение к базе данных PostgreSQL
def get_db_connection():
    conn = psycopg2.connect(
        host='localhost',
        database='your_db_name',
        user='your_db_user',
        password='your_db_password'
    )
    return conn

# Регистрация пользователя
@app.route('/register', methods=['POST'])
def register_user():
    data = request.get_json()

    firstname = data['firstname']
    lastname = data['lastname']
    email = data['email']
    password = data['pass']
    user_role = data['userRole']

    # Хеширование пароля
    hashed_password = generate_password_hash(password, method='sha256')

    # Подключение к базе данных
    conn = get_db_connection()
    cur = conn.cursor()

    # Проверка, существует ли уже пользователь с таким email
    cur.execute('SELECT * FROM users WHERE email = %s', (email,))
    existing_user = cur.fetchone()
    if existing_user:
        cur.close()
        conn.close()
        return jsonify({'message': 'Email уже зарегистрирован'}), 400

    # Вставка нового пользователя в базу данных
    cur.execute('INSERT INTO users (firstname, lastname, email, password, user_role) VALUES (%s, %s, %s, %s, %s)',
                (firstname, lastname, email, hashed_password, user_role))
    conn.commit()

    cur.close()
    conn.close()

    return jsonify({'message': 'Пользователь успешно зарегистрирован'}), 201


# Авторизация пользователя (выдача JWT)
@app.route('/login', methods=['POST'])
def login_user():
    data = request.get_json()

    email = data['email']
    password = data['pass']

    # Подключение к базе данных
    conn = get_db_connection()
    cur = conn.cursor()

    # Получение пользователя по email
    cur.execute('SELECT * FROM users WHERE email = %s', (email,))
    user = cur.fetchone()

    cur.close()
    conn.close()

    if user and check_password_hash(user[4], password):  # user[4] - это столбец с паролем
        # Генерация JWT токена
        token = jwt.encode({
            'sub': user[0],  # user[0] - это ID пользователя
            'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)  # Время жизни токена - 1 час
        }, app.config['SECRET_KEY'], algorithm='HS256')

        return jsonify({'message': 'Авторизация успешна', 'token': token})

    return jsonify({'message': 'Неверные email или пароль'}), 401


# Защищенный маршрут (требуется авторизация через JWT)
@app.route('/profile', methods=['GET'])
def get_profile():
    token = request.headers.get('Authorization')

    if not token:
        return jsonify({'message': 'Токен не предоставлен'}), 403

    try:
        # Убираем "Bearer " из токена
        token = token.split(" ")[1]
        # Декодируем токен и проверяем его
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        user_id = decoded_token['sub']

        # Получение информации о пользователе
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT * FROM users WHERE id = %s', (user_id,))
        user = cur.fetchone()

        cur.close()
        conn.close()

        if user:
            return jsonify({
                'firstname': user[1],
                'lastname': user[2],
                'email': user[3],
                'user_role': user[5]  # user_role - столбец с ролью
            })
        else:
            return jsonify({'message': 'Пользователь не найден'}), 404

    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Токен истек'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Неверный токен'}), 401


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
