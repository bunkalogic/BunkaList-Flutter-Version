import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'package:bunkalist/src/localization/app_delegate_localizations.dart';

class AppLocalizations{
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from Widgets
  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();


  Map<String, String> _localizedStrings;

  Future<bool> load() async{
    // Load the language Json file from the "lang" folder
    String jsonString = await
    rootBundle.loadString('lang/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value){
      return MapEntry(key, value.toString());
    });

    return true;

  }

  // This method will be called from every widget which needs a localized text 
  String translate(String key){
    return _localizedStrings[key];
  }

}