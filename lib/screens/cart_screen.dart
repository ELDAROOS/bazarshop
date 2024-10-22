import 'package:flutter/material.dart';
import 'product_model.dart'; // Импортируем модель продукта

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: TextStyle(color: Colors.black)), // Черный текст
        backgroundColor: Colors.white, // Белый фон
      ),
      body: Container(
        color: Colors.white, // Белый фон
        child: cartItems.isEmpty
            ? Center(
          child: Text(
            'Корзина пуста',
            style: TextStyle(fontSize: 24, color: Colors.black), // Черный текст
          ),
        )
            : ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              child: ListTile(
                leading: Image.network(
                  cartItems[index].image,
                  fit: BoxFit.cover,
                  width: 50, // Фиксированная ширина изображения
                  height: 50, // Фиксированная высота изображения
                ),
                title: Text(
                  cartItems[index].productName,
                  style: TextStyle(color: Colors.black), // Черный текст
                ),
                subtitle: Text(
                  'Цена: \$${cartItems[index].productPrice}',
                  style: TextStyle(color: Colors.black), // Черный текст
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
