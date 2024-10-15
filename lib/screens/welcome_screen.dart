import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'home_screen.dart'; // Импортируем экран домашней страницы

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F5F0), // Молочный фон
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Добро пожаловать в BAZAR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Черный цвет текста
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen(isRegistration: false)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Белый фон кнопки
                  foregroundColor: Colors.black, // Черный текст
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Войти'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen(isRegistration: true)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Белый фон кнопки
                  foregroundColor: Colors.black, // Черный текст
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Регистрация'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Переход на домашний экран в режиме гостя
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()), // Переход к экрану хом
                  );
                },
                child: Text(
                  'Войти как гость',
                  style: TextStyle(color: Colors.black), // Черный текст
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
