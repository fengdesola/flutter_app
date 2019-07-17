import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoreWebPage extends StatefulWidget {
  //标题
  String title;
  //链接
  String url;

  CoreWebPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CoreWebPageState();
  }
}

class CoreWebPageState extends State<CoreWebPage> {
  WebViewController _controller;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: _initLeading(),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: _isLoading
                ? LinearProgressIndicator()
                : Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
      body: _initWebView(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initLeading() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _controller.canGoBack().then((value) {
              if (value) {
                _controller.goBack();
              } else {
                return Navigator.pop(context);
              }
            });
          },
        );
      },
    );
  }

  _initWebView() {
    return WebView(
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      }, // webview创建结束的回调。此处回调中将_controller指向webview
      initialUrl: widget.url, // 加载的URL链接
      javascriptMode: JavascriptMode.unrestricted, // 是否允许js执行
      onPageFinished: (url) {
        // 加载完成
        setState(() {
          _isLoading = false;
        });
      },
//      javascriptChannels: [
//        _alertJavascriptChannel(context),
//      ].toSet(), // JS和Flutter通信的渠道
    );
  }
}
