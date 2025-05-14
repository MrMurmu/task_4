class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final String warrantyInformation;
  final List<String> images;

  int quantity; // NEW FIELD (mutable)

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.warrantyInformation,
    required this.images,
    this.quantity = 1, // default quantity when added to cart
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
        rating: (json['rating'] ?? 0).toDouble(),
        stock: json['stock'] ?? 0,
        brand: json['brand'] ?? '',
        category: json['category'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
        warrantyInformation: json['warrantyInformation'] ?? '',
        images: List<String>.from(json['images'] ?? []),
        quantity: json['quantity'] ?? 1, // optional if loaded from local DB
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'warrantyInformation': warrantyInformation,
        'images': images,
        'quantity': quantity, // include if saving locally
      };
}
