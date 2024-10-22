import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'profile_screen.dart';
import 'products_screen.dart';
import 'filter_screen.dart'; // Импортируем экран фильтров
import 'cart_screen.dart'; // Импортируем экран корзины

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Индекс текущей вкладки

  final List<Widget> _children = [
    ProductsScreen(), // Экран товаров
    CatalogScreen(),  // Экран каталогов
    CartScreen(cartItems: []), // Экран корзины (передаем пустой список на старте)
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
      backgroundColor: Colors.white, // Белый фон
      body: _children[_currentIndex], // Показываем текущий экран
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // Подсвечиваем текущую вкладку
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black), // Черная иконка
            label: '', // Пустая метка
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Colors.black), // Черная иконка
            label: '', // Пустая метка
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black), // Черная иконка
            label: '', // Пустая метка
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black), // Черная иконка
            label: '', // Пустая метка
          ),
        ],
        showSelectedLabels: false, // Скрыть текстовые метки для выбранных элементов
        showUnselectedLabels: false, // Скрыть текстовые метки для невыбранных элементов
        backgroundColor: Colors.white, // Белый фон для навигационной панели
        selectedItemColor: Colors.black, // Черный цвет для выбранного элемента
        unselectedItemColor: Colors.black54, // Полу-прозрачный черный для невыбранного
      ),
    );
  }
}
