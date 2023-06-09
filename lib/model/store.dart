import 'package:mallmap_store/model/model.dart';

class Store extends Model {
  String storeId;
  String storeName;
  String storeLocation;

  Store(
      {required this.storeId,
      required this.storeName,
      required this.storeLocation});

  @override
  Map<String, dynamic> toJson() {
    return ({
      'storeId': storeId,
      'storeName': storeName,
      'storeLocation': storeLocation
    });
  }
}
