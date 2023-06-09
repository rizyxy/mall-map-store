class AuthenticationValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }

    if (email.contains('@') == false) {
      return 'Your email format is incorrect';
    }

    if (!RegExp(r'@\w+').hasMatch(email)) {
      return 'I don\'t see any email provider';
    }

    if (!RegExp(r'\w+@').hasMatch(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least 1 lowercase character';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least 1 uppercase character';
    }

    if (!RegExp(r'[^\w\s]').hasMatch(password)) {
      return 'Password must contain at least 1 special character';
    }

    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Store name cannot be empty';
    }

    if (name.length < 2) {
      return 'Enter a valid store name';
    }

    return null;
  }

  static String? validateLocation(String? location) {
    if (location == null || location.isEmpty) {
      return 'Store location cannot be empty';
    }

    if (location.length < 2) {
      return 'Enter a valid store location';
    }

    return null;
  }
}
