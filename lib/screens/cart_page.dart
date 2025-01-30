import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

class CartPage extends StatefulWidget {
  final String jwtToken;

  CartPage({required this.jwtToken});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  Future<void> fetchCartItems() async {
    final decodedToken = JwtDecoder.decode(widget.jwtToken);
    final email = decodedToken['email'];

    final url = Uri.parse('http://localhost:8080/api/cart?email=$email');

    // Логируем URL и заголовки запроса
    print('Отправка GET-запроса на URL: $url');
    print('Заголовки запроса: {Authorization: Bearer ${widget.jwtToken}}');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.jwtToken}',
      });

      // Логируем статус и тело ответа
      print('Ответ от сервера - Статус: ${response.statusCode}');
      print('Ответ от сервера - Тело: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('items') && data['items'] != null && data['items'] is List) {
          final List<dynamic> cartItemsFromResponse = data['items'];

          setState(() {
            cartItems = List<Map<String, dynamic>>.from(
              cartItemsFromResponse.map((item) => item as Map<String, dynamic>),
            );
          });
        } else {
          print('Ошибка: items не найдено или не является списком');
        }
      } else {
        print('Ошибка от сервера: ${response.body}');
        throw Exception('Не удалось загрузить данные корзины');
      }
    } catch (e) {
      print('Ошибка при загрузке корзины: $e');
    }
  }


  Future<void> removeItemFromCart(String productId) async {
    final decodedToken = JwtDecoder.decode(widget.jwtToken);
    final email = decodedToken['email'];

    final url = Uri.parse('http://localhost:8080/api/cart/remove?email=$email&productId=$productId');

    try {
      final response = await http.delete(url, headers: {
        'Authorization': 'Bearer ${widget.jwtToken}',
      });

      if (response.statusCode == 200) {
        setState(() {
          cartItems.removeWhere((item) => item['id'] == productId);
        });
      } else {
        print('Ошибка при удалении товара: ${response.body}');
      }
    } catch (e) {
      print('Ошибка при удалении товара из корзины: $e');
    }
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item['price'] ?? 0.0;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Корзина',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Image.asset('assets/icons/back.png', width: 24, height: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/search.png', width: 24, height: 24),
            onPressed: () {
              // Действие для кнопки поиска
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/profile.png', width: 24, height: 24),
            onPressed: () {
              // Действие для кнопки профиля
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            cartItems.isEmpty
                ? Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ВАША КОРЗИНА ПУСТА',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Добавленная одежда будет отображаться тут',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemWidget(
                    item: item,
                    onRemove: () {
                      removeItemFromCart(item['id']);
                    },
                  );
                },
              ),
            ),
            if (cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Итог: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${calculateTotal().toStringAsFixed(2)} ₽',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;

  CartItemWidget({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: item['image'] != null
            ? Image.network(
          item['image'],
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        )
            : Icon(Icons.shopping_bag, color: Colors.black),
        title: Text(
          item['name'] ?? 'Товар',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${item['price']} ₽',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
          onPressed: onRemove, // Передаем действие удаления
        ),
      ),
    );
  }
}
