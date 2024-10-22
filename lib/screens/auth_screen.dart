import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthScreen extends StatelessWidget {
  final bool isRegistration;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthScreen({required this.isRegistration});

  Future<void> _authenticate(String email, String password) async {
    // URL вашего Flask-сервера
    String url = isRegistration
        ? 'http://10.0.2.2:5000/register' // URL для регистрации
        : 'http://10.0.2.2:5000/login'; // URL для входа

    try {
      // Отправляем POST-запрос на сервер
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Успешная регистрация/вход
        final responseData = json.decode(response.body);
        print('Успех: ${responseData}');
      } else {
        // Ошибка с сервера
        print('Ошибка сервера: ${response.statusCode}');
        print('Ответ: ${response.body}');
      }
    } catch (error) {
      // Ошибка сети или другие проблемы
      print('Ошибка подключения: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        color: Colors.white,
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

                    // Вызов функции для авторизации или регистрации
                    _authenticate(email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: Text(
                    isRegistration ? 'Зарегистрироваться' : 'Войти',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
