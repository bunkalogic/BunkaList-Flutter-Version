

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/theme/app_themes.dart';
import 'package:bunkalist/src/core/theme/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveDefaultTheme{

  final prefs = new Preferences();

  changedTheme(BuildContext context, Apptheme theme) {
    // if(prefs.whatModeIs == isDark) {
    //   prefs.whatModeIs = false;
    //   BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: theme));
    // }else if(prefs.whatDarkIs){
    //   prefs.whatModeIs = true;
    //   BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: theme));
    // }
    BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: theme));
  }

  // changedTheme(BuildContext context) {
  //   if(prefs.whatModeIs == true) {
  //     prefs.whatModeIs = false;
  //     BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: Apptheme.LightTheme ));
  //   }else{
  //     prefs.whatModeIs = true;
  //     BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: Apptheme.DarkTheme ));
  //   }
  // }

  ThemeData changedInitialTheme() {
    if(prefs.whatModeIs && prefs.whatDarkIs == false) {

      return appThemeData[Apptheme.DarkTheme];

    }else if(prefs.whatModeIs && prefs.whatDarkIs){
      
      return appThemeData[Apptheme.DarkerTheme];

    }else{
      return appThemeData[Apptheme.LightTheme];
    }
  }
}


