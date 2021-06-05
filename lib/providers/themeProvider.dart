import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ThemePro with ChangeNotifier {
  ThemeData ltheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    primaryColor: Colors.black,
  );

  ThemeData dtheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[700],
    primaryColor: Colors.white,
    accentColor: Colors.black,
  );

  ThemeData currentTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.black,
    accentColor: Colors.grey,
  );

  void switchTheme() {
    if (currentTheme == ltheme)
      currentTheme = dtheme;
    else {
      currentTheme = ltheme;
    }
    print("nosaa");
    notifyListeners();
  }
}
