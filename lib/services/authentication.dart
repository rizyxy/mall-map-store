import 'package:firebase_auth/firebase_auth.dart';
import 'package:mallmap_store/repository/store_repository.dart';

enum AuthResult { success, failure, error }

class Authentication {
  static Future<AuthResult> login(String email, String password) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        return AuthResult.success;
      }

      if (userCredential.user == null) {
        return AuthResult.failure;
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.error;
    } catch (e) {
      return AuthResult.error;
    }

    throw Exception();
  }

  static Future<AuthResult> register(String storeName, String storeLocation,
      String email, String password) async {
    // await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //   StoreRepository.create(value.user!.uid, storeName, storeLocation);

    //   value.user!.updateDisplayName(storeName);
    // });

    try {
      UserCredential? credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential != null) {
        StoreRepository.create(credential.user!.uid, storeName, storeLocation);

        credential.user!.updateDisplayName(storeName);

        return AuthResult.success;
      }
    } catch (e) {
      print('Error : ${e.toString()}');
      return AuthResult.error;
    }

    throw Exception();
  }

  static Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future logout() async => FirebaseAuth.instance.signOut();
}
