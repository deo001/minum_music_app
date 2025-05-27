import 'package:flutter/material.dart';
import 'package:minum_music_app/theme/dark_mode.dart';
import 'package:minum_music_app/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // inirtially light mode
  ThemeData _themeData = lightMode;
  
  //get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;


  // set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;

    // notify UI
    notifyListeners();
  }

  // toggle theme
  void toggleTheme(){
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }


}