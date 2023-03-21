import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../resource/strings.dart';
import '../utils/connectivity/connectivity_adapter.dart';
import '../utils/connectivity/generic_error.dart';

@singleton
class ApiSource {
  final String baseUrl;
  final http.Client client;
  final Connectivity connectivity;

  final Duration timeout = const Duration(seconds: 30);

  ApiSource(
    @Named('baseUrl') this.baseUrl,
    this.client,
    this.connectivity,
  );


  Future<T> getService<T>(
    Uri url,
    T Function(dynamic value) mapperFunction) async {
    try {
      if (!await connectivity.isConnected()) {
        throw GenericError(errorMsg: 'Error de conexiòn', errorCode: "noInternet");
      }
      final http.Response service = await client.get(url).timeout(timeout);
      dynamic bodyResponse = await _getResponse(service, mapperFunction);
      return bodyResponse;
    } catch (error) {
      if (error is GenericError) {
        throw GenericError(
            errorMsg: error.errorMsg,
            errorCode: error.errorCode);
      } else {
        throw GenericError(
            errorMsg: Strings.errorGeneric,
            errorCode: "500");
      }
    }
  }

Future<T> _getResponse<T>(
    http.Response response,
    T Function(dynamic value) mapperFunction,
    ) async {
  if (response.statusCode >= 200) {
    dynamic body = response.bodyBytes;
    String bodyString = utf8.decode(body as List<int>);
    return mapperFunction(json.decode(bodyString));
  } else {
    throw GenericError(
        errorMsg: Strings.errorGeneric,
        errorCode: "500");
  }
}


}