
import 'dart:io';

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/provider/push_notifications_provider.dart';
import 'package:bunkalist/src/core/routes/route_generator.dart';
import 'package:bunkalist/src/core/theme/bloc/bloc.dart';
import 'package:bunkalist/src/core/utils/http_overrrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bunkalist/injection_container.dart' as ic ;
import 'package:purchases_flutter/purchases_flutter.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  
  HttpOverrides.global = new MyHttpOverrides();
  // Inicializando el injection container
  await ic.init();
  // Inicializando las Preferences
  final prefs = new Preferences();
  await prefs.initPrefs();
  // Inicializando Purchases
  Purchases.setDebugLogsEnabled(true);
  await Purchases.setup("SNQQEwiQBuwpLzXsWBgSEktUJusayMzd");
  // Inicializando el Facebook Ads
  // FacebookAudienceNetwork.init(
  //   testingId: "7fb5fc6f-cfb7-4761-ba77-5879cbaba7ae"
  // );
  runApp(MyApp());
} 
 
class MyApp extends StatefulWidget {

  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationsProvider();

    pushProvider.initNotifications();

  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _materialApp, 
      ),
    );
  }
}

Widget _materialApp(BuildContext context, ThemeState state){
   
   Preferences prefs = Preferences();
    //Locale myLocale;


  return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.themeData, 
        title: 'Bunkalist',
        initialRoute: '/',
        onGenerateRoute: RouteGeneretor.generateRoute,
        // localeListResolutionCallback: ( devicesLocale , supportedLocales ){
        //  myLocale = devicesLocale.first;

        //  print(myLocale.countryCode);
        //  print(myLocale.languageCode);

        //  prefs.getLanguage = '${myLocale.languageCode}-${myLocale.countryCode}';
        //  prefs.getCountryCode = '${myLocale.countryCode}';

        //  print('language code: ${prefs.getLanguage}');
         
        //  return null; 
        // },
        //* THESE DELEGATES MAKE SURE THAT THE LOCALIZATION DATA FOR THE PROPER LANGUAGE IS LOADED
        supportedLocales: [
          //* LIST ALL OF THE APPs SUPPORT LOCALES HERE
          Locale('en', 'US'),
          Locale('es', 'ES'),
          Locale('it', 'IT'),
          Locale('de', 'DE'),
          Locale('fr', 'FR'),
          Locale('hi', 'IN'),
          Locale('ja', 'JP'),
          Locale('ko', 'KR'),
          Locale('pt', 'PT'),
          //Locale('ru', 'RU'),
        ] ,
        localizationsDelegates: [
          //* A CLASS WHICH LOADS THE TRANSLATIONS FROM JSON FILE
          AppLocalizations.delegate,
          //* BUILT-IN LOCALIZATION OF BASIC TEXT FOR WIDGETS Material
          GlobalMaterialLocalizations.delegate,
          //* BUILT-IN LOCALIZATION OF BASIC TEXT FOR WIDGETS Cupertino
          GlobalCupertinoLocalizations.delegate,
          //* BUILT-IN LOCALIZATION OF BASIC TEXT DIRECTION left to right or viceversa
          GlobalWidgetsLocalizations.delegate
        ],
        //* RETURNS A LOCALE WHICH BE USED BY THE APP
        localeResolutionCallback: (locale, supportedLocales){

          //* check if the current device locale is supported 
          for (var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale.languageCode 
            && supportedLocale.countryCode == locale.countryCode){

              print(supportedLocale.countryCode);
              print(supportedLocale.languageCode);

              prefs.getLanguage = '${supportedLocale.languageCode}-${supportedLocale.countryCode}';
              prefs.getCountryCode = '${supportedLocale.countryCode}';

              print('language code: ${prefs.getLanguage}');

              return supportedLocale;
            }
          }
          //* If the locale of the device is not supported use the first one (English, this case).

          prefs.getLanguage = '${supportedLocales.first.languageCode}-${supportedLocales.first.countryCode}';
          prefs.getCountryCode = '${supportedLocales.first.countryCode}';

          print('language code: ${prefs.getLanguage}');

          return supportedLocales.first; 
        },
        
      );
  
}



