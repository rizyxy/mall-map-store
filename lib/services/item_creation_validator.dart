import 'dart:io';

class ItemCreationValidator {
  static bool isValid(
      File? image, String itemName, int? itemPrice, String? itemDesc) {
    if (image == null) {
      return false;
    }

    if (itemName.isEmpty) {
      return false;
    }

    if (itemPrice == null) {
      return false;
    }

    return true;
  }
}
