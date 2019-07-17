import 'package:flutter/material.dart';
import 'package:flutter_app/common/res/ColorRes.dart';
import 'package:flutter_app/common/res/DimenRes.dart';

class TextStyleRes {
  static const TextStyle normalMain = TextStyle(
    fontSize: DimenRes.text_normal,
    color: ColorRes.text_main,
  );
  static const TextStyle normalSub = TextStyle(
    fontSize: DimenRes.text_normal,
    color: ColorRes.text_sub,
  );
  static const TextStyle normalLight = TextStyle(
    fontSize: DimenRes.text_normal,
    color: ColorRes.text_light,
  );

  static const TextStyle largeMain = TextStyle(
    fontSize: DimenRes.text_large,
    color: ColorRes.text_main,
  );
  static const TextStyle largeSub = TextStyle(
    fontSize: DimenRes.text_large,
    color: ColorRes.text_sub,
  );

  static const TextStyle smallMain = TextStyle(
    fontSize: DimenRes.text_small,
    color: ColorRes.text_main,
  );
  static const TextStyle smallSub = TextStyle(
    fontSize: DimenRes.text_small,
    color: ColorRes.text_sub,
  );
  static const TextStyle smallLight = TextStyle(
    fontSize: DimenRes.text_small,
    color: ColorRes.text_light,
  );
  static const TextStyle microLight = TextStyle(
    fontSize: DimenRes.text_micro,
    color: ColorRes.text_light,
  );
  static const TextStyle microSub = TextStyle(
    fontSize: DimenRes.text_micro,
    color: ColorRes.text_sub,
  );

  static TextStyle large(Color color) {
    return TextStyle(fontSize: DimenRes.text_large, color: color);
  }

  static TextStyle normal(Color color) {
    return TextStyle(fontSize: DimenRes.text_normal, color: color);
  }

  static TextStyle small(Color color) {
    return TextStyle(fontSize: DimenRes.text_small, color: color);
  }

  static TextStyle micro(Color color) {
    return TextStyle(fontSize: DimenRes.text_micro, color: color);
  }
}
