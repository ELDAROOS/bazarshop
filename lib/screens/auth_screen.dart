import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthScreen extends StatelessWidget {
  final bool isRegistration;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthScreen({required this.isRegistration});

  Future<void> _handleAuth(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      String url = isRegistration
          ? 'http://127.0.0.1:5000/register'
          : 'http://127.0.0.1:5000/login';

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Успешный запрос
        final data = jsonDecode(response.body);
        if (isRegistration) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Регистрация прошла успешно!'),
          ));
        } else {
          // Извлекаем email при успешной авторизации
          String userEmail = data['email'];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Добро пожаловать, $userEmail!'),
          ));
        }
        Navigator.pop(context); // Закрыть экран авторизации
      } else {
        // Ошибка запроса
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ошибка: ${response.body}'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Пожалуйста, заполните все поля'),
      ));
    }
  }

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
                  onPressed: () => _handleAuth(context),
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
