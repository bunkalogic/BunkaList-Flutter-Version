import 'package:flutter/material.dart';


enum Apptheme{
  LightTheme,
  DarkTheme,
}

final appThemeData = {

  Apptheme.LightTheme : ThemeData(
    primaryColor: Colors.purple[700],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.purple[900],
    accentColor: Colors.orangeAccent[700],
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.grey[100],
    
  ),
  Apptheme.DarkTheme : ThemeData(
    primaryColor: Colors.purple[700],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.purple[900],
    accentColor: Colors.amber[900],
    brightness: Brightness.dark,
    backgroundColor: Colors.blueGrey[850],
    scaffoldBackgroundColor: Colors.blueGrey[900],
    bottomAppBarColor: Colors.blueGrey[850],
    
  ),
  


};