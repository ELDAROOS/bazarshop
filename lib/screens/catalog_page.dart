import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bazarshop/models/product.dart';
import 'package:bazarshop/screens/product_details_screen.dart'; // Экран с деталями товара
import 'package:bazarshop/screens/search_page.dart'; // Экран поиска
import 'package:bazarshop/screens/profile_page.dart'; // Экран профиля
import 'cart_page.dart';
import 'search_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Импортируем библиотеку для работы с JWT

class CatalogPage extends StatefulWidget {
  final String jwtToken;
  final String email;

  CatalogPage({required this.jwtToken, required this.email});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String category = 'Женщины';  // Начальная категория
  int _selectedIndex = 0; // Переменная для отслеживания текущего индекса выбранной кнопки

  // Метод для извлечения email из JWT токена
  String extractEmailFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['email'] ?? ''; // Извлекаем email пользователя из токена
    } catch (e) {
      return ''; // Если ошибка при декодировании
    }
  }

  // Метод для загрузки товаров с использованием jwtToken
  Future<List<Product>> fetchProducts() async {
    try {
      final url = Uri.parse('http://localhost:8080/api/product/all');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.jwtToken}', // JWT-токен
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);  // Декодируем ответ в список

        // Фильтруем товары по выбранному полу
        List<Product> filteredProducts = data
            .map((json) => Product.fromJson(json))  // Преобразуем каждый элемент в объект Product
            .where((product) {
          if (category == 'Женщины') {
            return product.gender == 'FEMALE';  // Отображаем только женские товары
          } else if (category == 'Мужчины') {
            return product.gender == 'MALE';  // Отображаем только мужские товары
          }
          return true;  // Если категория не выбрана, показываем все товары
        })
            .toList();

        return filteredProducts;  // Возвращаем отфильтрованный список товаров
      } else {
        throw Exception('Ошибка загрузки товаров: ${response.statusCode}');
      }
    } catch (e) {
      print("Ошибка в fetchProducts: $e");
      throw Exception('Ошибка загрузки данных: $e');
    }
  }

  // Функция для обработки нажатий на кнопки нижнего HUD-бара
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Переход на страницу поиска
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage(jwtToken: widget.jwtToken, query: '', email: '',)),
      );
    } else if (index == 1) {
      // Извлекаем email перед переходом в профиль
      String email = extractEmailFromToken(widget.jwtToken);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            jwtToken: widget.jwtToken,
            email: email,  // Передаем email в профиль
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage(jwtToken: widget.jwtToken)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/back.png', width: 24, height: 24),
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
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      category = 'Женщины';  // Выбрали категорию "Женщины"
                    });
                  },
                  child: Text(
                    'Женщины',
                    style: TextStyle(
                      color: category == 'Женщины' ? Colors.white : Colors.black,  // Устанавливаем белый текст для выбранной категории
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: category == 'Женщины' ? Colors.black : Colors.white,  // Черный фон для выбранной категории
                    side: BorderSide(
                      color: category == 'Женщины' ? Colors.black : Colors.black.withOpacity(0.2),  // Черная рамка для выбранной категории
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      category = 'Мужчины';  // Выбрали категорию "Мужчины"
                    });
                  },
                  child: Text(
                    'Мужчины',
                    style: TextStyle(
                      color: category == 'Мужчины' ? Colors.white : Colors.black,  // Устанавливаем белый текст для выбранной категории
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: category == 'Мужчины' ? Colors.black : Colors.white,  // Черный фон для выбранной категории
                    side: BorderSide(
                      color: category == 'Мужчины' ? Colors.black : Colors.black.withOpacity(0.2),  // Черная рамка для выбранной категории
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Ошибка загрузки данных: ${snapshot.error}'));
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
                          elevation: 2,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,  // Текст черного цвета
                              ),
                            ),
                            subtitle: Text(
                              product.description,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                            onTap: () async {
                              try {
                                final url = Uri.parse('http://localhost:8080/api/product/${product.id}');
                                final response = await http.get(url, headers: {
                                  'Authorization': 'Bearer ${widget.jwtToken}',
                                });

                                if (response.statusCode == 200) {
                                  final productDetails = json.decode(response.body);
                                  String email = extractEmailFromToken(widget.jwtToken); // Извлекаем email

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(
                                        product: Product.fromJson(productDetails),
                                        email: email,  // Передаем email в ProductDetailsScreen
                                        jwtToken: widget.jwtToken,
                                      ),
                                    ),
                                  );
                                } else {
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/search.png', width: 24, height: 24),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile.png', width: 24, height: 24),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/cart.png', width: 24, height: 24),
            label: 'Корзина',
          ),
        ],
      ),
    );
  }
}
