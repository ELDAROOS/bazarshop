// product.dart
class Product {
  final int code;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String productStatus;
  final String category;

  Product({
    required this.code,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.productStatus,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      productStatus: json['product_status'],
      category: json['category']['name'], // Предположим, что категория передается как объект с полем name
    );
  }
}
