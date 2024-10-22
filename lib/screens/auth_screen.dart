import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final bool isRegistration;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthScreen({required this.isRegistration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон для всего экрана
      appBar: AppBar(
        title: Text(
          isRegistration ? 'Регистрация' : 'Вход',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Белый фон для содержимого
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _emailController,
                style: TextStyle(fontFamily: 'Times New Roman'),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                  hintText: 'Введите ваш email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Times New Roman',
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                style: TextStyle(fontFamily: 'Times New Roman'),
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                  hintText: 'Введите пароль',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Times New Roman',
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    if (isRegistration) {
                      print('Регистрация: $email, $password');
                    } else {
                      print('Вход: $email, $password');
                    }

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Закругленные углы кнопки
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text(
                    isRegistration ? 'Зарегистрироваться' : 'Войти',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Увеличенный размер шрифта
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
