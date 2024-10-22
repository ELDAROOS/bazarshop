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
      backgroundColor: Colors.white, // Белый фон для всего экрана
      appBar: AppBar(
        title: Text(
          'Регистрация',
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
                controller: _firstnameController,
                style: TextStyle(fontFamily: 'Times New Roman'),
                decoration: InputDecoration(
                  labelText: 'Имя',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                  hintText: 'Введите ваше имя',
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
                controller: _lastnameController,
                style: TextStyle(fontFamily: 'Times New Roman'),
                decoration: InputDecoration(
                  labelText: 'Фамилия',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                  hintText: 'Введите вашу фамилию',
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
                  onPressed: () => _registerUser(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Черный фон кнопки
                    foregroundColor: Colors.white, // Белый текст
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Закругленные углы кнопки
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Добавление отступов
                  ),
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold,
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
