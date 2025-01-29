import 'package:flutter/material.dart';
import 'package:bazarshop/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final String email;  // Добавим поле email, которое передается в запрос
  final String jwtToken;  // Добавим поле для JWT токена

  ProductDetailsScreen({required this.product, required this.email, required this.jwtToken});

  Future<void> _addToCart(BuildContext context) async {
    final url = Uri.parse('http://localhost:8080/api/cart/add');

    // Логируем данные, которые будем отправлять
    final requestData = {
      'email': email,  // Передаем email в запрос
      'productId': product.id,
      'quantity': 1, // Измените по необходимости
    };
    print('Отправляем запрос на добавление в корзину: ${json.encode(requestData)}');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',  // Добавляем JWT токен в заголовок
        },
        body: json.encode(requestData),
      );

      // Логируем весь запрос, включая статус код и тело ответа
      print('Ответ от сервера - Статус: ${response.statusCode}');
      print('Ответ от сервера - Тело: ${response.body}');

      if (response.statusCode == 200) {
        // Если сервер вернул успешный ответ
        var responseData = jsonDecode(response.body);

        // Логируем ответ сервера в консоль
        print('Ответ сервера (успешно): $responseData');

        String serverMessage = responseData['message'] ?? 'Продукт добавлен в корзину';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$serverMessage'),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Отмена',
              onPressed: () {
                // Логика отмены действия
              },
            ),
          ),
        );
      } else {
        // Если сервер вернул ошибку
        var responseData = jsonDecode(response.body);

        // Логируем ошибку в консоль
        print('Ошибка от сервера: $responseData');

        String errorMessage = responseData['error'] ?? 'Ошибка при добавлении в корзину';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,  // Ошибка отображается с красным фоном
          ),
        );
      }
    } catch (error) {
      // Ловим ошибку при запросе
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при добавлении в корзину: $error'),
          backgroundColor: Colors.red,  // Ошибка отображается с красным фоном
        ),
      );

      // Логируем ошибку в консоль
      print('Ошибка при запросе: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('Цена: ${product.price}₽', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('В наличии: ${product.quantity}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Статус: ${product.productStatus}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Категория: ${product.category}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _addToCart(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Цвет кнопки
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            'Добавить в корзину',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
