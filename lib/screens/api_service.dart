// lib/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

/// Функция для получения данных профиля пользователя с сервера.
Future<Map<String, String>> fetchUserProfile(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://your-server-ip/login'), // Замените на актуальный URL вашего сервера
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Если сервер возвращает успешный ответ, парсим JSON
    final data = json.decode(response.body);
    return {
      'userName': '${data['firstname']} ${data['lastname']}',
      'userEmail': data['email'],
      'userPhone': data['userPhone'] ?? 'Не указан',  // Если телефон не указан, ставим значение по умолчанию
    };
  } else {
    throw Exception('Не удалось загрузить данные профиля');
  }
}
