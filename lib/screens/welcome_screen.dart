import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'registration_screen.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Добро пожаловать',
                style: TextStyle(
                  fontSize: 20, // Средний размер шрифта
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Times New Roman', // Применение шрифта
                  color: Colors.black, // Черный цвет текста
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'BAZAR',
                style: TextStyle(
                  fontSize: 48, // Большой размер шрифта
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman', // Применение шрифта
                  letterSpacing: 2.0, // Дополнительное пространство между буквами
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
                  backgroundColor: Colors.black, // Черный фон кнопки
                  foregroundColor: Colors.white, // Белый текст
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Закругленная кнопка
                  ),
                ),
                child: Text(
                  'Войти',
                  style: TextStyle(
                    fontFamily: 'Times New Roman', // Применение шрифта
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Черный фон кнопки
                  foregroundColor: Colors.white, // Белый текст
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Закругленная кнопка
                  ),
                ),
                child: Text(
                  'Регистрация',
                  style: TextStyle(
                    fontFamily: 'Times New Roman', // Применение шрифта
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text(
                  'Войти как гость',
                  style: TextStyle(
                    color: Colors.black, // Черный текст
                    fontFamily: 'Times New Roman', // Применение шрифта
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
