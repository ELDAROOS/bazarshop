import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:bazarshop/screens/search_page.dart';
import 'package:bazarshop/screens/catalog_page.dart';
import 'package:bazarshop/screens/auth_page.dart'; // Импортируем AuthPage
import 'package:bazarshop/screens/cart_page.dart';

class HomePage extends StatefulWidget {
  final String jwtToken;  // параметр для получения jwtToken

  HomePage({required this.jwtToken});  // обязательный параметр

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videoplayback.mp4")
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToSearch(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(query: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Видео на заднем плане
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          // Содержимое поверх видео
          Column(
            children: [
              // Верхняя панель
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Кнопка каталог
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CatalogPage(jwtToken: widget.jwtToken),  // Передаем jwtToken
                          ),
                        );
                      },
                    ),
                    // Название BAZAR
                    Text(
                      "BAZAR",
                      style: TextStyle(
                        fontFamily: "Harper's Bazaar", // Укажи шрифт
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Кнопки лупа, профиль, корзина
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            navigateToSearch("");
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.person, color: Colors.black),
                          onPressed: () {
                            // Навигация на AuthPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AuthPage()), // Исправляем ошибку
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart, color: Colors.white),
                          onPressed: () {
                            // Открыть корзину
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartPage(jwtToken: widget.jwtToken)),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              // Нижняя строка поиска
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: navigateToSearch,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        // Поиск
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
