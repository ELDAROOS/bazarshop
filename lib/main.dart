import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Пока что передаем "dummy_token" и "dummy_email"
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(
        jwtToken: 'dummy_token',  // передаем заглушку для jwtToken
        email: 'dummy_email',     // передаем заглушку для email
      ),
    );
  }
}
