import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String category = 'Женщины';
  List<String> items = List.generate(10, (index) => 'Товар ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Каталог',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Кнопка "Женщины"
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: category == 'Женщины' ? 130 : 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        category = 'Женщины';
                      });
                    },
                    child: Text(
                      'Женщины',
                      style: TextStyle(
                        color: category == 'Женщины' ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category == 'Женщины'
                          ? Colors.black
                          : Colors.white,
                      side: BorderSide(
                        color: category == 'Женщины'
                            ? Colors.black
                            : Colors.white.withOpacity(0.2),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                // Кнопка "Мужчины"
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: category == 'Мужчины' ? 130 : 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        category = 'Мужчины';
                      });
                    },
                    child: Text(
                      'Мужчины',
                      style: TextStyle(
                        color: category == 'Мужчины' ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: category == 'Мужчины'
                          ? Colors.black
                          : Colors.white,
                      side: BorderSide(
                        color: category == 'Мужчины'
                            ? Colors.black
                            : Colors.white.withOpacity(0.2),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Анимация для списка товаров
            Expanded(
              child: AnimatedList(
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text('Описание товара ${index + 1}',
                            style: TextStyle(fontSize: 14)),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onTap: () {
                          // Переход на страницу товара
                        },
                      ),
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
