// product_model.dart
class Product {
  final int productId; // Идентификатор продукта
  final String productName; // Название продукта
  final double productPrice; // Цена продукта
  final String description; // Описание продукта
  final String image; // URL изображения продукта
  final String productSize; // Размер продукта
  final String productColor; // Цвет продукта
  final int categoryId; // Идентификатор категории

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.image,
    required this.productSize,
    required this.productColor,
    required this.categoryId,
  });
}
