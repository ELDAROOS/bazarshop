import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Импортируем экран приветствия

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
        title: Text('Профиль', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF6F5F0), // Молочный цвет фона
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
            'Вы вошли как гость.',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Переход на экран приветствия
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Белый фон кнопки
              foregroundColor: Colors.black, // Черный текст
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.black), // Черная рамка
              ),
            ),
            child: Text('Войти'),
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Имя', style: TextStyle(color: Colors.black)),
          subtitle: Text(userName.isNotEmpty ? userName : 'Ваше имя', style: TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Логика редактирования имени
            },
          ),
        ),
        Divider(color: Colors.black), // Черная линия разделителя
        ListTile(
          title: Text('Email', style: TextStyle(color: Colors.black)),
          subtitle: Text(userEmail.isNotEmpty ? userEmail : 'your.email@example.com', style: TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Логика редактирования email
            },
          ),
        ),
        Divider(color: Colors.black), // Черная линия разделителя
        ListTile(
          title: Text('Телефон', style: TextStyle(color: Colors.black)),
          subtitle: Text(userPhone.isNotEmpty ? userPhone : '+1 (234) 567-8901', style: TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Логика редактирования телефона
            },
          ),
        ),
        Divider(color: Colors.black), // Черная линия разделителя
        // Кнопка для выхода из аккаунта
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Логика выхода из аккаунта
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Белый фон кнопки
              foregroundColor: Colors.black, // Черный текст
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.black), // Черная рамка
              ),
            ),
            child: Text('Выйти из аккаунта'),
          ),
        ),
      ],
    );
  }
}
