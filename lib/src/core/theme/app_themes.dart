import 'package:flutter/material.dart';


enum Apptheme{
  LightTheme,
  DarkTheme,
  DarkerTheme,
  SepiaTheme,
  BlueDarkTheme
}




final appThemeData = {

  //?Light Theme
  Apptheme.LightTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.pinkAccent[400],
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
      actionsIconTheme: IconThemeData(color: Colors.deepPurpleAccent[400]),
      iconTheme: IconThemeData(color: Colors.deepPurpleAccent[400], size: 30.0),
      elevation: 5.0,
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),

    

    tabBarTheme: TabBarTheme(
      
      labelColor: Colors.deepPurpleAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
      ),
      labelStyle: TextStyle(
        fontSize: 16.0, 
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
      ),
    ),
  ),


  //?Light Theme
  Apptheme.SepiaTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.pinkAccent[400],
    // brightness: Brightness.light,
    backgroundColor: Color(0xFFFFEDDE),
    scaffoldBackgroundColor: Color(0xFFFFEDDE),
    fontFamily: 'SourceSansPro',
    
    cardTheme: CardTheme(
      color: Color(0xFFFFDFC5)
    ),

    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xFFFFDFC5),
      elevation: 5.0,
    ),
    

    
    appBarTheme: AppBarTheme(
      color: Color(0xFFFFEDDE),
      actionsIconTheme: IconThemeData(color: Colors.deepPurpleAccent[400]),
      iconTheme: IconThemeData(color: Colors.deepPurpleAccent[400], size: 30.0),
      elevation: 5.0,
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
        ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),

    

    tabBarTheme: TabBarTheme(
      
      labelColor: Colors.deepPurpleAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
      ),
      labelStyle: TextStyle(
        fontSize: 16.0, 
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
      ),
    ),
  ),






  //?Dark Theme
  Apptheme.DarkTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.pinkAccent[400],
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
      actionsIconTheme: IconThemeData(color: Colors.pinkAccent[400]),
      iconTheme: IconThemeData(color: Colors.pinkAccent[400], size: 30.0),
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
      ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.white ),

    ),

    tabBarTheme: TabBarTheme(
      labelColor: Colors.pinkAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
        ),
      labelStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.black, offset: Offset(0.5, 0.5))]
        )
    ),
    
  ),


  //?Darker Theme
  Apptheme.DarkerTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.pinkAccent[400],
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
      actionsIconTheme: IconThemeData(color: Colors.pinkAccent[400]),
      iconTheme: IconThemeData(color: Colors.pinkAccent[400], size: 30.0),
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
      ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.white ),

    ),

    tabBarTheme: TabBarTheme(
      labelColor: Colors.pinkAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
        ),
      labelStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
        )
    ),
    
  ),
  


  //? Blue Dark Theme
  Apptheme.BlueDarkTheme : ThemeData(
    primaryColor: Colors.deepPurpleAccent[400],
    primaryColorLight: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurpleAccent[700],
    accentColor: Colors.pinkAccent[400],
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF15202B),
    scaffoldBackgroundColor: Color(0xFF111E2B),
    fontFamily: 'SourceSansPro',

    cardTheme: CardTheme(
      color: Color(0xFF15202B)
    ),
    
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xFF15202B),
      elevation: 5.0,
    ),

    appBarTheme: AppBarTheme(
      color: Color(0xFF15202B),
      elevation: 5.0,
      actionsIconTheme: IconThemeData(color: Colors.pinkAccent[400]),
      iconTheme: IconThemeData(color: Colors.pinkAccent[400], size: 30.0),
      textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
      ),

    ),
    ),
    
    primaryTextTheme: TextTheme(
      headline6: TextStyle(color: Colors.white ),

    ),

    tabBarTheme: TabBarTheme(
      labelColor: Colors.pinkAccent[400],
      unselectedLabelColor: Colors.blueGrey[200],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w500,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.grey[600], offset: Offset(0.5, 0.5))]
        ),
      labelStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700, 
        fontStyle: FontStyle.italic,
        shadows: [Shadow(blurRadius: 0.5, color:  Colors.black, offset: Offset(0.5, 0.5))]
        )
    ),
    
  ),


};