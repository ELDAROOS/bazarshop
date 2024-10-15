import 'package:flutter/material.dart';
import 'filter_screen.dart'; // Импортируем экран фильтров

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F5F0), // Молочный фон
      appBar: AppBar(
        title: Text('Товары', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Действие для корзины
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Поле поиска и кнопка фильтров
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск товаров...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black), // Черная рамка
                      ),
                      filled: true,
                      fillColor: Colors.white, // Белый фон
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Переход на экран фильтров
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Белый фон кнопки
                    foregroundColor: Colors.black, // Черный текст
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Фильтры'),
                ),
              ],
            ),
          ),
          // Здесь можно добавить отображение товаров
          Expanded(
            child: Center(
              child: Text('Список товаров', style: TextStyle(fontSize: 24, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
