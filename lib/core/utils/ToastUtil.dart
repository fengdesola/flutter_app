import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void toast(String txt) {
    Fluttertoast.showToast(msg: txt);
  }

  static GlobalKey<ScaffoldState> scaffoldKey;

  static showSnack(String msg) {
    if (scaffoldKey == null) {
      scaffoldKey = new GlobalKey<ScaffoldState>();
    }
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(msg)));
  }
}
