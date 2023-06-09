import 'package:mallmap_store/model/model.dart';

class Product extends Model {
  String storeId;
  String? productId;
  String pictureUrl;
  String name;
  String? description;
  int price;

  Product({
    required this.storeId,
    required this.pictureUrl,
    required this.name,
    required this.price,
    this.productId,
    this.description = "",
  });

  @override
  Map<String, dynamic> toJson() {
    return ({
      'storeId': storeId,
      'pictureUrl': pictureUrl,
      'name': name,
      'description': description,
      'price': price,
    });
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        storeId: json['storeId'],
        pictureUrl: json['pictureUrl'],
        name: json['name'],
        description: json['description'],
        price: json['itemPrice']);
  }
}
