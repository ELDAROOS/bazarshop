import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Импортируем экран приветствия

void main() {
  runApp(BazarApp());
}

class BazarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bazar',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(), // Задаем экран приветствия как стартовый
    );
  }
}
