import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final bool isRegistration; // Переменная для определения, регистрация или вход
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthScreen({required this.isRegistration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isRegistration ? 'Регистрация' : 'Вход', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF6F5F0), // Молочный фон
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                onPressed: () {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  // Логика для входа или регистрации
                  if (isRegistration) {
                    // Логика для регистрации
                    print('Регистрация: $email, $password');
                  } else {
                    // Логика для входа
                    print('Вход: $email, $password');
                  }

                  // Возвращаемся назад или переходим на главный экран
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(isRegistration ? 'Зарегистрироваться' : 'Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
