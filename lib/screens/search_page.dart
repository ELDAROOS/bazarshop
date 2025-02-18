import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_details_screen.dart';
import 'package:bazarshop/models/product.dart';

class SearchPage extends StatefulWidget {
  final String jwtToken; // JWT токен для авторизации
  final String query; // Строка поиска
  final String email; // Добавляем email

  const SearchPage({Key? key, required this.jwtToken, required this.query, required this.email}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late List<Product> _allItems = []; // Полный список товаров
  late List<Product> _filteredItems = []; // Отфильтрованные товары
  String _searchQuery = ""; // Текущий запрос
  bool _isLoading = false; // Флаг загрузки

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.query;
    _searchController = TextEditingController(text: _searchQuery);
    _loadData();
  }

  // Загрузка данных с сервера
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://localhost:8080/api/product/all');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer ${widget.jwtToken}', // Авторизация через JWT
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _allItems = jsonData.map((item) => Product.fromJson(item)).toList();
          _filterItems();
        });
      } else {
        print('Ошибка: ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка загрузки данных: $e');
      // Обработка ошибки
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Фильтрация товаров по запросу
  void _filterItems() {
    setState(() {
      _filteredItems = _allItems.where((product) {
        return product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  // Обработка изменения текста поиска
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _filterItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Поиск',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Иконка назад
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Поисковое поле
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Что ищете?',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            SizedBox(height: 16),
            // Индикатор загрузки
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
            // Список результатов поиска
              Expanded(
                child: _filteredItems.isEmpty
                    ? Center(
                  child: Text(
                    'Ничего не найдено',
                    style: TextStyle(fontSize: 18),
                  ),
                )
                    : ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (context, index) {
                    final product = _filteredItems[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Цена: ${product.price}₽'),
                      onTap: () {
                        // Переход к деталям товара с передачей email
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              product: product,
                              email: widget.email,  // Передаем email
                              jwtToken: widget.jwtToken,  // Передаем jwtToken
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
