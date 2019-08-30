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
    brightness: Brightness.light,
    backgroundColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
    ),
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.black)
      ),
    bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.grey[100],
        elevation: 10.0
      ),
    
  ),
  Apptheme.DarkTheme : ThemeData(
    primaryColor: Colors.purple[700],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.purple[900],
    accentColor: Colors.orange[900],
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[850],
    scaffoldBackgroundColor: Colors.grey[900],
    bottomAppBarColor: Colors.grey[850],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
    ),
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.white)
      ),
    bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.grey[900],
        elevation: 10.0
      ),
    
  ),
  


};