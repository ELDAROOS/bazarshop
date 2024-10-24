import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            Spacer(),
            Text(
              'BAZAR',
              style: GoogleFonts.playfairDisplay( // Используем шрифт Playfair Display
                fontSize: 64,
                fontWeight: FontWeight.bold,
                letterSpacing: 8.0,
                color: Colors.black,
              ),
            ),
            Spacer(flex: 2),
            _buildCategoryButton(context, 'Мужской', 'assets/images/men_image.jpg', MenScreen()),
            SizedBox(height: 16),
            _buildCategoryButton(context, 'Женский', 'assets/images/women_image.jpg', WomenScreen()),
            SizedBox(height: 16),
            _buildCategoryButton(context, 'Подростковый', 'assets/images/teen_image.jpg', TeenScreen()),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String label, String imagePath, Widget screen) {
    return CategoryButton(label: label, imagePath: imagePath, screen: screen);
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final Widget screen;

  const CategoryButton({required this.label, required this.imagePath, required this.screen, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageFullscreenScreen(imagePath: imagePath, screen: screen),
          ),
        );
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.playfairDisplay( // Используем шрифт Playfair Display
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ImageFullscreenScreen extends StatelessWidget {
  final String imagePath;
  final Widget screen;

  const ImageFullscreenScreen({required this.imagePath, required this.screen, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                // Переход к экрану
                Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Text(
                'Перейти',
                style: GoogleFonts.playfairDisplay( // Используем шрифт Playfair Display
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
