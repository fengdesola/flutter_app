import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../CoreConstant.dart';

//dio 单例
Dio dio = Dio();

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class HttpDio {
  HttpDio.init() {
    bool debug = CoreConstant.debug;
    // add interceptors
    dio.interceptors
      ..add(CookieManager(CookieJar()))
      ..add(LogInterceptor(requestBody: debug, responseBody: debug));
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 15000;
    dio.options.baseUrl = CoreConstant.baseUrl;
//  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//      (client) {
//    client.findProxy = (uri) {
//      //proxy to my PC(charles)
//      return "PROXY 10.1.10.250:8888";
//    };
//  };
  }
}
