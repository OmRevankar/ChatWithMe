import 'package:chatwithme/themes/Dark_Mode.dart';
import 'package:chatwithme/themes/light_mode.dart';
import 'package:flutter/material.dart';


class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData = LightMode;

  ThemeData get themeData => _themeData;

  //tells wheter the theme is dark or not
  bool get isDarkMode => _themeData == DarkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == LightMode){
      themeData = DarkMode;
    }
    else{
      themeData = LightMode;
    }
  }

}