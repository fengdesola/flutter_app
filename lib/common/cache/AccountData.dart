import 'package:shared_preferences/shared_preferences.dart';

class AccountData {
  static final String LOGIN = "isLogin";
  static final String USER_NAME = "userName";

  // 保存用户登录信息，data中包含了userName
  static Future saveLoginInfo(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(USER_NAME, userName);
    await sp.setBool(LOGIN, true);
  }

  //清除用户登陆的信息
  static Future clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }

  //获取用户名
  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(USER_NAME);
  }

  //判断是否登陆
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool b = sp.getBool(LOGIN);
    return b ?? false;
  }
}
