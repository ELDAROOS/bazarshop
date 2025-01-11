import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Expanded(
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
            ),
            // Если корзина не пуста, можно добавить товары
            // Пример:
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: cartItems.length,
            //     itemBuilder: (context, index) {
            //       return CartItemWidget(item: cartItems[index]);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
