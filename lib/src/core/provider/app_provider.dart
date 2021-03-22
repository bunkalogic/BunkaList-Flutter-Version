import 'package:bunkalist/src/core/theme/bloc/bloc.dart';
import 'package:flutter/widgets.dart';


class AppProvider extends InheritedWidget{
  
  static AppProvider _instance;

  factory AppProvider({ Key key, Widget child }){
      if(_instance == null){
        _instance = AppProvider._internal(key: key, child: child );
      }
      return _instance;
  }
  
    AppProvider._internal({Key key, Widget child})
    : super(key: key, child: child);
  
  
  
  final themeBloc = ThemeBloc();
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ThemeBloc of (BuildContext context){
      return(context.dependOnInheritedWidgetOfExactType<AppProvider>()).themeBloc;
  }

}