class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.allergens,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int quantity;
  final List<String> allergens;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'allergens': allergens,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as double,
      quantity: json['quantity'] as int,
      allergens: List<String>.from(json['allergens'] as List),
    );
  }
}
