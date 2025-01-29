import 'package:flutter/material.dart';
import 'card_add_page.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String jwtToken; // Токен для авторизации

  const ProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.jwtToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Здесь будут данные карты (в реальном приложении вы будете хранить их в базе данных)
    List<String> savedCards = [
      '**** **** **** 1234',
      '**** **** **** 5678',
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Фон страницы белый
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png', // Путь к изображению
            fit: BoxFit.cover,
            width: 24, // Устанавливаем размер иконки
            height: 24,
          ),
          onPressed: () {
            // Логика для выхода из профиля (например, переход на экран входа)
            Navigator.of(context).pop(); // Возвращаемся назад
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Аватарка и данные пользователя
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ваши данные:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text('Имя: $name', style: TextStyle(fontSize: 18, color: Colors.black)),
            Text('Email: $email', style: TextStyle(fontSize: 18, color: Colors.black)),
            SizedBox(height: 30),

            // Раздел привязанных карт
            Text(
              'Привязанные карты:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            if (savedCards.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: savedCards.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[200], // Белый фон для карт
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      title: Text(savedCards[index], style: TextStyle(color: Colors.black)),
                      trailing: Icon(Icons.delete, color: Colors.black),
                    ),
                  );
                },
              )
            else
              Text(
                'У вас нет привязанных карт.',
                style: TextStyle(color: Colors.grey),
              ),
            SizedBox(height: 20),

            // Кнопка для добавления карты
            ElevatedButton(
              onPressed: () {
                // Открытие страницы добавления карты
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardAddPage(jwtToken: jwtToken),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Белый фон кнопки
                foregroundColor: Colors.black, // Черный текст на кнопке
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Скругленные углы
                ),
              ),
              child: Text('Добавить карту', style: TextStyle(fontSize: 16)),
            ),

            // Spacer для равномерного распределения элементов
            Spacer(),

            // Кнопка "Выйти" (перемещена в appBar)
            // Эта кнопка теперь не нужна, так как она уже реализована в AppBar
          ],
        ),
      ),
    );
  }
}
