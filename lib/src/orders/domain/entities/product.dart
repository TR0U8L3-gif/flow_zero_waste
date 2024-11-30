class Product {
  Product({
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

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    int? quantity,
    List<String>? allergens,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      allergens: allergens ?? this.allergens,
    );
  }
}
