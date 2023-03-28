class Store {
  String storeId;
  String storeName;
  String storeLocation;

  Store(
      {required this.storeId,
      required this.storeName,
      required this.storeLocation});

  Map<String, dynamic> toJson() {
    return ({
      'storeId': storeId,
      'storeName': storeName,
      'storeLocation': storeLocation
    });
  }
}
