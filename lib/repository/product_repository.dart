import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mallmap_store/model/product.dart';
import 'package:mallmap_store/services/storage_services.dart';

class ProductRepository {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference products = firestore.collection('products');

  static Future create(File file, Product product) async {
    await products
        .add(product.toJson())
        .then((value) => StorageServices.uploadProductPicture(value.id, file));
  }

  static Future edit(String document, Product product) async {
    await products.doc(document).update(product.toJson());
  }

  static Future updateField(String document, Map<String, dynamic> data) async {
    await products.doc(document).update(data);
  }

  static Future delete(String doc) async {
    await products.doc(doc).delete();
  }
}
