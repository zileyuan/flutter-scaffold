import 'package:flutter/material.dart';
import 'package:app/models/user_model.dart';
import 'package:app/utils/sp_util.dart';
import 'package:app/network/http_util.dart';
import 'package:umeng_analytics_push/umeng_analytics_push.dart';

const String _userData = "userData";
class UserNotifier with ChangeNotifier {
  static UserModel userModel;
  static bool isLogin() => userModel != null;

  UserNotifier() {
    Future.wait([initUserModel()]).then((_){
      notifyListeners();
    });
  }

  //初始化用户信息
  static Future initUserModel() async {
    var obj = await SpUtil.loadPreferences(_userData);
    if (obj != null) {
      userModel = UserModel.fromJson(obj);
      HttpUtil().token = userModel.token;
      UmengAnalyticsPush.addAlias(userModel.id.toString(), 'uid');
    }
  }

  void changeUserModel(UserModel um) {
    if (um != null) {
      UmengAnalyticsPush.addAlias(um.id.toString(), 'uid');
      HttpUtil().token = um.token;
      SpUtil.savePreferences(_userData, um.toJson());
    } else {
      UmengAnalyticsPush.deleteAlias(userModel.id.toString(), 'uid');
      HttpUtil().token = null;
      SpUtil.removePreferences(_userData);
    }
    userModel = um;
    notifyListeners();
  }
}
