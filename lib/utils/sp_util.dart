import 'package:app/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/models/user_model.dart';
import 'package:app/network/http_util.dart';
import 'dart:convert';

const String _userData = "userData";
const String _tokenData = "tokenData";

class SpUtil {

  static Future savePreferences(String key, Object obj) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, json.encode(obj));
  }

  static Future loadPreferences(String key) async {
    var sp = await SharedPreferences.getInstance();
    var obj = sp.getString(key);
    if (obj != null) {
      return json.decode(obj);
    }
    return null;
  }

  static Future removePreferences(String key) async {
    var sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

//  static Future<void> setUserData(UserModel userModel) async {
//    var sp = await SharedPreferences.getInstance();
//    sp.setString(_userData, json.encode(userModel.toJson()));
//  }
//
//  static delUserData() async {
//    var sp = await SharedPreferences.getInstance();
//    sp.remove(_userData);
//  }
//
//  static Future<TokenModel> getTokenData() async {
//    var sp = await SharedPreferences.getInstance();
//    String tokenData = sp.getString(_tokenData);
//    if (tokenData != null) {
//      var tokenModel = TokenModel.fromJson(json.decode(tokenData));
//      HttpUtil.instance.token = tokenModel.token;
//      return tokenModel;
//    }
//    return null;
//  }
//
//  static Future<void> setTokenData(TokenModel tokenModel) async {
//    var sp = await SharedPreferences.getInstance();
//    sp.setString(_tokenData, json.encode(tokenModel.toJson()));
//  }
//
//  static delTokenData() async {
//    var sp = await SharedPreferences.getInstance();
//    sp.remove(_tokenData);
//  }
}
