import 'package:flutter/material.dart';
import 'package:flutter_app/common/res/ColorRes.dart';

/// 间隔
class GapRes {
  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: 4);
  static const Widget hGap8 = SizedBox(width: 8);
  static const Widget hGap12 = SizedBox(width: 12);
  static const Widget hGap16 = SizedBox(width: 16);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: 4);
  static const Widget vGap8 = SizedBox(height: 8);
  static const Widget vGap12 = SizedBox(height: 12);
  static const Widget vGap16 = SizedBox(height: 16);

  static Widget line = Container(height: 0.6, color: ColorRes.line);
  static Widget lineB = Container(height: 4, color: ColorRes.line);
  static const Widget empty = SizedBox();
}
