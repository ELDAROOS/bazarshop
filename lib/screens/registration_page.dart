import 'dart:convert';
import 'package:flutter/material.dart';
import 'auth_page.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // Метод для отображения диалоговых окон
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/back.png', width: 24, height: 24),  // Указываем путь к иконке и её размер
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          'Регистрация',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ЛИЧНЫЕ ДАННЫЕ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            // Поле для ввода имени пользователя
            _buildTextField(usernameController, 'Имя пользователя'),
            SizedBox(height: 20),
            // Поле для ввода электронной почты
            _buildTextField(emailController, 'Электронная почта'),
            SizedBox(height: 20),
            // Поле для ввода пароля
            _buildTextField(passwordController, 'Пароль', obscureText: true),
            SizedBox(height: 30),
            // Кнопка "Создать учетную запись"
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                String username = usernameController.text;

                if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
                  try {
                    // Формируем JSON-объект
                    Map<String, String> requestBody = {
                      'email': email,
                      'password': password,
                      'username': username,
                      'role': 'USER',
                    };

                    // Преобразуем в строку JSON
                    String jsonBody = jsonEncode(requestBody);
                    print('Отправляемый JSON: $jsonBody'); // Вывод JSON в консоль

                    var response = await http.post(
                      Uri.parse('http://localhost:8080/auth/sign-up'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonBody,
                    );

                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    if (response.statusCode == 200) {
                      _showDialog(
                        context,
                        'Успешно',
                        'Регистрация прошла успешно, сейчас перенаправим на страницу входа',
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AuthPage()),
                      );
                    } else {
                      _showDialog(
                        context,
                        'Ошибка',
                        'Не удалось зарегистрироваться. Попробуйте ещё раз.',
                      );
                    }
                  } catch (e) {
                    _showDialog(
                      context,
                      'Ошибка',
                      'Ошибка соединения с сервером: $e',
                    );
                  }
                } else {
                  _showDialog(
                    context,
                    'Внимание',
                    'Заполните все поля.',
                  );
                }
              },

              child: Text(
                'Создать учетную запись',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод для создания текстового поля с настраиваемыми параметрами
  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
