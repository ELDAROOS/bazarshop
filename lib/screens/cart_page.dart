import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final String jwtToken;  // Параметр для получения jwtToken

  // Добавляем конструктор с jwtToken
  CartPage({required this.jwtToken});

  @override
  Widget build(BuildContext context) {
    // Пример данных корзины, для демонстрации
    List<String> cartItems = []; // Пустая корзина

    return Scaffold(
      backgroundColor: Colors.black, // Черный фон
      appBar: AppBar(
        backgroundColor: Colors.black, // Черный цвет AppBar
        title: Text(
          'Корзина',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Возвращаемся назад
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Логика для открытия поисковика
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Логика для открытия профиля
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Проверка, пуста ли корзина
            cartItems.isEmpty
                ? Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ВАША КОРЗИНА ПУСТА',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Добавленная одежда будет отображаться тут',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemWidget(item: cartItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String item;  // Параметр для товара

  CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white12,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(Icons.shopping_bag, color: Colors.white),
        title: Text(
          item,
          style: TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
          onPressed: () {
            // Логика удаления товара
          },
        ),
      ),
    );
  }
}
