import 'package:flutter/material.dart';

abstract class CoreState<T extends StatefulWidget> extends State<T> {
  bool _isEmpty = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  } //判断是否正在加载中，防止多次网络请求

  Status status = Status.restore;

  CoreState();

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    switch (status) {
      case Status.empty:
        _widget = Center(
          child: Text("no data"),
        );
        break;
      case Status.error:
        _widget = Center(
          child: InkWell(
            child: Text(
              "error",
            ),
            onTap: onRefresh,
          ),
        );
        break;
      case Status.loading:
        _widget = Center(
          child: CircularProgressIndicator(),
        );
        break;
      case Status.restore:
        _widget = null;
        break;
    }

    return _widget;
  }

  showEmptyView() {
    _isLoading = false;
    _isEmpty = true;
    setState(() {
      status = Status.empty;
    });
  }

  restoreView() {
    _isLoading = false;
    _isEmpty = false;
    setState(() {
      status = Status.restore;
    });
  }

  showErrorView() {
    _isLoading = false;
    setState(() {
      status = Status.error;
    });
  }

  showLoadingView() {
    _isLoading = true;
    setState(() {
      status = Status.loading;
    });
  }

  bool isEmpty() => _isEmpty;

  onRefresh();
}

enum Status {
  //是否数据为空，为空时一般显示空页面
  empty,
  error,
  loading,
  //恢复原始默认布局，也就是返回null
  restore,
}
