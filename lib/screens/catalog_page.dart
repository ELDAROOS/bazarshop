import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bazarshop/models/product.dart';

class CatalogPage extends StatefulWidget {
  final String jwtToken;  // Добавляем параметр для получения jwtToken

  CatalogPage({required this.jwtToken});  // Обязательный параметр

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String category = 'Женщины';

  // Метод для загрузки товаров с использованием jwtToken
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('http://localhost:8080/api/product');

    // Логируем отправляемый запрос
    print("Отправка запроса на URL: $url");

    // Отправляем запрос с токеном в заголовке
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.jwtToken}', // Используем токен для аутентификации
    });

    // Логируем ответ
    print("Ответ от сервера: Статус код: ${response.statusCode}");
    print("Тело ответа: ${response.body}");
    

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Не удалось загрузить товары');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Каталог',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Кнопка "Женщины"
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: category == 'Женщины' ? 130 : 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        category = 'Женщины';
                      });
                    },
                    child: Text(
                      'Женщины',
                      style: TextStyle(
                        color: category == 'Женщины' ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category == 'Женщины'
                          ? Colors.black
                          : Colors.white,
                      side: BorderSide(
                        color: category == 'Женщины'
                            ? Colors.black
                            : Colors.white.withOpacity(0.2),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                // Кнопка "Мужчины"
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: category == 'Мужчины' ? 130 : 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        category = 'Мужчины';
                      });
                    },
                    child: Text(
                      'Мужчины',
                      style: TextStyle(
                        color: category == 'Мужчины' ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category == 'Мужчины'
                          ? Colors.black
                          : Colors.white,
                      side: BorderSide(
                        color: category == 'Мужчины'
                            ? Colors.black
                            : Colors.white.withOpacity(0.2),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Загружаем список товаров с API
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Ошибка загрузки данных'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Нет товаров'));
                  } else {
                    final products = snapshot.data!;
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(product.description,
                                style: TextStyle(fontSize: 14)),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                            onTap: () {
                              // Переход на страницу товара
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
