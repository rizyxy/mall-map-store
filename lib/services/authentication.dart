import 'package:firebase_auth/firebase_auth.dart';
import 'package:mallmap_store/database/store_crud.dart';

class Authentication {
  static Future login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future register(String storeName, String storeLocation, String email,
      String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      StoreCRUD.create(value.user!.uid, storeName, storeLocation);

      value.user!.updateDisplayName(storeName);
    });
  }
}
