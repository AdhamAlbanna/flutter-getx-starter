import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';
import 'package:flutter_getx_starter/helper/functions/checkinternet.dart';
import 'package:flutter_getx_starter/helper/functions/print_curl_command.dart';
import 'package:flutter_getx_starter/helper/functions/showdialog.dart';
import 'package:flutter_getx_starter/helper/functions/user_info.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/// The single place where HTTP requests are made.
///
/// Every call returns a `Map<String, dynamic>` with a `success` flag.
/// On failure the error is shown once here, so controllers only need
/// `if (response['success'] == true)`.
class Api {
  static const Duration _timeout = Duration(seconds: 30);

  static Future<Map<String, dynamic>> makeApiRequest({
    required String url,
    required String method, // GET | POST | PUT | DELETE
    Map<String, dynamic>? body,
    Map<String, String>? query,
    Map<String, PlatformFile>? files,
    Map<String, String>? fields,
  }) async {
    var uri = Uri.parse(url);
    if (query != null && query.isNotEmpty) {
      uri = uri.replace(queryParameters: {...uri.queryParameters, ...query});
    }

    final headers = <String, String>{};
    if (files == null) headers['Content-Type'] = 'application/json';
    if (UserSession.token.isNotEmpty) {
      headers['Authorization'] = UserSession.token;
    }

    if (!await checkInternet()) return _fail('no_internet'.tr);

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(color: AppColor.primaryColor),
      ),
      barrierDismissible: false,
    );

    Map<String, dynamic> result;
    try {
      final response = await _send(
        uri,
        method,
        headers,
        body,
        files,
        fields,
      ).timeout(_timeout);
      result = _processResponse(response);
    } on TimeoutException {
      result = {'success': false, 'message': 'request_timeout'.tr};
    } catch (error) {
      result = {'success': false, 'message': error.toString()};
    } finally {
      if (Get.isDialogOpen == true) Get.back();
    }

    if (result['success'] == false) {
      alertDialog('Error'.tr, "${result['message'] ?? ''}");
    }
    return result;
  }

  static Future<http.Response> _send(
    Uri uri,
    String method,
    Map<String, String> headers,
    Map<String, dynamic>? body,
    Map<String, PlatformFile>? files,
    Map<String, String>? fields,
  ) async {
    switch (method) {
      case 'GET':
        final r = await http.get(uri, headers: headers);
        printCurlCommand(r.request);
        return r;

      case 'POST':
        if (files != null) {
          final request = http.MultipartRequest('POST', uri);
          // A plain loop, not forEach: forEach does not await async work.
          for (final entry in files.entries) {
            request.files.add(
              await http.MultipartFile.fromPath(
                entry.key,
                entry.value.path!,
                filename: entry.value.name,
                contentType: MediaType('application', 'octet-stream'),
              ),
            );
          }
          // Let the library set the multipart Content-Type and boundary.
          request.headers.addAll(headers);
          if (fields != null) request.fields.addAll(fields);
          final streamed = await request.send();
          final r = await http.Response.fromStream(streamed);
          printCurlCommand(request);
          return r;
        }

        final r = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(body),
        );
        printCurlCommand(r.request);
        return r;

      case 'PUT':
        final r = await http.put(uri, headers: headers, body: jsonEncode(body));
        printCurlCommand(r.request);
        return r;

      case 'DELETE':
        final r = await http.delete(uri, headers: headers);
        printCurlCommand(r.request);
        return r;

      default:
        throw ArgumentError('Unsupported method type: $method');
    }
  }

  static Map<String, dynamic> _processResponse(http.Response response) {
    final ok = response.statusCode >= 200 && response.statusCode < 300;

    Map<String, dynamic>? data;
    try {
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      if (decoded is Map<String, dynamic>) data = decoded;
    } on FormatException {
      data = null;
    }

    if (data == null) {
      return ok
          ? {'success': true}
          : {
              'success': false,
              'message': 'Request failed with status: ${response.statusCode}',
            };
    }

    // Backends that do not send a `success` flag: derive it from the status.
    data.putIfAbsent('success', () => ok);
    if (!ok && data['success'] != false) data['success'] = false;
    if (data['success'] == false) {
      data['message'] ??= 'Request failed with status: ${response.statusCode}';
    }
    return data;
  }

  static Map<String, dynamic> _fail(String message) {
    alertDialog('Error'.tr, message);
    return {'success': false, 'message': message};
  }
}
