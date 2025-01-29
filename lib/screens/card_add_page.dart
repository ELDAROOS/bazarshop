import 'package:flutter/material.dart';

class CardAddPage extends StatefulWidget {
  final String jwtToken; // Токен для авторизации

  const CardAddPage({Key? key, required this.jwtToken}) : super(key: key);

  @override
  _CardAddPageState createState() => _CardAddPageState();
}

class _CardAddPageState extends State<CardAddPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить карту'),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCardInputField('Номер карты', _cardNumberController),
            _buildCardInputField('Дата истечения (MM/YY)', _expiryDateController),
            _buildCardInputField('CVV', _cvvController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Здесь будет логика добавления карты
                _saveCardDetails(
                  _cardNumberController.text,
                  _expiryDateController.text,
                  _cvvController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Цвет кнопки
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Привязать карту', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет для поля ввода данных карты
  Widget _buildCardInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  // Логика для сохранения данных карты
  void _saveCardDetails(String cardNumber, String expiryDate, String cvv) {
    // Тут можно добавить логику для отправки данных на сервер или сохранения их локально.
    print('Номер карты: $cardNumber');
    print('Дата истечения: $expiryDate');
    print('CVV: $cvv');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Карта успешно добавлена!'),
    ));
  }
}
