import 'package:flutter_test/flutter_test.dart';
import 'package:mallmap_store/utils/validator/auth_validator.dart';

void main() {
  group('Store name', () {
    test(
        'is null',
        () => expect(AuthenticationValidator.validateName(null),
            'Store name cannot be empty'));
    test(
        'is empty',
        () => expect(AuthenticationValidator.validateName(''),
            'Store name cannot be empty'));

    test(
        'is not valid',
        () => expect(AuthenticationValidator.validateName('a'),
            'Enter a valid store name'));
  });

  group('Store location', () {
    test(
        'is null',
        () => expect(AuthenticationValidator.validateLocation(null),
            'Store location cannot be empty'));
    test(
        'is empty',
        () => expect(AuthenticationValidator.validateLocation(''),
            'Store location cannot be empty'));

    test(
        'is not valid',
        () => expect(AuthenticationValidator.validateLocation('a'),
            'Enter a valid store location'));
  });

  group('Email', () {
    test('is empty', () {
      expect(
          AuthenticationValidator.validateEmail(''), 'Email cannot be empty');
    });

    test('has no @', () {
      expect(AuthenticationValidator.validateEmail('testemail'),
          'Your email format is incorrect');
    });

    test('has no email provider', () {
      expect(AuthenticationValidator.validateEmail('testemail@'),
          'I don\'t see any email provider');
    });

    test('has no body', () {
      expect(AuthenticationValidator.validateEmail('@gmail.com'),
          'Enter a valid email');
    });

    test('is correct', () {
      expect(
          AuthenticationValidator.validateEmail('testemail@gmail.com'), null);
    });
  });

  group('Password', () {
    test('is empty', () {
      expect(AuthenticationValidator.validatePassword(''),
          'Password cannot be empty');
    });

    test('is too short', () {
      expect(AuthenticationValidator.validatePassword('Abc12@'),
          'Password must be at least 8 characters long');
    });

    test('does not contain any lowercase', () {
      expect(AuthenticationValidator.validatePassword('ABC12345@'),
          'Password must contain at least 1 lowercase character');
    });

    test('does not contain any uppercase', () {
      expect(AuthenticationValidator.validatePassword('abc12345@'),
          'Password must contain at least 1 uppercase character');
    });

    test('does not contain any lowercase', () {
      expect(AuthenticationValidator.validatePassword('abC123456'),
          'Password must contain at least 1 special character');
    });

    test('is correct', () {
      expect(AuthenticationValidator.validatePassword('abC12345@'), null);
    });
  });
}
