
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/routes/route_generator.dart';
import 'package:bunkalist/src/core/theme/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bunkalist/injection_container.dart' as ic ;


void main() async{


  await ic.init();
  final prefs = new Preferences();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _materialApp, // TODO: AGREGAR EL PlatformApp
      ),
    );
  }
}

Widget _materialApp(BuildContext context, ThemeState state){
   
   Preferences prefs = Preferences();
    Locale myLocale;


  return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.themeData, 
        title: 'Bunkalist',
        initialRoute: '/',
        onGenerateRoute: RouteGeneretor.generateRoute,
        localeListResolutionCallback: ( devicesLocale , supportedLocales ){
          myLocale = devicesLocale.first;
          print(myLocale.countryCode);
          print(myLocale.languageCode);
          prefs.getLanguage = '${myLocale.languageCode}-${myLocale.countryCode}';
          print('language code: ${prefs.getLanguage}');
          return null; 
        },
        //* THESE DELEGATES MAKE SURE THAT THE LOCALIZATION DATA FOR THE PROPER LANGUAGE IS LOADED
        supportedLocales: [
          //* LIST ALL OF THE APPs SUPPORT LOCALES HERE
          Locale('en', 'US'),
        ] ,
        localizationsDelegates: [
          //* A CLASS WHICH LOADS THE TRANSLATIONS FROM JSON FILE
          AppLocalizations.delegate,
          //* BUILT-IN LOCALIZATION OF BASIC TEXT FOR WIDGETS Material
          GlobalMaterialLocalizations.delegate,
          //* BUILT-IN LOCALIZATION OF BASIC TEXT FOR WIDGETS Cupertino
          GlobalCupertinoLocalizations.delegate,
          //* BUILT-IN LOCALIZATION OF BASIC TEXT DIRECTION left to right or viceversa
          //? GlobalWidgetsLocalizations.delegate
        ],
        //* RETURNS A LOCALE WHICH BE USED BY THE APP
        localeResolutionCallback: (locale, supportedLocales){
          //* check if the current device locale is supported 
          for (var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale.languageCode 
            && supportedLocale.countryCode == locale.countryCode){
              return supportedLocale;
            }
          }
          //* If the locale of the device is not supported use the first one (English, this case).
          return supportedLocales.first; 
        },
        
      );
  
}



/* void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppProvider(

          child: PlatformApp(
        debugShowCheckedModeBanner: false,
        title: 'Bunkalist',
        initialRoute: 'home',
        routes: {
          'home' : (BuildContext context) => HomePage()
        },
        // THESE DELEGATES MAKE SURE THAT THE LOCALIZATION DATA FOR THE PROPER LANGUAGE IS LOADED
        supportedLocales: [
          // LIST ALL OF THE APPs SUPPORT LOCALES HERE
          Locale('en', 'US'),
        ] ,
        localizationsDelegates: [
          // A CLASS WHICH LOADS THE TRANSLATIONS FROM JSON FILE
          AppLocalizations.delegate,
          // BUILT-IN LOCALIZATION OF BASIC TEXT FOR WIDGETS Material
          GlobalMaterialLocalizations.delegate,
          // BUILT-IN LOCALIZATION OF BASIC TEXT FOR WIDGETS Cupertino
          GlobalCupertinoLocalizations.delegate,
          // BUILT-IN LOCALIZATION OF BASIC TEXT DIRECTION left to right or viceversa
          //GlobalWidgetsLocalizations.delegate
        ],
        // RETURNS A LOCALE WHICH BE USED BY THE APP
        localeResolutionCallback: (locale, supportedLocales){
          // check if the current device locale is supported 
          for (var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale.languageCode 
            && supportedLocale.countryCode == locale.countryCode){
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported use the first one (English, this case).
          return supportedLocales.first; 
        },
        
      ),
    );
  }
} */