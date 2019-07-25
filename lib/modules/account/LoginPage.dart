import 'package:flutter/material.dart';
import 'package:flutter_app/common/bean/account/login_user_entity.dart';
import 'package:flutter_app/common/cache/AccountData.dart';
import 'package:flutter_app/common/res/GapRes.dart';
import 'package:flutter_app/common/res/StringRes.dart';
import 'package:flutter_app/core/http/HttpResult.dart';
import 'package:flutter_app/core/http/HttpUtils.dart';
import 'package:flutter_app/core/utils/ToastUtil.dart';
import 'package:flutter_app/modules/app/MainTabPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRes.login),
      ),
      body: LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageBodyState();
  }
}

class LoginPageBodyState extends State<LoginPageBody> {
  bool pwdShow = true;
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
//            alignment: Alignment(1, 0.5),
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.blue),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.text_fields),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
//              helperText: StringRes.login_page_user_name_input_hint,
                hintText: StringRes.login_page_user_name_input_hint,
              ),
            ),
//              new Positioned(top: 16, right: 16, child: Icon(Icons.clear)),
            Icon(Icons.clear),
          ],
        ),
        Container(
          color: Colors.red,
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(StringRes.login_page_user_name),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10.0),
                        icon: Icon(Icons.text_fields),
                        suffixIcon: Icon(Icons.add),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
//              helperText: StringRes.login_page_user_name_input_hint,
                        hintText: StringRes.login_page_user_name_input_hint,
                      ),
                    ),
                    Padding(
                      child: Icon(Icons.clear),
                      padding: EdgeInsets.only(right: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: userController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.blue),
//          onChanged: _userOnChange,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.phone),
            suffixIcon: Offstage(
              offstage:
                  userController.text == null || userController.text.isEmpty,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.black38,
                ),
                padding: EdgeInsets.all(10),
                onPressed: _userClearOnPressed,
              ),
            ),
            hintText: StringRes.login_page_user_name_input_hint,
          ),
        ),
        GapRes.vGap16,
        TextField(
          controller: pwdController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.blue),
          obscureText: pwdShow,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                !pwdShow ? Icons.lock_outline : Icons.lock_open,
                color: Colors.black38,
              ),
              padding: EdgeInsets.all(10),
              onPressed: _pwdOnPressed,
            ),
            hintText: StringRes.login_page_user_pwd_input_hint,
          ),
        ),
        SizedBox(
          height: 100,
        ),
        RaisedButton(
          onPressed: _loginOnPressed,
          child: Text(StringRes.login),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    userController.text = "solasola";
    pwdController.text = "solasola";
  }

  @override
  void dispose() {
    userController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  void _pwdOnPressed() {
    setState(() {
      pwdShow = !pwdShow;
    });
  }

  void _userClearOnPressed() {
    userController.clear();
  }

  void _loginOnPressed() {
    if (_validate()) {
      HttpUtils.post<LoginUserEntity>(
          "user/login",
          (HttpResult httpResult) {
            if (httpResult.isSuccess() && httpResult.isNotEmpty()) {
//              LoginUserVo loginUserVo = LoginUserVo.fromJson(httpResult.data);
              LoginUserEntity loginUserVo = httpResult.data;

              AccountData.saveLoginInfo(loginUserVo.username).then((r) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MainTabPage();
                }));
              });
            }
          },
          params: Map.from({
            "username": userController.text,
            "password": pwdController.text
          }),
          errorCallback: (HttpResult httpResult) {
            ToastUtil.toast(httpResult.msg);
          });
    }
  }

  bool _validate() {
    if (userController.text.trim().isEmpty) {
      ToastUtil.toast(StringRes.login_page_user_name_input_hint);
      return false;
    } else if (pwdController.text.trim().isEmpty) {
      ToastUtil.toast(StringRes.login_page_user_pwd_input_hint);
      return false;
    }
    return true;
  }
}
