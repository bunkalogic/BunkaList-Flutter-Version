import 'package:flutter/material.dart';


enum Apptheme{
  LightTheme,
  DarkTheme,
  DarkerTheme,
  LighterTheme
}




final appThemeData = {

  //?Light Theme
  Apptheme.LightTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.deepOrangeAccent[400],
    brightness: Brightness.light,
    backgroundColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.grey[50],
    fontFamily: 'SourceSansPro',
    
    cardTheme: CardTheme(
      color: Colors.grey[200]
    ),

    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.grey[100],
      elevation: 5.0,
    ),
    

    
    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
      actionsIconTheme: IconThemeData(color: Colors.purpleAccent[700]),
      iconTheme: IconThemeData(color: Colors.purpleAccent[700], size: 30.0),
      elevation: 5.0,
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18.0, 
        fontWeight: FontWeight.w600, 
        fontStyle: FontStyle.italic
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
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
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.deepOrangeAccent[400],
    brightness: Brightness.dark,
    backgroundColor: Colors.blueGrey[800],
    scaffoldBackgroundColor: Colors.blueGrey[900],
    fontFamily: 'SourceSansPro',

    cardTheme: CardTheme(
      color: Colors.blueGrey[800]
    ),
    
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.blueGrey[800],
      elevation: 5.0,
    ),

    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[800],
      elevation: 5.0,
      actionsIconTheme: IconThemeData(color: Colors.purpleAccent[700]),
      iconTheme: IconThemeData(color: Colors.purpleAccent[700], size: 30.0),
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18.0, 
        fontWeight: FontWeight.w600, 
        fontStyle: FontStyle.italic
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.white ),

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


  //?Darker Theme
  Apptheme.DarkerTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.deepOrangeAccent[400],
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'SourceSansPro',

    cardTheme: CardTheme(
      color: Colors.grey[900]
    ),
    
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.grey[900],
      elevation: 5.0,
    ),

    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      elevation: 5.0,
      actionsIconTheme: IconThemeData(color: Colors.purpleAccent[700]),
      iconTheme: IconThemeData(color: Colors.purpleAccent[700], size: 30.0),
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18.0, 
        fontWeight: FontWeight.w600, 
        fontStyle: FontStyle.italic
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.white ),

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