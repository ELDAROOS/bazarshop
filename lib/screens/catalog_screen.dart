import 'package:flutter/material.dart';
import 'filter_screen.dart'; // Импортируем экран фильтров
import 'category_screen.dart'; // Импортируем экран категорий

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
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
            // Поле поиска, кнопка фильтров и гамбургер-меню
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск товаров...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search, color: Colors.black),
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
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Фильтры'),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black), // Иконка гамбургера
                  onPressed: () {
                    // Показать меню с категориями
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Женщинам'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CategoryScreen(gender: 'women')),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('Мужчинам'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CategoryScreen(gender: 'men')),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('Детям'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CategoryScreen(gender: 'kids')),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Свежие товары
            Text('Свежие товары', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black)),
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
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Цена: \$${(index + 1) * 10}', // Замените на реальную цену
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
