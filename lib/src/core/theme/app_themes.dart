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
      actionsIconTheme: IconThemeData(color: Colors.purpleAccent[700]),
      iconTheme: IconThemeData(color: Colors.purpleAccent[700], size: 30.0),
      elevation: 5.0,
      textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontSize: 20.0, 
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.black)
    ),


    tabBarTheme: TabBarTheme(
      
      labelColor: Colors.deepOrangeAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 1.0, color:  Colors.grey[600], offset: Offset(1.0, 1.0))]
      ),
      labelStyle: TextStyle(
        fontSize: 18.0, 
        fontWeight: FontWeight.w800, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))]
      ),
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
      color: Colors.grey[700]
    ),

    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      elevation: 5.0,
      actionsIconTheme: IconThemeData(color: Colors.purpleAccent[700]),
      iconTheme: IconThemeData(color: Colors.purpleAccent[700], size: 30.0),
      textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0, 
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      title: TextStyle(color: Colors.white ),

    ),

    tabBarTheme: TabBarTheme(
      labelColor: Colors.deepOrangeAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 1.0, color:  Colors.grey[600], offset: Offset(1.0, 1.0))]
        ),
      labelStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w800, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(1.0, 1.0))]
        )
    ),
    
  ),


  


};