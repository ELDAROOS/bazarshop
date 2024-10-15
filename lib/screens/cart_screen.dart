import 'package:flutter/material.dart';
import 'product_model.dart'; // Импортируем модель продукта

class CartScreen extends StatelessWidget {
  final List<Product> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF6F5F0), // Молочный цвет фона
        child: cartItems.isEmpty
            ? Center(
          child: Text(
            'Корзина пуста',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        )
            : ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(cartItems[index].image),
                title: Text(cartItems[index].productName),
                subtitle: Text('Цена: \$${cartItems[index].productPrice}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
