
class OrdersModel {
  OrdersModel({
    required this.id,
    required this.code,
    required this.date,
    required this.status,
    required this.productIds,
    required this.shopId,
  });

  final String id;
  final String code;
  final String date;
  final int status;
  final List<String> productIds;
  final String shopId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'date': date,
      'status': status,
      'products_ids': productIds,
      'shop_id': shopId,
    };
  }

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'] as String,
      code: json['code'] as String,
      date: json['date'] as String,
      status: json['status'] as int,
      productIds: List<String>.from(json['products_ids'] as List),
      shopId: json['shop_id'] as String,
    );
  }
}
