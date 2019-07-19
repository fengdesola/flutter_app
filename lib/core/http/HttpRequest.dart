import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/core/base/CoreVo.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/utils/LogUtils.dart';
import 'package:flutter_app/core/utils/ToastUtil.dart';
import 'package:http/http.dart' as http;

import 'Parser.dart' as parser;
import 'http.dart' as httpDio;

class HttpRequest {
  //开始网络请求
  static Future startRequest2<T extends CoreVo>(String url, Function callback,
      {String method,
      Map<String, String> headers,
      Map<String, String> params,
      Function errorCallback}) async {
    try {
      //这个是请求头参数
      Map<String, String> headerMap = headers ?? new Map();
      //这个是请求参数
      Map<String, String> paramMap = params ?? new Map();

      http.Response res;
      if (HttpUtils.POST == method) {
        LogUtils.d("POST:URL=" + url);
        LogUtils.d("POST:HEARDER=" + headerMap.toString());
        LogUtils.d("POST:BODY=" + paramMap.toString());
        res = await http.post(url, headers: headerMap, body: paramMap);
      } else {
        LogUtils.d("GET:URL=" + url);
        LogUtils.d("POST:HEARDER=" + headerMap.toString());
        res = await http.get(url, headers: headerMap);
      }

      /*if(res.statusCode < 200 || res.statusCode >= 300) {
        errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();
        handError(errorCallback, errorMsg);
        return;
      }*/

      if (res.statusCode != 200) {
        String errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();
        LogUtils.d(errorMsg);
        handError(errorCallback, HttpResult(res.statusCode, errorMsg, null));
        return;
      }

      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      //这个是相应body
      var body = res.body;
      LogUtils.d("response=" + body);
      Map<String, dynamic> map = json.decode(body);

      HttpResult result =
          HttpResult(map['errorCode'], map['errorMsg'], map['data']);

      if (callback != null) {
        if (result.isSuccess()) {
          callback(result);
        } else {
          handError(errorCallback, result);
        }
      }
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
      handError(errorCallback, HttpResult(null, e.toString(), null));
    }
  }

  //开始网络请求
  static Future startRequest<T extends CoreVo>(
    String url,
    Function callback, {
    String method,
    Map<String, String> headers,
    Map<String, String> params,
    Function errorCallback,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      //这个是请求头参数
      Map<String, String> headerMap = headers ?? new Map();
      //这个是请求参数
      Map<String, String> paramMap = params ?? new Map();

      Map<String, dynamic> httpHeaders =
          httpDio.dio.options.headers ?? new Map();
      httpHeaders.addAll(headerMap);
      httpDio.dio.options.headers = httpHeaders;

      Response<Map<String, dynamic>> res;

      if (HttpUtils.POST == method) {
        res = await httpDio.dio.post<Map<String, dynamic>>(url,
            queryParameters: paramMap,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
      } else {
        res = await httpDio.dio.get<Map<String, dynamic>>(url,
            queryParameters: paramMap,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress);
      }

      if (res.statusCode != 200) {
        String errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();
        LogUtils.d(errorMsg);
        handError(errorCallback, HttpResult(res.statusCode, errorMsg, null));
        return;
      }

      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      //这个是相应body

      Map<String, dynamic> map = res.data;

      var resultData = await parser.parse<T>(map['data']);
      HttpResult result =
          HttpResult(map['errorCode'], map['errorMsg'], resultData);

      if (callback != null) {
        if (result.isSuccess()) {
          callback(result);
        } else {
          handError(errorCallback, result);
        }
      }
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
      handError(errorCallback, HttpResult(null, e.toString(), null));
    }
  }

  static void handError(Function errorCallback, HttpResult error) {
    ToastUtil.toast(error.msg);
    if (errorCallback != null) {
      errorCallback(error);
    }
  }
}
