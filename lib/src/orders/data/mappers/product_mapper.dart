import 'package:flow_zero_waste/core/common/data/mapper.dart';
import 'package:flow_zero_waste/src/orders/data/models/product_model.dart';
import 'package:flow_zero_waste/src/orders/domain/entities/product.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProductMapper extends Mapper<ProductModel,Product> {
  @override
  Product from(ProductModel object) {
    return Product(
      id: object.id,
      name: object.name,
      description: object.description,
      price: object.price,
      allergens: object.allergens,
      imageUrl: object.imageUrl,
      quantity: object.quantity,
    );
  }

  @override
  ProductModel to(Product object) {
    return ProductModel(
      id: object.id,
      name: object.name,
      description: object.description,
      price: object.price,
      allergens: object.allergens,
      imageUrl: object.imageUrl,
      quantity: object.quantity,
    );
  }
}