class Item {
  String storeId;
  String itemPictureURL;
  String itemName;
  String? itemDescription;
  int itemPrice;
  Map<String, String>? itemInfo;

  Item(
      {required this.storeId,
      required this.itemPictureURL,
      required this.itemName,
      required this.itemPrice,
      this.itemDescription = "",
      this.itemInfo});

  Map<String, dynamic> toJson() {
    return ({
      'storeId': storeId,
      'itemPicture': itemPictureURL,
      'itemName': itemName,
      'itemDesc': itemDescription,
      'itemPrice': itemPrice,
      'itemInfo': itemInfo
    });
  }

  static Item fromJson(Map<String, dynamic> json) {
    return Item(
        storeId: json['storeId'],
        itemPictureURL: json['itemPicture'],
        itemName: json['itemName'],
        itemPrice: json['itemPrice']);
  }
}
