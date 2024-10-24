import 'package:flutter/material.dart';
import 'vhod_screen.dart'; // Импортируем экран входа

class ProfileScreen extends StatelessWidget {
  final bool isGuest; // Переменная для определения, гость ли пользователь
  final String userName; // Имя пользователя
  final String userEmail; // Email пользователя
  final String userPhone; // Телефон пользователя

  ProfileScreen({this.isGuest = true, this.userName = '', this.userEmail = '', this.userPhone = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(color: Colors.black, fontFamily: 'Times New Roman')),
        backgroundColor: Colors.white,
        elevation: 1, // Легкая тень для выделения AppBar
      ),
      body: Container(
        color: Colors.white, // Белый цвет фона
        padding: const EdgeInsets.all(16.0),
        child: isGuest ? _buildGuestProfile(context) : _buildUserProfile(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Информация о пользователе',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black, fontFamily: 'Times New Roman'),
        ),
        SizedBox(height: 20),
        _buildListTile('Имя', userName.isNotEmpty ? userName : 'Ваше имя'),
        _buildListTile('Email', userEmail.isNotEmpty ? userEmail : 'your.email@example.com'),
        _buildListTile('Телефон', userPhone.isNotEmpty ? userPhone : '+1 (234) 567-8901'),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Логика выхода из аккаунта
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
            },
          ),
        ),
        Divider(color: Colors.black), // Черная линия разделителя
      ],
    );
  }
}
