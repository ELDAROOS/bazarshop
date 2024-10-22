import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String gender;

  const CategoryScreen({Key? key, required this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gender == 'women' ? 'Женская Одежда' :
          gender == 'men' ? 'Мужская Одежда' :
          'Детская Одежда',
          style: TextStyle(color: Colors.black), // Черный текст
        ),
        backgroundColor: Colors.white, // Белый фон
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black), // Черная иконка
            onPressed: () {
              // Действие для корзины
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Список одежды для $gender',
          style: TextStyle(fontSize: 24, color: Colors.black), // Черный текст
        ),
      ),
      backgroundColor: Colors.white, // Белый фон
    );
  }
}
