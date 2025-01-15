import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bazarshop/models/product.dart';
import 'package:bazarshop/screens/product_details_screen.dart'; // Импортируем экран с деталями товара

class CatalogPage extends StatefulWidget {
  final String jwtToken;  // Добавляем параметр для получения jwtToken
  final String email; // Добавляем параметр для передачи email

  CatalogPage({required this.jwtToken, required this.email});  // Обязательные параметры

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String category = 'Женщины';

  // Метод для загрузки товаров с использованием jwtToken
  Future<List<Product>> fetchProducts() async {
    try {
      final url = Uri.parse('http://localhost:8080/api/product');
      print("Отправка запроса на URL: $url");

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.jwtToken}', // JWT-токен
      });

      print("Ответ от сервера: ${response.statusCode}");
      print("Тело ответа: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Парсинг JSON успешен: $data");

        return data.map((json) {
          // Преобразуем JSON в объект Product с учётом возможного null
          return Product.fromJson(json ?? {});
        }).toList();
      } else {
        throw Exception('HTTP ошибка: ${response.statusCode}');
      }
    } catch (e) {
      print("Ошибка в fetchProducts: $e");
      throw Exception('Ошибка загрузки данных: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Каталог',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
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
                            onTap: () async {
                              try {
                                // Динамическое формирование URL для каждого товара
                                final url = Uri.parse('http://localhost:8080/api/product/${product.id}');

                                // Принт в консоль: показываем URL, по которому отправляется запрос
                                print("Отправляем запрос на URL: $url");

                                // Отправка GET запроса с динамически сформированным URL
                                final response = await http.get(
                                  url,
                                  headers: {
                                    'Authorization': 'Bearer ${widget.jwtToken}',  // JWT-токен
                                  },
                                );

                                // Принт в консоль: показываем статус ответа от сервера
                                print("Ответ от сервера: ${response.statusCode}");
                                print("Тело ответа: ${response.body}");

                                if (response.statusCode == 200) {
                                  final productDetails = json.decode(response.body);

                                  // Переход на экран с деталями товара, передав данные о товаре и email
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(
                                        product: Product.fromJson(productDetails),
                                        email: widget.email,  // Передаем email
                                        jwtToken: widget.jwtToken,  // Передаем jwtToken
                                      ),
                                    ),
                                  );

                                } else {
                                  // Обработка ошибки, если GET запрос не успешен
                                  print('Ошибка загрузки данных: ${response.statusCode}');
                                }
                              } catch (e) {
                                print('Ошибка при запросе данных о товаре: $e');
                              }
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
