import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String query;

  // Добавляем параметр для получения текста поискового запроса
  SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
          'ПОИСК',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Логика корзины
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            // Поле для ввода поискового запроса
            TextField(
              controller: TextEditingController(text: widget.query),  // Устанавливаем начальный текст
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Что ищете?',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  // Обновляем запрос с каждого изменения
                });
              },
            ),
            SizedBox(height: 20),
            // Показываем запрос
            Text(
              'Результаты поиска для: ${widget.query}',
              style: TextStyle(color: Colors.white),
            ),
            // Результаты поиска

          ],
        ),
      ),
    );
  }
}
