import 'package:flutter/material.dart';
import 'package:flutter_app/common/res/DimenRes.dart';
import 'package:flutter_app/modules/app/FindPage.dart';
import 'package:flutter_app/modules/app/HomePage.dart';
import 'package:flutter_app/modules/app/MyPage.dart';

class MainTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainTabState();
  }
}

class MainTabState extends State<MainTabPage> {
  //默认索引
  int positionIndex = 0;

  //底部导航栏
  var mainTitles = ['首页', '发现', '我的'];

  List<Widget> _pages;
  List<BottomNavigationBarItem> _bottomItems;
  final GlobalKey navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _initAppBar(),
      body: _initIndexStack(),
      bottomNavigationBar: _initNavigationBar(),
    );
  }

  @override
  initState() {
    super.initState();
    _bottomItems = _initBottomItems();
    _pages = <Widget>[
      HomePage(),
      FindPage(),
      MyPage(),
    ];
  }

  AppBar _initAppBar() {
    return AppBar(
        title: Text(
      mainTitles[positionIndex],
//      style: TextStyleRes.normalMain,
    ));
  }

  _initIndexStack() {
    return IndexedStack(
      index: positionIndex,
      children: _pages,
    );
  }

  _initNavigationBar() {
    return BottomNavigationBar(
      items: _bottomItems,
      currentIndex: positionIndex,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: DimenRes.text_small,
      selectedFontSize: DimenRes.text_small,
//      unselectedItemColor: ,
//    selectedItemColor: ,
      onTap: (position) {
        setState(() {
          positionIndex = position;
        });
      },
    );
  }

  _initBottomItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text(
          mainTitles[0],
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment),
        title: Text(
          mainTitles[1],
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text(
          mainTitles[2],
        ),
      ),
    ];
  }
}
