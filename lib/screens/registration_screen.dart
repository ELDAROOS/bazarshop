import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser(BuildContext context) async {
    String firstname = _firstnameController.text;
    String lastname = _lastnameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Проверка полей
    if (firstname.isNotEmpty &&
        lastname.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      // Отправка данных на сервер
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/register'), // Замените на URL вашего сервера
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstname': firstname,
          'lastname': lastname,
          'pass': password,
          'email': email,
          'userRole': 'user', // Вы можете изменить роль пользователя по необходимости
        }),
      );

      if (response.statusCode == 201) {
        // Успешная регистрация
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Регистрация успешна!'),
        ));
        Navigator.pop(context); // Возвращаемся назад
      } else {
        // Обработка ошибок
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ошибка регистрации: ${response.body}'),
        ));
      }
    } else {
      // Обработка ошибок
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Пожалуйста, заполните все поля'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF6F5F0), // Молочный фон
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  labelText: 'Имя',
                  hintText: 'Введите ваше имя',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: 'Фамилия',
                  hintText: 'Введите вашу фамилию',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Введите ваш email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  hintText: 'Введите пароль',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Скрыть ввод пароля
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _registerUser(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
