
class OrdersModel {
  OrdersModel({
    required this.id,
    required this.code,
    required this.date,
    required this.status,
    required this.productId,
    required this.shopId,
  });

  final String id;
  final String code;
  final String date;
  final int status;
  final String productId;
  final String shopId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'date': date,
      'status': status,
      'products_id': productId,
      'shop_id': shopId,
    };
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'] as String,
      code: json['code'] as String,
      date: json['date'] as String,
      status: json['status'] as int,
      productId: json['products_id'] as String,
      shopId: json['shop_id'] as String,
    );
  }
}
