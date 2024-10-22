import 'package:flutter/material.dart';
import 'filter_screen.dart'; // Импортируем экран фильтров

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон
      appBar: AppBar(
        title: Text('Каталог', style: TextStyle(color: Colors.black)), // Черный текст
        backgroundColor: Colors.white, // Белый фон
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black), // Черная иконка
            onPressed: () {
              // Действие для корзины
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Поле поиска и кнопка фильтров
            TextField(
              decoration: InputDecoration(
                hintText: 'Поиск товаров...',
                hintStyle: TextStyle(color: Colors.grey), // Серый цвет подсказки
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black), // Черная рамка
                ),
                filled: true,
                fillColor: Colors.white, // Белый фон
                prefixIcon: Icon(Icons.search, color: Colors.black),
              ),
            ),
            SizedBox(height: 16),

            // Фильтры
            Text('Фильтры', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterChip(
                  label: Text('Женщинам', style: TextStyle(color: Colors.black)),
                  selected: false,
                  onSelected: (bool value) {},
                  backgroundColor: Colors.white, // Белый фон
                  selectedColor: Colors.black, // Черный фон при выборе
                  labelStyle: TextStyle(color: Colors.white), // Белый текст при выборе
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Мужчинам', style: TextStyle(color: Colors.black)),
                  selected: false,
                  onSelected: (bool value) {},
                  backgroundColor: Colors.white,
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('Детям', style: TextStyle(color: Colors.black)),
                  selected: false,
                  onSelected: (bool value) {},
                  backgroundColor: Colors.white,
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Категории
            Text('Категории', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryChip(label: 'Одежда'),
                  SizedBox(width: 8),
                  CategoryChip(label: 'Обувь'),
                  SizedBox(width: 8),
                  CategoryChip(label: 'Аксессуары'),
                  SizedBox(width: 8),
                  CategoryChip(label: 'Косметика'),
                  SizedBox(width: 8),
                  CategoryChip(label: 'Электроника'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Свежие товары
            Text('Свежие товары', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.6,
                ),
                itemCount: 8, // Замените на фактическое количество товаров
                itemBuilder: (context, index) {
                  return ProductCard(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.black)), // Черный текст
      backgroundColor: Colors.white, // Белый фон
      onDeleted: () {
        // Действие для удаления категории
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final int index;

  const ProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://via.placeholder.com/150', // Здесь можно указать изображение товара
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Товар $index',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Черный текст
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Цена: \$${(index + 1) * 10}', // Замените на реальную цену
              style: TextStyle(color: Colors.black), // Черный текст
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Логика добавления в корзину
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Белый фон кнопки
                foregroundColor: Colors.black, // Черный текст
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.black), // Черная рамка
                ),
              ),
              child: Text('Добавить в корзину'), // Текст кнопки
            ),
          ),
        ],
      ),
    );
  }
}
