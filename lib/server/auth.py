import bcrypt
from flask import request, jsonify
from db import cursor, conn

def register_user():
    data = request.json
    firstname = data['firstname']
    lastname = data['lastname']
    email = data['email']
    password = data['pass']

    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    insert_query = """
    INSERT INTO UserDatabase (firstname, lastname, pass, email)
    VALUES (%s, %s, %s, %s);
    """
    cursor.execute(insert_query, (firstname, lastname, hashed_password.decode('utf-8'), email))
    conn.commit()

    return jsonify({'message': 'User registered successfully'}), 201

def login():
    data = request.json
    email = data['email']
    password = data['password']

    select_query = "SELECT * FROM UserDatabase WHERE email = %s"
    cursor.execute(select_query, (email,))
    user = cursor.fetchone()

    if user:
        stored_password = user[3]
        if bcrypt.checkpw(password.encode('utf-8'), stored_password.encode('utf-8')):
            return jsonify({'message': 'Login successful', 'userId': user[0], 'email': user[4]}), 200
        else:
            return jsonify({'error': 'Invalid password'}), 401
    else:
        return jsonify({'error': 'User not found'}), 404
