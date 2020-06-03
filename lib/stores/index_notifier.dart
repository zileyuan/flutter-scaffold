import 'package:flutter/material.dart';

class IndexNotifier with ChangeNotifier {
  static int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
