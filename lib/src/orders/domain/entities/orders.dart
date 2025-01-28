import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';

class Orders {
  Orders({
    required this.id,
    required this.code,
    required this.date,
    required this.status,
    required this.products,
    required this.shop,
  });

  final String id;
  final String code;
  final DateTime date;
  final OrderStatus status;
  final List<Product> products;
  final Shop shop;

  Orders copyWith({
    String? id,
    String? code,
    DateTime? date,
    OrderStatus? status,
    List<Product>? products,
    Shop? shop,
  }) {
    return Orders(
      id: id ?? this.id,
      code: code ?? this.code,
      date: date ?? this.date,
      status: status ?? this.status,
      products: products ?? this.products,
      shop: shop ?? this.shop,
    );
  }
}

enum OrderStatus {
  pending,
  accepted,
  completed,
  canceled;
}
