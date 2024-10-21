from flask import Flask, request, jsonify
import psycopg2
from psycopg2 import sql

app = Flask(__name__)

DB_HOST = 'localhost'
DB_NAME = 'bazar'
DB_USER = 'root'
DB_PASSWORD = '123'

def get_db_connection():
    conn = psycopg2.connect(host=DB_HOST, database=DB_NAME, user=DB_USER, password=DB_PASSWORD)
    return conn

@app.route('/register', methods=['POST'])
def register_user():
    data = request.json
    firstname = data['firstname']
    lastname = data['lastname']
    password = data['pass']
    email = data['email']
    user_role = data.get('userRole', 'user')  # Роль по умолчанию

    try:
        conn = get_db_connection()
        cur = conn.cursor()

        insert_query = sql.SQL("""
            INSERT INTO UserDatabase (firstname, lastname, pass, email, userRole)
            VALUES (%s, %s, %s, %s, %s)
        """)
        cur.execute(insert_query, (firstname, lastname, password, email, user_role))
        conn.commit()

        return jsonify({"message": "User registered successfully!"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 400

    finally:
        cur.close()
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
