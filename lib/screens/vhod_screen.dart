import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'registration_screen.dart';

class VhodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон
      appBar: AppBar(
        title: Text(
          'Вход/Регистрация',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white, // Белый фон
        elevation: 0, // Убираем тень
      ),
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
                  fontFamily: 'Times New Roman',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Увеличиваем кнопку
                ),
                child: Text(
                  'Войти',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 18,
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Увеличиваем кнопку
                ),
                child: Text(
                  'Регистрация',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Действие для входа как гость
                },
                child: Text(
                  'Войти как гость',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                    fontSize: 16,
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
