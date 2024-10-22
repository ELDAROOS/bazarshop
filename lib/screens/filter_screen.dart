import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фильтры', style: TextStyle(color: Colors.black)), // Черный текст
        backgroundColor: Colors.white, // Белый фон
      ),
      body: Container(
        color: Colors.white, // Полностью белый фон
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Размер одежды
            Text('Размер одежды', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), // Черный текст
            SizedBox(height: 10),
            _buildCheckbox('S'),
            _buildCheckbox('M'),
            _buildCheckbox('L'),
            SizedBox(height: 20),

            // Цвет одежды
            Text('Цвет одежды', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), // Черный текст
            SizedBox(height: 10),
            _buildCheckbox('Красный'),
            _buildCheckbox('Синий'),
            _buildCheckbox('Черный'),
            SizedBox(height: 20),

            // Тип одежды
            Text('Тип одежды', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), // Черный текст
            SizedBox(height: 10),
            _buildCheckbox('Футболки'),
            _buildCheckbox('Шорты'),
            _buildCheckbox('Штаны'),
            _buildCheckbox('Обувь'),
            _buildCheckbox('Головные уборы'),
            _buildCheckbox('Верхняя одежда'),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title, style: TextStyle(color: Colors.black)), // Черный текст
      value: false, // Добавьте логику управления состоянием
      onChanged: (bool? value) {
        // Логика для изменения состояния
      },
      activeColor: Colors.black, // Черный цвет при активации
      checkColor: Colors.white, // Белый цвет для галочки
    );
  }
}
