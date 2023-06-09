import 'package:firebase_auth/firebase_auth.dart';
import 'package:mallmap_store/repository/store_repository.dart';

class Authentication {
  static Future<UserCredential?> login(String email, String password) async {
    UserCredential? credential;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential credential) => credential = credential);

    return credential;
  }

  static Future register(String storeName, String storeLocation, String email,
      String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      StoreRepository.create(value.user!.uid, storeName, storeLocation);

      value.user!.updateDisplayName(storeName);
    });
  }

  static Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future logout() async => FirebaseAuth.instance.signOut();
}
