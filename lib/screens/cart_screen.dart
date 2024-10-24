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
        color: Colors.white,
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
            final item = cartItems[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(
                  item.image,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  item.productName,
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'Цена: \$${item.productPrice}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
