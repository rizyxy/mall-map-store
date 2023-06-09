import 'package:flutter/material.dart';
import 'package:mallmap_store/services/authentication.dart';

class AuthenticationController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await Authentication.login(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future register(String storeName, String storeLocation, String email,
      String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await Authentication.register(storeName, storeLocation, email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
