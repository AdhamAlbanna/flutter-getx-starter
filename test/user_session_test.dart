import 'package:flutter_getx_starter/helper/functions/user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await UserSession.init();
  });

  test('starts logged out', () {
    expect(UserSession.isLoggedIn, isFalse);
    expect(UserSession.token, '');
  });

  test('save then init restores the session', () async {
    await UserSession.save({'token': 'abc', 'id': 7, 'name': 'Emily'});
    expect(UserSession.isLoggedIn, isTrue);

    await UserSession.init();
    expect(UserSession.token, 'abc');
    expect(UserSession.userId, '7');
    expect(UserSession.name, 'Emily');
  });

  test('clear logs the user out', () async {
    await UserSession.save({'token': 'abc'});
    await UserSession.clear();
    expect(UserSession.isLoggedIn, isFalse);

    await UserSession.init();
    expect(UserSession.isLoggedIn, isFalse);
  });
}
