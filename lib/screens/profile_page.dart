import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Импортируем библиотеку для декодирования токена
import 'card_add_page.dart';  // Экран добавления карты

class ProfilePage extends StatefulWidget {
  final String jwtToken;  // Токен для авторизации
  final String email;     // Email пользователя

  ProfilePage({
    Key? key,
    required this.jwtToken,
    required this.email,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> savedCards = [
    '**** **** **** 1234',
    '**** **** **** 5678',
  ];

  // Функция для извлечения имени пользователя из JWT
  String getUserName() {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.jwtToken);
      print('Токен пользователя: ${widget.jwtToken}');  // Логирование токена

      String userName = decodedToken['sub'] ?? 'Неизвестный'; // Получаем имя из токена (field 'sub')
      print('Имя пользователя из токена: $userName'); // Логирование имени
      return userName;
    } catch (e) {
      print('Ошибка получения имени: $e'); // Логирование ошибки
      return 'Ошибка получения имени'; // Если токен некорректный
    }
  }

  // Функция для извлечения email из JWT
  String getUserEmail() {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.jwtToken);
      String userEmail = decodedToken['email'] ?? 'Неизвестный email'; // Получаем email из токена (field 'email')
      print('Email пользователя из токена: $userEmail'); // Логирование email
      return userEmail;
    } catch (e) {
      print('Ошибка получения email: $e'); // Логирование ошибки
      return 'Ошибка получения email'; // Если токен некорректный
    }
  }

  // Функция для добавления карты в список с отображением только последних 4 цифр
  void addCard(String cardNumber) {
    setState(() {
      // Форматируем карту, оставляя только последние 4 цифры
      String formattedCard = '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
      savedCards.add(formattedCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    String userName = getUserName(); // Получаем имя пользователя
    String userEmail = getUserEmail(); // Получаем email пользователя

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/icons/back.png', fit: BoxFit.cover, width: 24, height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 80, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ваши данные:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Text('Имя: $userName', style: TextStyle(fontSize: 18, color: Colors.black)), // Имя пользователя
            Text('Email: $userEmail', style: TextStyle(fontSize: 18, color: Colors.black)), // Email пользователя
            SizedBox(height: 30),

            Text('Привязанные карты:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            if (savedCards.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: savedCards.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      title: Text(savedCards[index], style: TextStyle(color: Colors.black)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            savedCards.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              )
            else
              Text('У вас нет привязанных карт.', style: TextStyle(color: Colors.grey)),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                // Переход на экран добавления карты и передача функции для добавления карты
                final cardNumber = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardAddPage(
                      jwtToken: widget.jwtToken,
                      onCardAdded: addCard, // Передаем функцию
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text('Добавить карту', style: TextStyle(fontSize: 16)),
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
