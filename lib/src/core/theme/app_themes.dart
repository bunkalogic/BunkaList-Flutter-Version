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
    fontFamily: 'SourceSansPro',
    
    cardTheme: CardTheme(
      color: Colors.grey[200]
    ),

    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
      actionsIconTheme: IconThemeData(color: Colors.deepPurpleAccent[700]),
      iconTheme: IconThemeData(color: Colors.deepPurpleAccent[700], size: 30.0),
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


    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.blueGrey[400],
      unselectedLabelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic,),
      labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic,),
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
    fontFamily: 'SourceSansPro',

    cardTheme: CardTheme(
      color: Colors.grey[850]
    ),

    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      elevation: 10.0,
      actionsIconTheme: IconThemeData(color: Colors.deepPurpleAccent[400]),
      iconTheme: IconThemeData(color: Colors.deepPurpleAccent[400], size: 30.0),
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

    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.blueGrey[400],
      unselectedLabelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
      labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)
    ),
    
  ),


  


};