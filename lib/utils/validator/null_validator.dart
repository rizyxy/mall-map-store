class NullValidator {
  static String? nullValidator(String label, String? value) {
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }

    return null;
  }
}
