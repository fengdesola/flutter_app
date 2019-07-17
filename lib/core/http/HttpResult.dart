class HttpResult {
  /*
  返回数据结构如下所示
   {
  "data": ...,
  "errorCode": 0,
  "errorMsg": ""
   }
   */

  int code;
  String msg;
  var data;

  HttpResult(this.code, this.msg, this.data);

  bool isEmpty() {
    if (data == null) {
      return true;
    }
    if (data is List) {
      return (data as List).isEmpty;
    }
    return false;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }

  bool isSuccess() => code != null && code >= 0;
}
