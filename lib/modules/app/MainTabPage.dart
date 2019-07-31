import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/cache/AccountData.dart';
import 'package:flutter_app/common/event/LoginEvent.dart';
import 'package:flutter_app/common/event/LogoutEvent.dart';
import 'package:flutter_app/common/res/DimenRes.dart';
import 'package:flutter_app/core/eventbus/EventBus.dart';
import 'package:flutter_app/core/utils/AppNavigator.dart';
import 'package:flutter_app/core/utils/StringUtil.dart';
import 'package:flutter_app/core/widget/drawer/SmartDrawer.dart';
import 'package:flutter_app/modules/account/LoginPage.dart';
import 'package:flutter_app/modules/app/FindPage.dart';
import 'package:flutter_app/modules/app/HomePage.dart';
import 'package:flutter_app/modules/app/MyPage.dart';
import 'package:flutter_app/modules/article/ArticleCollectionPage.dart';

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
  final GlobalKey<MyPageState> _myPageKey = GlobalKey<MyPageState>();
  String accountName;
  StreamSubscription _subLogin;
  StreamSubscription _subLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _initAppBar(),
      body: _initIndexStack(),
      bottomNavigationBar: _initNavigationBar(),
      drawer: _initDrawer(),
    );
  }

  @override
  initState() {
    super.initState();
    _bottomItems = _initBottomItems();
    _pages = <Widget>[
      HomePage(),
      FindPage(),
      MyPage(
        key: _myPageKey,
      ),
    ];

    setAccount();

    _subLogin = eventBus.on<LoginEvent>().listen((event) {
      setAccount();
      _myPageKey.currentState.setAccount();
    });
    _subLogout = eventBus.on<LogoutEvent>().listen((event) {
      setAccount();
      _myPageKey.currentState.setAccount();
    });
  }

  void setAccount() {
    AccountData.getUserName().then((value) {
      setState(() {
        accountName = value;
      });
    });
  }

  @override
  void dispose() {
    _subLogin?.cancel();
    _subLogout?.cancel();
    AccountData.clearLoginInfo();
    super.dispose();
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

  ///初始化侧滑菜单控件
  SmartDrawer _initDrawer() {
    return SmartDrawer(
      widthPercent: 0.7,
      elevation: 12,
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(StringUtil.notNull(accountName)),
            accountEmail: Text(
              StringUtil.isEmpty(accountName)
                  ? "xxx@xxx.com"
                  : '$accountName@xxx.com',
            ),
            onDetailsPressed: () {
              AppNavigator.push(context, LoginPage());
            },
            currentAccountPicture: CircleAvatar(
//              child: Image.network(
//                  "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
              backgroundImage: NetworkImage(
                "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
              ),
            ),
          ),
          new ListTile(
              title: new Text("我的收藏"),
              trailing: new Icon(Icons.email),
              onTap: () {
                AppNavigator.push(context, ArticleCollectionPage());
              }),
          new Divider(),
        ],
      ),
    );
  }
}
