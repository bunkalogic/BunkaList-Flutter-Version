import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/theme/app_themes.dart';
import 'package:bunkalist/src/core/theme/save_default_theme.dart';

import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(themeData: SaveDefaultTheme().changedInitialTheme());


  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if(event is ThemeChanged){
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
    
  }
}
