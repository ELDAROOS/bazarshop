class Product {
  final int productId;
  final String productName;
  final double productPrice;
  final String description;
  final String image;
  final String productSize;
  final String productColor;
  final int categoryId;
  final double productRating; // Добавлено поле для рейтинга продукта

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.image,
    required this.productSize,
    required this.productColor,
    required this.categoryId,
    this.productRating = 0.0, // Значение по умолчанию для рейтинга
  });
}
