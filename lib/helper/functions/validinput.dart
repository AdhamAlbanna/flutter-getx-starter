import 'package:get/get.dart';

/// Shared `TextFormField` validator.
///
/// Returns a translated error message, or `null` when [value] is valid.
/// [type] is one of `username`, `email`, `phone` or `password`.
String? validInput(String? value, int min, int max, String type) {
  final text = value?.trim() ?? '';

  if (text.isEmpty) return 'field_required'.tr;

  switch (type) {
    case 'email':
      if (!GetUtils.isEmail(text)) return 'invalid_email'.tr;
    case 'phone':
      if (!GetUtils.isPhoneNumber(text)) return 'invalid_phone'.tr;
    case 'username':
      if (!GetUtils.isUsername(text)) return 'invalid_username'.tr;
  }

  if (text.length < min) {
    return 'field_too_short'.trParams({'min': '$min'});
  }
  if (text.length > max) {
    return 'field_too_long'.trParams({'max': '$max'});
  }
  return null;
}
