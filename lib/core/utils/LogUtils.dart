import 'package:flutter_app/core/CoreConstant.dart';

class LogUtils {
  ///打印日志
  static d(String str) {
    if (CoreConstant.debug) {
      print("log===$str");
    }
  }
}
