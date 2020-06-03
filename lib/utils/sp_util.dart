import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
}
