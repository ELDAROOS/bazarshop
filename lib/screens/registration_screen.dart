import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF6F5F0), // Молочный фон
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  labelText: 'Имя',
                  hintText: 'Введите ваше имя',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: 'Фамилия',
                  hintText: 'Введите вашу фамилию',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Возраст',
                  hintText: 'Введите ваш возраст',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // Числовой ввод для возраста
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Мужчина'),
                      leading: Radio<String>(
                        value: 'M',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          _gender = value;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Женщина'),
                      leading: Radio<String>(
                        value: 'F',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          _gender = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Логика обработки регистрации
                  String firstname = _firstnameController.text;
                  String lastname = _lastnameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String age = _ageController.text;

                  // Проверка полей и дальнейшая логика регистрации
                  if (firstname.isNotEmpty &&
                      lastname.isNotEmpty &&
                      email.isNotEmpty &&
                      password.isNotEmpty &&
                      age.isNotEmpty &&
                      _gender != null) {
                    // Здесь вы можете добавить свою логику для регистрации
                    print('Регистрация успешна: $firstname $lastname, $email, $age, $_gender');
                    Navigator.pop(context); // Возвращаемся назад
                  } else {
                    // Обработка ошибок
                    print('Пожалуйста, заполните все поля');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
