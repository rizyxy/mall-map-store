class ProductValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Product name cannot be empty';
    }

    if (name.length < 2) {
      return 'Enter a valid product name';
    }

    return null;
  }

  static String? validateDescription(String? name) {
    if (name == null || name.isEmpty) {
      return 'Product description cannot be empty';
    }

    if (name.length < 2) {
      return 'Enter a valid product description';
    }

    return null;
  }

  static String? validatePrice(String? price) {
    if (price == null || price.isEmpty) {
      return 'Price cannot be empty';
    }

    if (!RegExp(r'^[0-9]+([.][0-9]+)?$').hasMatch(price)) {
      return 'Enter a valid price';
    }

    return null;
  }
}
