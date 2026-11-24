import 'package:flutter_getx_starter/localization/mylocalization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Arabic and English define exactly the same keys', () {
    final keys = MyLocalization().keys;
    expect(keys['ar']!.keys.toSet(), keys['en']!.keys.toSet());
  });

  test('no translation is empty', () {
    final keys = MyLocalization().keys;
    for (final language in keys.values) {
      for (final value in language.values) {
        expect(value.trim(), isNotEmpty);
      }
    }
  });
}
