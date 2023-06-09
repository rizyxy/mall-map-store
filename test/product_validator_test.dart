import 'package:flutter_test/flutter_test.dart';
import 'package:mallmap_store/utils/validator/product_validator.dart';

void main() {
  group('Product name', () {
    test(
        'is empty',
        () => expect(
            ProductValidator.validateName(''), 'Product name cannot be empty'));

    test(
        'is null',
        () => expect(ProductValidator.validateName(null),
            'Product name cannot be empty'));
    test(
        'is not valid',
        () => expect(
            ProductValidator.validateName('b'), 'Enter a valid product name'));

    test('is valid',
        () => expect(ProductValidator.validateName('Bomber Jacket'), null));
  });

  group('Product description', () {
    test(
        'is empty',
        () => expect(ProductValidator.validateDescription(''),
            'Product description cannot be empty'));

    test(
        'is null',
        () => expect(ProductValidator.validateDescription(null),
            'Product description cannot be empty'));
    test(
        'is not valid',
        () => expect(ProductValidator.validateDescription('b'),
            'Enter a valid product description'));

    test(
        'is valid',
        () => expect(
            ProductValidator.validateDescription('Bomber jacket berkualitas'),
            null));
  });

  group('Product price', () {
    test(
        'is empty',
        () => expect(
            ProductValidator.validatePrice(''), 'Price cannot be empty'));

    test(
        'is null',
        () => expect(
            ProductValidator.validatePrice(null), 'Price cannot be empty'));

    test(
        'is not valid',
        () =>
            expect(ProductValidator.validatePrice('b'), 'Enter a valid price'));

    test('is valid',
        () => expect(ProductValidator.validatePrice('10000'), null));
  });
}
