import 'dart:convert';
import 'package:flutter/material.dart';
import 'auth_page.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Черный фон
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Возвращаемся назад
          },
        ),
        title: Text(
          'Регистрация',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black, // Черный цвет AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Заголовок
            Text(
              'ЛИЧНЫЕ ДАННЫЕ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Белый цвет текста
              ),
            ),
            SizedBox(height: 40),

            // Поле для ввода имени пользователя
            TextField(
              controller: usernameController,
              style: TextStyle(color: Colors.white), // Белый цвет текста в поле
              decoration: InputDecoration(
                labelText: 'Имя пользователя',
                labelStyle: TextStyle(color: Colors.white), // Белый цвет текста
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
              ),
            ),
            SizedBox(height: 20),

            // Поле для ввода электронной почты
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white), // Белый цвет текста в поле
              decoration: InputDecoration(
                labelText: 'Электронная почта',
                labelStyle: TextStyle(color: Colors.white), // Белый цвет текста
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
              ),
            ),
            SizedBox(height: 20),

            // Поле для ввода пароля
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white), // Белый цвет текста в поле
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.white), // Белый цвет текста
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Белая граница
                ),
              ),
            ),
            SizedBox(height: 30),

            // Кнопка "Создать учетную запись"
// Кнопка "Создать учетную запись"
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                String username = usernameController.text;

                if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
                  try {
                    var response = await http.post(
                      Uri.parse('http://localhost:8080/auth/sign-up'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({
                        'email': email,
                        'password': password,
                        'username': username,
                        'role': 'USER',
                      }),
                    );

                    if (response.statusCode == 200) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Успешно'),
                          content: Text('Регистрация прошла успешно, сейчас перенаправим на страницу входа'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('ОК'),
                            ),
                          ],
                        ),
                      );
                      // Успешная регистрация - переходим на auth_page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AuthPage()),
                      );
                    } else {
                      // Ошибка регистрации
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Ошибка'),
                          content: Text('Не удалось зарегистрироваться. Попробуйте ещё раз.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('ОК'),
                            ),
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    // Ошибка соединения
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Ошибка'),
                        content: Text('Ошибка соединения с сервером: $e'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ОК'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // Поля не заполнены
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Внимание'),
                      content: Text('Заполните все поля.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('ОК'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text(
                'Создать учетную запись',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Черный текст на кнопке
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Белая кнопка
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
}
