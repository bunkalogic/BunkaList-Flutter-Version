

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';

double getHeightGridItemImage(){

  final Preferences prefs = Preferences();


  switch (prefs.totalColumnList) {

    case 2: return 240.0;
      break;

    case 3: return 140.0;
      break;

    case 3: return 140.0;
      break;  

    default: return 140.0;
  }


}

double getWidthGridItemImage(){

  final Preferences prefs = Preferences();


  switch (prefs.totalColumnList) {

    case 2: return 150.0;
      break;

    case 3: return 100.0;
      break;

    case 3: return 80.0;
      break;  

    default: return 100.0;
  }


}