import 'package:flutter/material.dart';

const int END = 1; //没有更多数据
const int LOADING = 2;

class LoadMoreEndView extends StatelessWidget {
  final Color backgroundColor;
  final String msg;
  final Color textColor;
  LoadMoreEndView(
      {this.msg: "没有更多数据呢！",
      this.backgroundColor: const Color(0xFFFFFFFF),
      this.textColor: const Color(0xFF000000)});

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 16.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Divider(
              height: 8.0,
            ),
            flex: 1,
          ),
          new Text(
            msg,
            style: new TextStyle(color: textColor),
          ),
          new Expanded(
            child: new Divider(
              height: 8.0,
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class LoadMoreIngView extends StatelessWidget {
  final Color backgroundColor;
  final String msg;
  final Color textColor;
  LoadMoreIngView(
      {this.msg: "加载中...",
      this.backgroundColor: const Color(0xFFFFFFFF),
      this.textColor: const Color(0xFF000000)});
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            msg,
            style: new TextStyle(color: textColor),
          ),
          new CircularProgressIndicator(
            strokeWidth: 1,
            //backgroundColor: YcColors.colorPrimary,
          )
        ],
      ),
    );
  }
}
