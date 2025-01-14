import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart'; // Импортируем вашу главную страницу
import 'registration_page.dart';


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  Future<void> signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://localhost:8080/auth/sign-in'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        );

        if (response.statusCode == 200) {
          // Успешная авторизация
          setState(() {
            errorMessage = null; // Очистка сообщения об ошибке
          });

          // Получаем JWT токен из ответа
          var responseData = jsonDecode(response.body);
          String jwtToken = responseData['token']; // Предполагаем, что ответ содержит поле 'token'

          // Переход на главную страницу после успешного входа
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(jwtToken: jwtToken), // Передаем токен на главную страницу
            ),
          );
        } else {
          // Ошибка авторизации
          var responseData = jsonDecode(response.body);
          setState(() {
            errorMessage = responseData['error'] ?? 'Неизвестная ошибка';
          });
        }
      } catch (e) {
        // Ошибка соединения
        setState(() {
          errorMessage = 'Ошибка соединения с сервером: $e';
        });
      }
    } else {
      // Поля не заполнены
      setState(() {
        errorMessage = 'Заполните все поля.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Возвращаемся назад
          },
        ),
        title: Text(
          'Вход в аккаунт',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ВОЙДИТЕ В СВОЮ УЧЕТНУЮ ЗАПИСЬ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),

            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Электронная почта',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: signIn,
              child: Text(
                'Начать сейчас',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'НУЖНА УЧЕТНАЯ ЗАПИСЬ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
