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
  List<String> cartItems = [];

  Future<void> fetchCartItems() async {
    final decodedToken = JwtDecoder.decode(widget.jwtToken);
    final email = decodedToken['email'];

    final url = Uri.parse('http://localhost:8080/api/cart?email=$email');

    print('Отправка GET-запроса по адресу: $url');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.jwtToken}',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> cartItemsFromResponse = data['cartItems'];

        setState(() {
          cartItems = List<String>.from(cartItemsFromResponse.map((item) => item.toString()));
        });
      } else {
        throw Exception('Не удалось загрузить данные корзины');
      }
    } catch (e) {
      print('Ошибка при загрузке корзины: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон
      appBar: AppBar(
        backgroundColor: Colors.white, // Белый фон AppBar
        title: Text(
          'Корзина',
          style: TextStyle(
            color: Colors.black, // Черный текст заголовка
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {},
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
                        color: Colors.black, // Черный текст
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Добавленная одежда будет отображаться тут',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54, // Темный серый текст
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
                  return CartItemWidget(item: cartItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String item;

  CartItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Белый фон карточки
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(Icons.shopping_bag, color: Colors.black), // Черный значок
        title: Text(
          item,
          style: TextStyle(color: Colors.black), // Черный текст
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
          onPressed: () {
            // Логика удаления товара
          },
        ),
      ),
    );
  }
}
