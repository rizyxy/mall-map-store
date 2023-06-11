import 'package:flutter/material.dart';
import 'package:mallmap_store/services/authentication.dart';

class AuthenticationController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<AuthResult> login(String email, String password) async {
    late AuthResult authResult;
    try {
      _isLoading = true;
      notifyListeners();

      authResult = await Authentication.login(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return authResult;
  }

  Future<AuthResult> register(String storeName, String storeLocation,
      String email, String password) async {
    late AuthResult authResult;
    try {
      _isLoading = true;
      notifyListeners();

      authResult = await Authentication.register(
          storeName, storeLocation, email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return authResult;
  }
}
