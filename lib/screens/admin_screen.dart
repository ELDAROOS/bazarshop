import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Экран для добавления продуктов
class AdminAddProductScreen extends StatefulWidget {
  final String userRole; // Роль пользователя

  AdminAddProductScreen({required this.userRole});

  @override
  _AdminAddProductScreenState createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();

  // Функция для добавления продукта
  Future<void> _addProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('vhttp://127.0.0.1:5000/add_product'), // Путь к серверу для добавления продукта
        body: json.encode({
          'name': _productNameController.text,
          'price': _productPriceController.text,
          'description': _productDescriptionController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Продукт добавлен')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка при добавлении продукта')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Проверка на роль "admin"
    if (widget.userRole != 'admin') {
      return Scaffold(
        appBar: AppBar(
          title: Text('Доступ запрещен'),
        ),
        body: Center(
          child: Text('Только администратор может добавлять продукты.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить продукт'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Название продукта'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название продукта';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productPriceController,
                decoration: InputDecoration(labelText: 'Цена продукта'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите цену';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productDescriptionController,
                decoration: InputDecoration(labelText: 'Описание продукта'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите описание';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Добавить продукт'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Color for the disabled state (optional)
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
