import 'package:flutter/material.dart';
import 'product_model.dart'; // Импортируем модель продукта

class ProductDetailScreen extends StatelessWidget {
  final Product product; // Получаем продукт

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF6F5F0), // Молочный фон
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.image), // Изображение товара
            SizedBox(height: 16),
            Text(
              product.productName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Цена: \$${product.productPrice}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Размер: ${product.productSize}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Цвет: ${product.productColor}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Описание: ${product.description}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
