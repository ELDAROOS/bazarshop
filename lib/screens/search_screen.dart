import 'package:flutter/material.dart';
import 'product_model.dart'; // Импорт модели продукта

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String _selectedSize = 'Все';
  String _selectedColor = 'Все';
  String _selectedType = 'Все';
  bool _isFilterVisible = false;
  late AnimationController _animationController;
  late Animation<double> _filterPanelAnimation;

  List<Product> allProducts = [
    Product(productId: 1, productName: 'Мужская футболка', productPrice: 20.0, description: 'Удобная футболка', image: 'https://static.bershka.net/4/photos2/2024/V/0/2/p/2842/443/250/2842443250_1_1_0.jpg?imwidth=1080&ts=1704200746199', productSize: 'M', productColor: 'Синий', categoryId: 1),
    Product(productId: 2, productName: 'Женская футболка', productPrice: 25.0, description: 'Красивая футболка', image: 'https://static.bershka.net/assets/public/28d0/5785/d06446b0ad1a/6b60d268ba2e/06640730776-a2d/06640730776-a2d.jpg?ts=1727337626675&w=750', productSize: 'L', productColor: 'Розовый', categoryId: 2),
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
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _filterPanelAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFilterPanel() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
      _isFilterVisible ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Установили белый фон
      appBar: AppBar(
        title: Text('Поиск', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Поиск по названию',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,  // Белый фон для поля ввода
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.black),
                  onPressed: _toggleFilterPanel,
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _filterPanelAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildDropdown('Размер', _selectedSize, ['Все', 'S', 'M', 'L', 'XL'], (value) {
                    setState(() {
                      _selectedSize = value!;
                    });
                  }),
                  SizedBox(height: 8),
                  _buildDropdown('Цвет', _selectedColor, ['Все', 'Синий', 'Розовый', 'Зеленый'], (value) {
                    setState(() {
                      _selectedColor = value!;
                    });
                  }),
                  SizedBox(height: 8),
                  _buildDropdown('Тип', _selectedType, ['Все', 'Мужское', 'Женское', 'Подростковое'], (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  }),
                ],
              ),
            ),
          ),
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
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            icon: Icon(Icons.arrow_drop_down),
            underline: SizedBox(),
            items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
