import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final bool isRegistration;

  AuthScreen({this.isRegistration = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isRegistration ? 'Регистрация' : 'Вход', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black), // Черный цвет текста
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black), // Черная рамка
                ),
                filled: true,
                fillColor: Colors.white, // Белый фон
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.black), // Черный цвет текста
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black), // Черная рамка
                ),
                filled: true,
                fillColor: Colors.white, // Белый фон
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Логика входа или регистрации
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Белый фон кнопки
                foregroundColor: Colors.black, // Черный текст
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(isRegistration ? 'Зарегистрироваться' : 'Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
