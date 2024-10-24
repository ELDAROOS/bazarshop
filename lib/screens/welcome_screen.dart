import 'package:flutter/material.dart';
import 'men_screen.dart';
import 'women_screen.dart';
import 'teen_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(), // Поднимаем заголовок выше
            Text(
              'BAZAR',
              style: TextStyle(
                fontSize: 64, // Увеличиваем размер шрифта
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman', // Попробуем Times New Roman для схожести
                letterSpacing: 8.0, // Увеличиваем расстояние между буквами
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 2), // Увеличиваем отступ после заголовка

            // Кнопка для Мужского раздела
            _buildCategoryButton(
              context,
              'Мужской',
              'assets/images/men_image.jpg',
              MenScreen(),
            ),
            SizedBox(height: 16), // Добавляем пространство между кнопками

            // Кнопка для Женского раздела
            _buildCategoryButton(
              context,
              'Женский',
              'assets/images/women_image.jpg',
              WomenScreen(),
            ),
            SizedBox(height: 16), // Добавляем пространство между кнопками

            // Кнопка для Подросткового раздела
            _buildCategoryButton(
              context,
              'Подростковый',
              'assets/images/teen_image.jpg',
              TeenScreen(),
            ),
            Spacer(), // Пространство внизу экрана
          ],
        ),
      ),
    );
  }

  // Функция для создания большой кнопки с изображением
  Widget _buildCategoryButton(BuildContext context, String label, String imagePath, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        height: 180, // Увеличиваем высоту кнопки
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Закругляем углы
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover, // Изображение будет покрывать кнопку
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), // Применяем затемнение
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 28, // Увеличиваем размер текста
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman', // Применяем шрифт
              color: Colors.white, // Белый текст на кнопке
            ),
          ),
        ),
      ),
    );
  }
}
