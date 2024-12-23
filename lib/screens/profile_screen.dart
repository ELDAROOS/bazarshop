// lib/profile_screen.dart

import 'package:flutter/material.dart';
import 'vhod_screen.dart'; // Экран входа
import 'api_service.dart'; // Импортируем файл с API

class ProfileScreen extends StatefulWidget {
  final bool isGuest; // Переменная для определения, гость ли пользователь
  final String email; // Email пользователя
  final String password; // Пароль пользователя

  ProfileScreen({
    this.isGuest = true,
    this.email = '', // Значение по умолчанию пустое
    this.password = '', // Значение по умолчанию пустое
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, String>> userData;

  @override
  void initState() {
    super.initState();
    if (!widget.isGuest && widget.email.isNotEmpty && widget.password.isNotEmpty) {
      // Если не гость, и email и password не пустые, загружаем данные пользователя
      userData = fetchUserProfile(widget.email, widget.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Профиль',
          style: TextStyle(color: Colors.black, fontFamily: 'Times New Roman'),
        ),
        backgroundColor: Colors.white,
        elevation: 1, // Легкая тень для выделения AppBar
      ),
      body: Container(
        color: Colors.white, // Белый цвет фона
        padding: const EdgeInsets.all(16.0),
        child: widget.isGuest ? _buildGuestProfile(context) : _buildUserProfile(),
      ),
    );
  }

  Widget _buildGuestProfile(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Вы не вошли в аккаунт.',
            style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Times New Roman'),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Пожалуйста, войдите в свой аккаунт, чтобы получить доступ к полному функционалу.',
            style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Times New Roman'),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Переход на экран входа
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => VhodScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // Черный фон кнопки
              foregroundColor: Colors.white, // Белый текст
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.black), // Черная рамка
              ),
            ),
            child: Text('Войти', style: TextStyle(fontFamily: 'Times New Roman')),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return FutureBuilder<Map<String, String>>(
      future: userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка загрузки данных профиля.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Данные отсутствуют.'));
        } else {
          final user = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Информация о пользователе',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black, fontFamily: 'Times New Roman'),
              ),
              SizedBox(height: 20),
              _buildListTile('Имя', user['userName']!),
              _buildListTile('Email', user['userEmail']!),
              _buildListTile('Телефон', user['userPhone']!),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Логика выхода из аккаунта
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VhodScreen()), // Выход и переход на экран входа
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Черный фон кнопки
                    foregroundColor: Colors.white, // Белый текст
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black), // Черная рамка
                    ),
                  ),
                  child: Text('Выйти из аккаунта', style: TextStyle(fontFamily: 'Times New Roman')),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(color: Colors.black, fontFamily: 'Times New Roman')),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey, fontFamily: 'Times New Roman')),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Логика редактирования
              _editProfile(title);
            },
          ),
        ),
        Divider(color: Colors.black), // Черная линия разделителя
      ],
    );
  }

  // Заглушка для редактирования профиля
  void _editProfile(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedValue = '';
        return AlertDialog(
          title: Text('Редактировать $title'),
          content: TextField(
            onChanged: (value) {
              updatedValue = value;
            },
            decoration: InputDecoration(hintText: 'Введите новое $title'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Сохранить'),
              onPressed: () {
                setState(() {
                  if (title == 'Имя') {
                    // Обновить имя
                  } else if (title == 'Email') {
                    // Обновить email
                  } else if (title == 'Телефон') {
                    // Обновить телефон
                  }
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
