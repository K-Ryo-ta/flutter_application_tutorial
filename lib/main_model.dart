import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  int a = 0;
  void change() {
    a = 2;
    notifyListeners();
  }
}
