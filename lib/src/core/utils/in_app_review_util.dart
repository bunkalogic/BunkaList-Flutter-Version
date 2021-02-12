import 'dart:io';

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:device_info/device_info.dart';



void getInAppReview() async {

  print('------- get request new in app review --------');


  Preferences prefs = Preferences();
  final InAppReview inAppReview = InAppReview.instance;

  if (Platform.isAndroid) {
    
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    int sdkInt = androidInfo.version.sdkInt;

    int hideReview = prefs.totalVisitProfile == 5 ?  0 : prefs.totalVisitProfile;

    if(hideReview == 0){
      prefs.totalVisitProfile = 0;
    }

    if(sdkInt >= 21){
      if (await inAppReview.isAvailable() && hideReview == 0) {
        print('------- is all correct to get request new review --------');
        
        

        List<String> listMovies = prefs.listMoviesIds;
        List<String> listSeries = prefs.listSerieIds;
        List<String> listAnimes = prefs.listAnimeIds;

        if(listMovies.length <= 120 || listSeries.length <= 120 || listAnimes.length <= 120){
          await inAppReview.requestReview();
          return;
        }

        if(listMovies.length <= 60 || listSeries.length <= 60 || listAnimes.length <= 60){
          await inAppReview.requestReview();
          return;
        }

        if(listMovies.length <= 40 || listSeries.length <= 40 || listAnimes.length <= 40){
          await inAppReview.requestReview();
          return;
        }

        if(listMovies.length <= 20 || listSeries.length <= 20 || listAnimes.length <= 20){
          await inAppReview.requestReview();
          return;
        }

        

      }

    }

  }

}