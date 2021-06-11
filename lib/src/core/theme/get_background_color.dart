import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Color getBackgroundColorTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false && prefs.whatDarkBlue == false){
      return Colors.blueGrey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs && prefs.whatDarkBlue == false){
      return Colors.black;
    }else if(prefs.whatModeIs && prefs.whatDarkIs && prefs.whatDarkBlue){
      return Color(0xFF15202B);
    }else if(prefs.whatModeIs == false && prefs.whatSepia){
      return Color(0xFFFFEDDE);
    }
    else{
      return Colors.grey[50];
    }
}


Color getBackgroundColorItemTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false && prefs.whatDarkBlue == false){
      return Colors.blueGrey[800];
    }else if(prefs.whatModeIs && prefs.whatDarkIs && prefs.whatDarkBlue == false){
      return Colors.grey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs && prefs.whatDarkBlue){
      return Color(0xFF15202B);
    }else if(prefs.whatModeIs == false && prefs.whatSepia){
      return Color(0xFFFFDFC5);
    }
    else{
      return Colors.grey[200];
    }
  }

