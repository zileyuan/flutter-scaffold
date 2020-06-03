import 'package:flutter/material.dart';
import 'package:app/utils/sp_util.dart';

const String _themeData = "themeData";

class UINotifier with ChangeNotifier {
  static ThemeMode themeMode = ThemeMode.system;

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  UINotifier() {
    Future.wait([initTheme()]).then((_) {
      notifyListeners();
    });
  }

  Future initTheme() async {
    var obj = await SpUtil.loadPreferences(_themeData);
    if (obj != null) {
      var m = ThemeMode.values[obj["theme"]];
      if (m != themeMode) {
        themeMode = m;
      }
    }
  }

  void changeThemeMode(ThemeMode m) {
    if (m != themeMode) {
      themeMode = m;
      SpUtil.savePreferences(_themeData, {"theme": m.index});
      notifyListeners();
    }
  }

}