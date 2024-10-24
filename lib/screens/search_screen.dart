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
  String _selectedBrand = 'Все';
  double _minPrice = 0;
  double _maxPrice = 100; // Предположим, максимальная цена 100
  double _selectedRating = 0; // Рейтинг от 0 до 5

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
      final matchesBrand = _selectedBrand == 'Все' || product.categoryId == getCategoryId(_selectedBrand);
      final matchesPrice = product.productPrice >= _minPrice && product.productPrice <= _maxPrice;
      final matchesRating = product.productPrice >= _selectedRating; // Здесь нужно будет задать рейтинг для продуктов

      return matchesSearchQuery && matchesSize && matchesColor && matchesBrand && matchesPrice && matchesRating;
    }).toList();
  }

  int getCategoryId(String brand) {
    switch (brand) {
      case 'Мужское':
        return 1;
      case 'Женское':
        return 2;
      case 'Подростковое':
        return 3;
      default:
        return 0; // Неопределённый бренд
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
            Text('Фильтры:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            _buildFilter('Размер', _selectedSize, ['Все', 'S', 'M', 'L', 'XL'], (value) {
              setState(() {
                _selectedSize = value!;
              });
            }),
            _buildFilter('Цвет', _selectedColor, ['Все', 'Синий', 'Розовый', 'Зеленый'], (value) {
              setState(() {
                _selectedColor = value!;
              });
            }),
            _buildFilter('Бренд', _selectedBrand, ['Все', 'Мужское', 'Женское', 'Подростковое'], (value) {
              setState(() {
                _selectedBrand = value!;
              });
            }),
            _buildPriceFilter(),
            _buildRatingFilter(),
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

  Widget _buildFilter(String label, String selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: selectedValue,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
          underline: SizedBox(), // Убираем стандартную линию под DropdownButton
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Цена (от - до)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        RangeSlider(
          values: RangeValues(_minPrice, _maxPrice),
          min: 0,
          max: 100, // Предположим, максимальная цена 100
          divisions: 10,
          labels: RangeLabels('\$${_minPrice.toStringAsFixed(0)}', '\$${_maxPrice.toStringAsFixed(0)}'),
          onChanged: (values) {
            setState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
            });
          },
          activeColor: Colors.black, // Цвет ползунка
          inactiveColor: Colors.grey, // Цвет неактивного ползунка
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Рейтинг', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Slider(
          value: _selectedRating,
          min: 0,
          max: 5,
          divisions: 5,
          label: _selectedRating.toString(),
          onChanged: (value) {
            setState(() {
              _selectedRating = value;
            });
          },
          activeColor: Colors.black, // Цвет ползунка
          inactiveColor: Colors.grey, // Цвет неактивного ползунка
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
