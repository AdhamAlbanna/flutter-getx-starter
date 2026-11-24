import 'package:flutter_getx_starter/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product.fromJson', () {
    test('parses a full payload', () {
      final product = Product.fromJson({
        'id': 1,
        'title': 'Mascara',
        'price': 9.99,
        'thumbnail': 'https://example.com/a.webp',
      });
      expect(product.id, 1);
      expect(product.title, 'Mascara');
      expect(product.price, 9.99);
      expect(product.thumbnail, 'https://example.com/a.webp');
    });

    test('falls back to safe defaults', () {
      final product = Product.fromJson({});
      expect(product.id, 0);
      expect(product.title, '');
      expect(product.price, 0);
      expect(product.thumbnail, '');
    });

    test('accepts integer prices', () {
      expect(Product.fromJson({'price': 10}).price, 10.0);
    });
  });
}
