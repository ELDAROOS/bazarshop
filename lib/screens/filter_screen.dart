import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фильтры', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Размер одежды', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('S', style: TextStyle(color: Colors.black)),
              value: false, // Добавьте логику управления состоянием
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('M', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('L', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            SizedBox(height: 20),

            Text('Цвет одежды', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Красный', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Синий', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Черный', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            SizedBox(height: 20),

            Text('Тип одежды', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Футболки', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Шорты', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Штаны', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Обувь', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Головные уборы', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Верхняя одежда', style: TextStyle(color: Colors.black)),
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
      ),
    );
  }
}
