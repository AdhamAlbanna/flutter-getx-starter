import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Prints a cURL representation of [request] in debug mode only.
/// The Authorization header is redacted so tokens never reach the logs.
void printCurlCommand(http.BaseRequest? request) {
  if (!kDebugMode || request == null) return;

  final buffer = StringBuffer("curl -X ${request.method} '${request.url}'");
  request.headers.forEach((key, value) {
    final shown = key.toLowerCase() == 'authorization' ? '<redacted>' : value;
    buffer.write(" -H '$key: $shown'");
  });
  if (request is http.Request && request.body.isNotEmpty) {
    buffer.write(" -d '${request.body}'");
  }
  debugPrint(buffer.toString());
}
