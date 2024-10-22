from flask import Flask
from auth import register_user, login

app = Flask(__name__)

@app.route('/register', methods=['POST'])
def register():
    return register_user()

@app.route('/login', methods=['POST'])
def login_route():
    return login()

if __name__ == '__main__':
    app.run(debug=True)
