import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'profile_screen.dart';
import 'products_screen.dart';
import 'filter_screen.dart'; // Импортируем экран фильтров

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Индекс текущей вкладки

  final List<Widget> _children = [
    ProductsScreen(), // Экран товаров
    CatalogScreen(),  // Экран каталогов
    ProfileScreen(),  // Экран профиля
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Обновляем текущий индекс
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F5F0), // Молочный фон
      body: _children[_currentIndex], // Показываем текущий экран
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // Подсвечиваем текущую вкладку
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Каталоги',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
