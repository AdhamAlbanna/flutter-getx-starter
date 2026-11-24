import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Small string maps that must survive between steps of a flow
/// (for example a multi-step registration).
Future<void> saveDataWithKey(Map<String, String> data, String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(data));
}

Future<Map<String, String>?> getDataWithKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final raw = prefs.getString(key);
  if (raw == null) return null;
  return Map<String, String>.from(jsonDecode(raw) as Map);
}

Future<void> deleteDataWithKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
