

import 'package:admob_flutter/admob_flutter.dart';

void getInterstitialAds(String unitId) async {

  AdmobInterstitial interstitialAd = AdmobInterstitial(
    adUnitId: unitId,
  );

  interstitialAd.load();

  if (await interstitialAd.isLoaded) {
    print('Ads is showing !!!!');
    interstitialAd.show();
  }

  interstitialAd.dispose();

}