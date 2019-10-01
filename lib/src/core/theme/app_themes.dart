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
    fontFamily: 'SourceSansPro',
    
    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
      actionsIconTheme: IconThemeData(color: Colors.purple[500]),
      iconTheme: IconThemeData(color: Colors.purple[500], size: 30.0),
      textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontSize: 18.0, 
        fontWeight: FontWeight.w600, 
        fontStyle: FontStyle.italic
        ),

    ),
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
    fontFamily: 'SourceSansPro',

    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      elevation: 10.0,
      actionsIconTheme: IconThemeData(color: Colors.purple[500]),
      iconTheme: IconThemeData(color: Colors.purple[500], size: 30.0),
      textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 18.0, 
        fontWeight: FontWeight.w600, 
        fontStyle: FontStyle.italic
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.white ),

    ),

    
  ),


  


};