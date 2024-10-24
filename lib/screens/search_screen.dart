import 'package:flutter/material.dart';
import 'product_model.dart'; // Импортируем модель продукта

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  String _selectedSize = 'Все';
  String _selectedColor = 'Все';
  String _selectedType = 'Все';

  List<Product> allProducts = [
    // Пример всех продуктов, включая мужчин, женщин и подростков
    Product(
      productId: 1,
      productName: 'Мужская футболка',
      productPrice: 20.0,
      description: 'Удобная мужская футболка',
      image: 'https://example.com/mens_tshirt.jpg',
      productSize: 'M',
      productColor: 'Синий',
      categoryId: 1,
    ),
    Product(
      productId: 2,
      productName: 'Женская футболка',
      productPrice: 25.0,
      description: 'Удобная женская футболка',
      image: 'https://example.com/womens_tshirt.jpg',
      productSize: 'L',
      productColor: 'Розовый',
      categoryId: 2,
    ),
    Product(
      productId: 3,
      productName: 'Подростковая футболка',
      productPrice: 22.0,
      description: 'Удобная подростковая футболка',
      image: 'https://example.com/teen_tshirt.jpg',
      productSize: 'S',
      productColor: 'Зеленый',
      categoryId: 3,
    ),
    // Добавьте больше товаров, если нужно
  ];

  List<Product> get filteredProducts {
    return allProducts.where((product) {
      final matchesSearchQuery = product.productName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSize = _selectedSize == 'Все' || product.productSize == _selectedSize;
      final matchesColor = _selectedColor == 'Все' || product.productColor == _selectedColor;
      final matchesType = _selectedType == 'Все' || product.categoryId == getCategoryId(_selectedType);

      return matchesSearchQuery && matchesSize && matchesColor && matchesType;
    }).toList();
  }

  int getCategoryId(String type) {
    switch (type) {
      case 'Мужское':
        return 1;
      case 'Женское':
        return 2;
      case 'Подростковое':
        return 3;
      default:
        return 0; // Неопределённый тип
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Поиск по названию',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedSize,
                  items: ['Все', 'S', 'M', 'L', 'XL']
                      .map((size) => DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSize = value!;
                    });
                  },
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _selectedColor,
                  items: ['Все', 'Синий', 'Розовый', 'Зеленый']
                      .map((color) => DropdownMenuItem<String>(
                    value: color,
                    child: Text(color),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedColor = value!;
                    });
                  },
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _selectedType,
                  items: ['Все', 'Мужское', 'Женское', 'Подростковое']
                      .map((type) => DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(product.productName),
                      subtitle: Text('Цена: \$${product.productPrice}'),
                    ),
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
