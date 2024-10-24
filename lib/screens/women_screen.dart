import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Импортируем экран корзины
import 'profile_screen.dart'; // Импортируем экран профиля
import 'search_screen.dart'; // Импортируем экран поиска
import 'product_model.dart'; // Импортируем модель продукта

class WomenScreen extends StatefulWidget {
  @override
  _WomenScreenState createState() => _WomenScreenState();
}

class _WomenScreenState extends State<WomenScreen> {
  int _selectedIndex = 0;
  final List<Product> cartItems = []; // Корзина изначально пустая

  // Пример списка товаров для женщин
  final List<Product> products = [
    Product(
      productId: 1,
      productName: 'Женская футболка',
      productPrice: 25.0,
      description: 'Удобная женская футболка',
      image: 'https://example.com/women_tshirt.jpg',
      productSize: 'M',
      productColor: 'Розовый',
      categoryId: 2,
    ),
    // Добавьте больше товаров, если нужно
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем индекс текущего выбранного элемента
    });

    switch (index) {
      case 0:
      // Переход на экран поиска
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
        break;
      case 1:
      // Логика для ленты товаров (можно добавить)
        break;
      case 2:
      // Переход на экран корзины
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems)),
        );
        break;
      case 3:
      // Переход на экран профиля
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  void _addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Женский', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.productName),
              subtitle: Text('Цена: \$${product.productPrice}'),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () => _addToCart(product), // Добавляем товар в корзину
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Лента',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Используем метод для обработки нажатия
      ),
    );
  }
}
