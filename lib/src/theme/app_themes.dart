import 'package:flutter/material.dart';


enum Apptheme{
  LightTheme,
  DarkTheme,
}

final appThemeData = {

  //?Light Theme
  Apptheme.LightTheme : ThemeData(
    primaryColor: Colors.purple[700],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.purple[900],
    accentColor: Colors.orangeAccent[700],
    brightness: Brightness.light,
    backgroundColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.grey[100],
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
    ),
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.black)
      ),
  ),

  //?Dark Theme
  Apptheme.DarkTheme : ThemeData(
    primaryColor: Colors.purple[700],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.purple[900],
    accentColor: Colors.orange[900],
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[850],
    scaffoldBackgroundColor: Colors.grey[900],
    bottomAppBarColor: Colors.grey[850],
    cardColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[850],
    ),
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.white)
      ),

    
  ),
  


};