import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mallmap_store/model/store.dart';

class StoreRepository {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference store = firestore.collection('stores');

  static Future create(
      String storeId, String storeName, String storeLocation) async {
    await store.doc(storeId).set(Store(
            storeId: storeId,
            storeName: storeName,
            storeLocation: storeLocation)
        .toJson());
  }

  static Future edit(
      String storeId, String storeName, String storeLocation) async {
    await store.doc(storeId).update(Store(
            storeId: storeId,
            storeName: storeName,
            storeLocation: storeLocation)
        .toJson());
  }
}
