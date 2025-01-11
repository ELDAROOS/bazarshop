import 'package:flutter/material.dart';
import 'registration_page.dart';  // Импортируем страницу регистрации

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Черный фон
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Возвращаемся назад на главную
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
              'ВОЙДИТЕ В СВОЮ УЧЕТНУЮ ЗАПИСЬ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,  // Белый цвет текста
              ),
            ),
            SizedBox(height: 40),

            // Поле для ввода электронной почты
            TextField(
              style: TextStyle(color: Colors.white),  // Белый цвет текста в поле
              decoration: InputDecoration(
                labelText: 'Электронная почта',
                labelStyle: TextStyle(color: Colors.white),  // Белый цвет текста
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),  // Белая граница
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),  // Белая граница
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),  // Белая граница
                ),
              ),
            ),
            SizedBox(height: 20),

            // Поле для ввода пароля
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),  // Белый цвет текста в поле
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(color: Colors.white),  // Белый цвет текста
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),  // Белая граница
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),  // Белая граница
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),  // Белая граница
                ),
              ),
            ),
            SizedBox(height: 20),

            // Кнопка "Начать сейчас"
            ElevatedButton(
              onPressed: () {
                // Логика входа в систему
              },
              child: Text(
                'Начать сейчас',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,  // Черный текст на кнопке
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,  // Белая кнопка
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Вопрос о необходимости учетной записи
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
            SizedBox(height: 10), // Добавляем пространство перед кнопкой регистрации

            // Кнопка регистрации
            TextButton(
              onPressed: () {
                // Переход на страницу регистрации
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
