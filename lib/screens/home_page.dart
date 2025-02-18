import 'package:bazarshop/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bazarshop/screens/search_page.dart';
import 'package:bazarshop/screens/catalog_page.dart';
import 'package:bazarshop/screens/auth_page.dart';  // Импортируем AuthPage для редиректа
import 'package:bazarshop/screens/cart_page.dart';

class HomePage extends StatefulWidget {
  final String jwtToken;
  final String email;

  HomePage({Key? key, required this.jwtToken, required this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<String> imageList = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
    "assets/image5.jpg",
  ];

  // Функция для перехода на страницу поиска
  void navigateToSearch(String query) {
    print("Переход на страницу поиска с запросом: $query");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          query: query,
          jwtToken: widget.jwtToken,
          email: widget.email,
        ),
      ),
    );
  }

  // Функция для перехода на экран профиля
  void navigateToProfile() {
    if (widget.jwtToken == 'dummy_token' || widget.jwtToken.isEmpty) {
      // Если токен некорректный, перенаправляем на экран авторизации
      print("Некорректный токен, переходим на экран авторизации.");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),  // Переход на экран авторизации
      );
    } else {
      // Если токен корректный, переходим на экран профиля
      print("Переход в ProfilePage с токеном: ${widget.jwtToken}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            jwtToken: widget.jwtToken,
            email: widget.email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Токен на странице HomePage: ${widget.jwtToken}");
    print("Email на странице HomePage: ${widget.email}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Верхняя панель
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BAZAR",
                  style: TextStyle(
                    fontFamily: "Harper's Bazaar",
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Image.asset('assets/icons/cart.png', width: 24, height: 24),  // Указываем путь к иконке и её размер
                  onPressed: () {
                    // Логируем переход в CartPage
                    print("Переход в CartPage с токеном: ${widget.jwtToken}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(jwtToken: widget.jwtToken), // Передаем токен в CartPage
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Карусель
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.7, // Устанавливаем высоту 60% от высоты экрана
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageList.map((imagePath) {
              return Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover, // Обрезаем изображение по размеру контейнера
                  ),
                ),
              );
            }).toList(),
          ),

          // Нижний HUD-бар
          BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/catalog.png', width: 24, height: 24),
                label: "Catalog",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/search.png', width: 24, height: 24),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icons/profile.png', width: 24, height: 24),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              print("Выбрана вкладка: $index");

              if (index == 0) {
                // Логируем переход в CatalogPage
                print("Переход в CatalogPage с токеном: ${widget.jwtToken}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatalogPage(
                      jwtToken: widget.jwtToken,  // Передаем токен в CatalogPage
                      email: widget.email,
                    ),
                  ),
                );
              } else if (index == 1) {
                navigateToSearch(""); // Переход на страницу поиска
              } else if (index == 2) {
                // Функция перехода на экран профиля
                navigateToProfile();
              }
            },
          ),
        ],
      ),
    );
  }
}
