class AuthenticationValidator {
  static bool isValid(
      String storeName, String storeLocation, String email, String password) {
    if (storeName.isEmpty) {
      return false;
    }

    if (storeLocation.isEmpty) {
      return false;
    }

    if (email.isEmpty) {
      return false;
    }

    if (email.contains('@') == false) {
      return false;
    }

    if (password.isEmpty) {
      return false;
    }

    if (password.length < 8) {
      return false;
    }

    return true;
  }
}
