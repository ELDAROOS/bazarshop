import 'package:flutter/material.dart';
import 'catalog_screen.dart'; // Импортируйте экран каталога
import 'cart_screen.dart'; // Импортируйте экран корзины
import 'profile_screen.dart'; // Импортируйте экран профиля

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Индекс выбранной страницы

  final List<Widget> _screens = [
    CatalogScreen(), // Экран каталога
    CartScreen(cartItems: []), // Экран корзины
    ProfileScreen(), // Экран профиля
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Изменение индекса при нажатии на элемент
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BAZAR', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: _screens[_selectedIndex], // Отображение текущего экрана
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront, color: Colors.black),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex, // Выбранный индекс
        selectedItemColor: Colors.black, // Цвет выбранного элемента
        unselectedItemColor: Colors.grey, // Цвет невыбранных элементов
        onTap: _onItemTapped, // Обработчик нажатий
      ),
    );
  }
}
