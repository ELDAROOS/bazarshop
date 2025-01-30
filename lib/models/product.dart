class Product {
  final int code;
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String productStatus;
  final String category;
  final String gender;  // Add gender field

  Product({
    required this.code,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.productStatus,
    required this.category,
    required this.gender,  // Include gender in the constructor
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] as int,
        code: json['code'] as int,
        name: json['name'] as String,
        description: json['description'] as String? ?? '',
        price: (json['price'] as num).toDouble(),
        quantity: json['quantity'] as int,
        productStatus: json['productStatus'] as String? ?? 'UNKNOWN',
        category: json['category'] is String
            ? json['category'] as String
            : (json['category'] as Map<String, dynamic>)['name'] as String? ?? 'Uncategorized',
        gender: json['gender'] as String? ?? 'Unspecified',  // Parse gender from JSON
      );
    } catch (e) {
      print('Ошибка при парсинге продукта: $e');
      throw Exception('Ошибка парсинга данных продукта');
    }
  }
}
