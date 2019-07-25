import 'package:flutter/material.dart';
import 'package:flutter_app/common/res/TextStyleRes.dart';
import 'package:flutter_app/modules/app/FindPage.dart';
import 'package:flutter_app/modules/app/HomePage.dart';

class MainTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainTabState();
  }
}

class MainTabState extends State<MainTabPage> {
  //默认索引
  int positionIndex = 1;
  //底部导航栏
  var mainTitles = ['首页', '发现', '我的'];
  IndexedStack indexStack;
  List<BottomNavigationBarItem> navigationViews;
  final GlobalKey navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: _initAppBar(),
        body: indexStack,
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _initIndexStack();
  }

  AppBar _initAppBar() {
    return AppBar(
        title: Text(
      mainTitles[positionIndex],
      style: TextStyleRes.normalMain,
    ));
  }

  void _initIndexStack() {
    indexStack = IndexedStack(
      index: positionIndex,
      children: <Widget>[
        HomePage(),
        FindPage(),
      ],
    );
  }
}
