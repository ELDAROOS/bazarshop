class Product {
  final int productId;
  final String productName;
  final double productPrice;
  final String description;
  final String image;
  final String productSize;
  final String productColor;
  final int categoryId;
  final String brand; // Новое поле для бренда
  final double rating; // Новое поле для рейтинга

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.image,
    required this.productSize,
    required this.productColor,
    required this.categoryId,
    required this.brand,
    required this.rating,
  });
}
