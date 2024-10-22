import 'package:flutter/material.dart';
import 'filter_screen.dart'; // Импортируем экран фильтров
import 'product_model.dart'; // Импортируем модель продукта
import 'cart_screen.dart'; // Импортируем экран корзины
import 'product_card.dart'; // Импортируем карточку товара

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> cartItems = []; // Список товаров в корзине

  // Пример товаров
  final List<Product> products = [
    Product(
      productId: 1,
      productName: 'Товар 1',
      productPrice: 10.0,
      description: 'Описание товара 1',
      image: 'https://via.placeholder.com/150',
      productSize: 'M',
      productColor: 'Красный',
      categoryId: 1,
    ),
    Product(
      productId: 2,
      productName: 'Товар 2',
      productPrice: 15.0,
      description: 'Описание товара 2',
      image: 'https://via.placeholder.com/150',
      productSize: 'L',
      productColor: 'Синий',
      categoryId: 1,
    ),
    Product(
      productId: 3,
      productName: 'Товар 3',
      productPrice: 20.0,
      description: 'Описание товара 3',
      image: 'https://via.placeholder.com/150',
      productSize: 'S',
      productColor: 'Зеленый',
      categoryId: 1,
    ),
    // Добавьте больше товаров по желанию
  ];

  void _addToCart(Product product) {
    setState(() {
      cartItems.add(product); // Добавляем продукт в корзину
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.productName} добавлен в корзину')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон
      appBar: AppBar(
        title: Text('Товары', style: TextStyle(color: Colors.black)), // Черный текст
        backgroundColor: Colors.white, // Белый фон
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black), // Черная иконка
            onPressed: () {
              // Переход на экран корзины
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Поле поиска и кнопка фильтров
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск товаров...',
                      hintStyle: TextStyle(color: Colors.grey), // Серый текст для подсказки
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black), // Черная рамка
                      ),
                      filled: true,
                      fillColor: Colors.white, // Белый фон
                      prefixIcon: Icon(Icons.search, color: Colors.black), // Черная иконка
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Переход на экран фильтров
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Белый фон кнопки
                    foregroundColor: Colors.black, // Черный текст
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Фильтры'), // Черный текст
                ),
              ],
            ),
          ),
          // Отображение товаров в карточках
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Две карточки в ряд
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]); // Используем карточку товара
              },
            ),
          ),
        ],
      ),
    );
  }
}
