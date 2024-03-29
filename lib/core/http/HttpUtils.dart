/*
Copyright 2017 yangchong211（github.com/yangchong211）

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:flutter_app/core/CoreConstant.dart';
import 'package:flutter_app/core/base/CoreVo.dart';

import 'HttpRequest.dart';

/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/9/12
 *     desc  : 网络请求工具类
 *     revise:
 * </pre>
 */
class HttpUtils {
  static const String GET = "get";
  static const String POST = "post";

  //get请求
  static void get<T extends CoreVo>(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = CoreConstant.baseUrl + url;
    }

    //做非空判断
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer();
      if (!url.contains("?")) {
        sb.write("?");
      }
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    await HttpRequest.startRequest<T>(url, callback,
        method: GET, headers: headers, errorCallback: errorCallback);
  }

  //post请求
  static void post<T extends CoreVo>(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = CoreConstant.baseUrl + url;
    }
    await HttpRequest.startRequest<T>(url, callback,
        method: POST,
        headers: headers,
        params: params,
        errorCallback: errorCallback);
  }
}
