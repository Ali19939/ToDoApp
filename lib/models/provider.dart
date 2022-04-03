import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  bool _darkTheme = true;

  bool get dark => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }
}
