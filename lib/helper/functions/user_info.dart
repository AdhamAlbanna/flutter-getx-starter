import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// The logged-in user. Loaded once at startup with [init], then read
/// synchronously from anywhere.
class UserSession {
  static const String _key = 'user_info';
  static Map<String, dynamic>? _info;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    _info = raw == null ? null : jsonDecode(raw) as Map<String, dynamic>;
  }

  static bool get isLoggedIn => _info != null;
  static String get token => "${_info?['token'] ?? ''}";
  static String get userId => "${_info?['id'] ?? ''}";
  static String get name => "${_info?['name'] ?? ''}";
  static String get email => "${_info?['email'] ?? ''}";

  static Future<void> save(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(userInfo));
    _info = userInfo;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    _info = null;
  }
}
