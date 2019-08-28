import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/theme/app_themes.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(themeData: appThemeData[Apptheme.LightTheme]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if(event is ThemeChanged){
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }
}
