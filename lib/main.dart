import 'package:bunkalist/src/localization/app_localizations.dart';
import 'package:bunkalist/src/pages/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
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
      
    );
  }
}