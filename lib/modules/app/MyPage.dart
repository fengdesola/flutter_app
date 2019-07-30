import 'package:flutter/material.dart';
import 'package:flutter_app/common/api/HttpApi.dart';
import 'package:flutter_app/common/cache/AccountData.dart';
import 'package:flutter_app/common/res/DimenRes.dart';
import 'package:flutter_app/common/res/GapRes.dart';
import 'package:flutter_app/common/res/TextStyleRes.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/utils/AppNavigator.dart';
import 'package:flutter_app/core/utils/ObjectUtil.dart';
import 'package:flutter_app/core/utils/StringUtil.dart';
import 'package:flutter_app/core/utils/ToastUtil.dart';
import 'package:flutter_app/modules/account/LoginPage.dart';
import 'package:flutter_app/modules/article/ArticleCollectionPage.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class MyPageState extends State<MyPage> {
  String accountName;

  @override
  void initState() {
    super.initState();
    AccountData.getUserName().then((value) {
      accountName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(DimenRes.dp_16),
          child: Center(
              child: Text(
            StringUtil.notNull(accountName),
            style: TextStyleRes.normalMain,
          )),
        ),
        _initItem(Icons.label_important, "开始登陆", () {
          AppNavigator.push(context, LoginPage(), function: (result) {
            if (result is bool && ObjectUtil.boolF(result)) {
              AccountData.getUserName().then((value) {
                setState(() {
                  accountName = value;
                });
              });
            }
          });
        }),
        GapRes.line,
        _initItem(Icons.email, "我的收藏", () {
          AppNavigator.push(context, ArticleCollectionPage());
        }),
        GapRes.line,
        _initItem(Icons.account_balance_wallet, "退出登录", () {
          HttpUtils.get(HttpApi.LOGOUT, (HttpResult httpResult) {
            AccountData.clearLoginInfo().then((value) {
              ToastUtil.toast("退出登录");
            });
          });
        }),
        GapRes.line,
      ],
    );
  }

  _initItem(IconData iconData, String title, Function() fun) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title, style: TextStyleRes.normalMain),
      trailing: Icon(Icons.arrow_forward),
      onTap: fun,
    );
  }
}
