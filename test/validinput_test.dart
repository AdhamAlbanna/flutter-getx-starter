import 'package:flutter_getx_starter/helper/functions/validinput.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validInput', () {
    test('rejects empty and whitespace-only values', () {
      expect(validInput('', 3, 10, 'username'), isNotNull);
      expect(validInput('   ', 3, 10, 'username'), isNotNull);
      expect(validInput(null, 3, 10, 'username'), isNotNull);
    });

    test('accepts a valid username', () {
      expect(validInput('emilys', 3, 30, 'username'), isNull);
    });

    test('rejects an invalid username', () {
      expect(validInput('9bad name!', 3, 30, 'username'), isNotNull);
    });

    test('enforces min and max length', () {
      expect(validInput('abc', 6, 10, 'password'), isNotNull);
      expect(validInput('abcdef', 6, 10, 'password'), isNull);
      expect(validInput('abcdefghijk', 6, 10, 'password'), isNotNull);
    });

    test('validates emails', () {
      expect(validInput('user@example.com', 3, 50, 'email'), isNull);
      expect(validInput('not-an-email', 3, 50, 'email'), isNotNull);
    });
  });
}
