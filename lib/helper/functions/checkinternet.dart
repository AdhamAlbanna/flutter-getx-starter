import 'dart:async';
import 'dart:io';

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('example.com')
        .timeout(const Duration(seconds: 5));
    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  } on SocketException {
    return false;
  } on TimeoutException {
    return false;
  }
}
