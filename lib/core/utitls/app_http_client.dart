import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bookme/core/utitls/environment.dart';
import 'package:http/http.dart' as http;

import '../errors/app_exceptions.dart';
import 'app_log.dart';

class AppHTTPClient {

  static const int requestTimeout = 10;

  static  String baseUrl = environment.url;


  //GET
  Future<Map<String,dynamic>> get(String endpoint) async {
    final Uri uri = Uri.parse(
      baseUrl + endpoint,
    );
    AppLog.i('============================ BASE URL ========================');
    AppLog.i(baseUrl);
    AppLog.i('============================ ENDPOINT ========================');
    AppLog.i(endpoint);
    try {
      final http.Response response = await http.get(uri).timeout(
            const Duration(seconds: requestTimeout),
          );
      return _processResponse(response);
    } on SocketException catch(err) {
      throw FetchDataException('Connection problem: $err', uri.toString());
    } on TimeoutException catch(err) {
      throw ApiNotRespondingException('Request Timeout: $err', uri.toString());
    }
  }

  // POST
  Future<Map<String,dynamic>> post(String endpoint,
      {required Map<String, dynamic> body}) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    AppLog.i('============================ ENDPOINT ========================');
    AppLog.i(endpoint);
    AppLog.i('====================== BODY SENT =========================');
    AppLog.i(body);
    try {
      final http.Response response =
          await http.post(uri, body: jsonEncode(body));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  //PUT
  Future<dynamic> put(String endpoint, {dynamic body}) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    AppLog.i('============================ ENDPOINT ========================');
    AppLog.i(endpoint);
    AppLog.i('====================== BODY SENT =========================');
    AppLog.i(body as Map<String, dynamic>);
    try {
      final http.Response response = await http.put(uri, body: body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  //DELETE

  Future<dynamic> delete(String endpoint) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    AppLog.i('============================ ENDPOINT ========================');
    AppLog.i(endpoint);
    try {
      final http.Response response = await http.delete(uri);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Connection problem', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Request Timeout', uri.toString());
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    print(response.body);
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson =
            jsonDecode(utf8.decode(response.bodyBytes));
        final String? totalCount = response.headers['total-count'];
        AppLog.i('============================ BODY RECEIVED ========================');
        AppLog.i(response.body);
        late Map<String, dynamic> data;
        if(responseJson is List){
          data = <String,dynamic>{
            'items': responseJson,
            'total_count': totalCount
          };
        }

        if(responseJson is Map<String,dynamic>){
          data = responseJson;
        }
        //AppLog.i(responseJson);
        return data;
      case 400:
        throw BadRequestException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 401:
        throw FetchDataException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 403:
        throw UnauthorizedException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      case 500:
        throw FetchDataException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );
      default:
        throw FetchDataException(
          'Error occurred with code ${response.statusCode}',
          response.request!.url.toString(),
        );
    }
  }
}
