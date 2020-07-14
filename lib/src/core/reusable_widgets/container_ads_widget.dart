import 'dart:async';

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class MiniNativeBannerAds extends StatefulWidget {
  final String adPlacementID;
  MiniNativeBannerAds({this.adPlacementID});

  @override
  _MiniNativeBannerAdsState createState() => _MiniNativeBannerAdsState();
}

class _MiniNativeBannerAdsState extends State<MiniNativeBannerAds> {

  Preferences prefs = Preferences();
  PurchaserInfo _purchaserInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async{
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

     if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool noAds = isNotAds();
    bool noPremium = isNotPremium();

    return (noAds || noPremium) ? buildContainerAds() : Container();
  }

  bool isNotAds() {
     try {
      
      if (_purchaserInfo.entitlements.all["NoAds"].isActive) {
      // Grant user "pro" access
        return true;
      }else{
        return false;
      }

    } on PlatformException catch (e) {
      // Error fetching purchaser info
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }

      return false;
    }
  }

  bool isNotPremium() {
     try {
      
      if (_purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive) {
      // Grant user "pro" access
        return true;
      }else{
        return false;
      }

    } on PlatformException catch (e) {
      // Error fetching purchaser info
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }

      return false;
    }
  }

  Widget buildContainerAds() {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
    child: FacebookNativeAd(
      keepExpandedWhileLoading: false,
      placementId: "177059330328908_177063066995201",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_50,
      height: 50.0,
      width: double.infinity,
      backgroundColor: (prefs.whatModeIs) ? Colors.blueGrey[900] : Colors.white,
      titleColor: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[700] ,
      descriptionColor: (prefs.whatModeIs) ? Colors.grey[300] : Colors.grey[500] ,
      buttonColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[200],
      buttonTitleColor: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[700],
      buttonBorderColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[300],
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    ),
  );
  }
}


class MaxNativeBannerAds extends StatefulWidget {
  final String adPlacementID;
  MaxNativeBannerAds({this.adPlacementID});
  

  @override
  _MaxNativeBannerAdsState createState() => _MaxNativeBannerAdsState();
}

class _MaxNativeBannerAdsState extends State<MaxNativeBannerAds> {

  Preferences prefs = Preferences();
  PurchaserInfo _purchaserInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async{
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

     if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool noAds = isNotAds();
    bool noPremium = isNotPremium();

   return (noAds || noPremium) ? buildContainerAds() : Container();
  }

   bool isNotAds() {
     try {
      
      if (_purchaserInfo.entitlements.all["NoAds"].isActive) {
      // Grant user "pro" access
        return true;
      }else{
        return false;
      }

    } on PlatformException catch (e) {
      // Error fetching purchaser info
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }

      return false;
    }
  }

  bool isNotPremium() {
     try {
      
      if (_purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive) {
      // Grant user "pro" access
        return true;
      }else{
        return false;
      }

    } on PlatformException catch (e) {
      // Error fetching purchaser info
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }

      return false;
    }
  }

  Widget buildContainerAds() {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
    child: FacebookNativeAd(
      keepExpandedWhileLoading: false,
      placementId: widget.adPlacementID,
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_120,
      height: 120.0,
      width: double.infinity,
      backgroundColor: (prefs.whatModeIs) ? Colors.blueGrey[900] : Colors.white,
      titleColor: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[700] ,
      descriptionColor: (prefs.whatModeIs) ? Colors.grey[300] : Colors.grey[500] ,
      buttonColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[200],
      buttonTitleColor: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[700],
      buttonBorderColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[300],
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    ),
  );
  }
}

class MaxNativeAds extends StatefulWidget {
  final String adPlacementID;
  MaxNativeAds({this.adPlacementID});

  @override
  _MaxNativeAdsState createState() => _MaxNativeAdsState();
}

class _MaxNativeAdsState extends State<MaxNativeAds> {

  Preferences prefs = Preferences();
  PurchaserInfo _purchaserInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async{
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

     if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool noAds = isNotAds();
    bool noPremium = isNotPremium();

    return (noAds || noPremium) ? buildContainerAds() : Container();
  }

  
   bool isNotAds() {
     try {
      
      if (_purchaserInfo.entitlements.all["NoAds"].isActive) {
      // Grant user "pro" access
        return true;
      }else{
        return false;
      }

    } on PlatformException catch (e) {
      // Error fetching purchaser info
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }

      return false;
    }
  }

  bool isNotPremium() {
     try {
      
      if (_purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive) {
      // Grant user "pro" access
        return true;
      }else{
        return false;
      }

    } on PlatformException catch (e) {
      // Error fetching purchaser info
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }

      return false;
    }
  }

  Container buildContainerAds() {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
    child: FacebookNativeAd(
      keepExpandedWhileLoading: false,
      placementId: widget.adPlacementID,
      adType: NativeAdType.NATIVE_AD,
      height: 300.0,
      width: double.infinity,
      backgroundColor: (prefs.whatModeIs) ? Colors.blueGrey[900] : Colors.white,
      titleColor: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[700] ,
      descriptionColor: (prefs.whatModeIs) ? Colors.grey[300] : Colors.grey[500] ,
      buttonColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[200],
      buttonTitleColor: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[700],
      buttonBorderColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[300],
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    ),
  );
  }
}





class MiniContainerAdsWidget extends StatefulWidget {
  final String adUnitID;
  //final NativeAdmobController controller;

  MiniContainerAdsWidget({this.adUnitID, });

  @override
  _MiniContainerAdsWidgetState createState() => _MiniContainerAdsWidgetState();
}

class _MiniContainerAdsWidgetState extends State<MiniContainerAdsWidget> {

  final _nativeAdController = NativeAdmobController();
  Preferences prefs = Preferences();

  PurchaserInfo _purchaserInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

     if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      prefs.isNotAds = isNotAds();
    });
  }


  @override
  Widget build(BuildContext context) {
    //bool noAds = isNotAds();
    //bool noPremium = isNotPremium();
    

    return (prefs.isNotAds) ? Container() : buildContainerAds();
  }

  Widget buildContainerAds() {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    height: 95.0,
    color: Colors.transparent,
    child: NativeAdmob(
      adUnitID: widget.adUnitID,
      controller: _nativeAdController,
      loading: LoadingCustomWidget(),
      error: EmptyIconWidget(),
      type: NativeAdmobType.banner,
      options: NativeAdmobOptions(
        showMediaContent: false,
        adLabelTextStyle: NativeTextStyle(
          fontSize: 12.0,
          color: (prefs.whatModeIs) ? Colors.grey[200] : Colors.grey[700]
        ),
        headlineTextStyle: NativeTextStyle(
          fontSize: 14.0,
          color: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[800]
        ),
        bodyTextStyle: NativeTextStyle(
          fontSize: 12.0,
          color: (prefs.whatModeIs) ? Colors.grey[200] : Colors.grey[700]
        ),
        storeTextStyle: NativeTextStyle(
          fontSize: 12.0,
          color: (prefs.whatModeIs) ? Colors.grey[200] : Colors.grey[700]
        ),
        callToActionStyle: NativeTextStyle(
          fontSize: 16.0,
          color: Colors.white,
          backgroundColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[200],
        ),
      ) ,
    ),
  );
  }

  

   bool isNotAds() {

     bool isNull = (_purchaserInfo.entitlements == null) ? true : false;
     final bool isNotEmpty = (isNull) ? false : _purchaserInfo.entitlements.active.isNotEmpty;

     if (isNotEmpty) {
      //user has access to some entitlement
      return true;

    }else{

      return false;

    }
   
    //  try {

    //    if(_purchaserInfo.entitlements == null && _purchaserInfo.entitlements.  all["NoAds"] == null){
    //     return false;
    //   }
      
    //   if (_purchaserInfo.entitlements.all["NoAds"].isActive) {
    //   // Grant user "pro" access
    //     return true;
    //   }else{
    //     return false;
    //   }

    // } on PlatformException catch (e) {
    //   // Error fetching purchaser info
    //   var errorCode = PurchasesErrorHelper.getErrorCode(e);
    //   if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
    //     print("User cancelled");
    //   } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
    //     print("User not allowed to purchase");
    //   }

    //   return false;
    // }
  }

  // bool isNotPremium() {
    
  //    try {

  //      if(_purchaserInfo.entitlements == null && _purchaserInfo.entitlements.all["NoAds"] == null){
  //     return false;
  //     }
      
  //     if (_purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive) {
  //     // Grant user "pro" access
  //       return true;
  //     }else{
  //       return false;
  //     }

  //   } on PlatformException catch (e) {
  //     // Error fetching purchaser info
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
  //       print("User cancelled");
  //     } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
  //       print("User not allowed to purchase");
  //     }

  //     return false;
  //   }
  // }
}


class BigContainerAdsWidget extends StatefulWidget {
  final String adUnitID;
  

  BigContainerAdsWidget({this.adUnitID});

  @override
  _BigContainerAdsWidgetState createState() => _BigContainerAdsWidgetState();
}

class _BigContainerAdsWidgetState extends State<BigContainerAdsWidget> {

  final _nativeAdController = NativeAdmobController();
  
  Preferences prefs = Preferences();
  double _height = 0;

  StreamSubscription _subscription;

  PurchaserInfo _purchaserInfo;


  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

   Future<void> initPlatformState() async {
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

     if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      prefs.isNotAds = isNotAds();
    });
  }

   void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 220;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return (prefs.isNotAds) ? Container() : buildContainerAds();

  }

  Widget buildContainerAds() {
    return Container(
    padding: EdgeInsets.all(8.0),
    height: _height,
    color: Colors.transparent,
    child: NativeAdmob(
      adUnitID: widget.adUnitID,
      controller:  _nativeAdController,
      loading: LoadingCustomWidget(),
      error: Container(),
      type: NativeAdmobType.full,
      options: NativeAdmobOptions(
        showMediaContent: false,
        adLabelTextStyle: NativeTextStyle(
          fontSize: 12.0,
          color: (prefs.whatModeIs) ? Colors.grey[200] : Colors.grey[700]
        ),
        headlineTextStyle: NativeTextStyle(
          fontSize: 16.0,
          color: (prefs.whatModeIs) ? Colors.grey[100] : Colors.grey[800]
        ),
        bodyTextStyle: NativeTextStyle(
          fontSize: 12.0,
          color: (prefs.whatModeIs) ? Colors.grey[200] : Colors.grey[700]
        ),
        storeTextStyle: NativeTextStyle(
          fontSize: 12.0,
          color: (prefs.whatModeIs) ? Colors.grey[200] : Colors.grey[700]
        ),
        callToActionStyle: NativeTextStyle(
          fontSize: 16.0,
          color: Colors.white,
          backgroundColor: (prefs.whatModeIs) ? Colors.blueGrey[800] : Colors.grey[200],
        ),
      ) ,
    ),
  );
  }


  
   bool isNotAds() {

     bool isNull = (_purchaserInfo.entitlements == null) ? true : false;
     final bool isNotEmpty = (isNull) ? false : _purchaserInfo.entitlements.active.isNotEmpty;

     if (isNotEmpty) {
      //user has access to some entitlement
      return true;

    }else{

      return false;

    }
   
    //  try {

    //    if(_purchaserInfo.entitlements == null && _purchaserInfo.entitlements.  all["NoAds"] == null){
    //     return false;
    //   }
      
    //   if (_purchaserInfo.entitlements.all["NoAds"].isActive) {
    //   // Grant user "pro" access
    //     return true;
    //   }else{
    //     return false;
    //   }

    // } on PlatformException catch (e) {
    //   // Error fetching purchaser info
    //   var errorCode = PurchasesErrorHelper.getErrorCode(e);
    //   if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
    //     print("User cancelled");
    //   } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
    //     print("User not allowed to purchase");
    //   }

    //   return false;
    // }
  }

  // bool isNotPremium() {
  //   if(_purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive == null){
  //     return false;
  //   }
  //    try {
      
  //     if (_purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive) {
  //     // Grant user "pro" access
  //       return true;
  //     }else{
  //       return false;
  //     }

  //   } on PlatformException catch (e) {
  //     // Error fetching purchaser info
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
  //       print("User cancelled");
  //     } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
  //       print("User not allowed to purchase");
  //     }

  //     return false;
  //   }
  // }


  
}