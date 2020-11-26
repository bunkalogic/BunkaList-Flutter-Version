
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class NoAdsPage extends StatefulWidget {

  @override
  _NoAdsPageState createState() => _NoAdsPageState();
}

class _NoAdsPageState extends State<NoAdsPage> {

  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async{
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();

     if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("label_ads")),
        leading: AppBarButtonBack(),
      ),
      body: _isPremiumScreen(),

    );  
  }

  Widget _isPremiumScreen(){
    if(_purchaserInfo == null){
      return _buildUpSellScreen();
    }else{

      bool isNotAds = _purchaserInfo.entitlements.active.containsKey("NoAds");

      bool isNotAdsAndPremium = _purchaserInfo.entitlements.active.containsKey("NoAdsAndPremium");

        if( isNotAds || isNotAdsAndPremium){
          return _buildScreenIsNotAds();
        }else {
          return _buildUpSellScreen();
        }

    }
  }

  Widget _buildUpSellScreen() {
    return ListView(
      children: <Widget>[
        _labelRemoveAds(),
        _containerOneMouthNoAds(),
        _containerOneYearNoAds(),
        _containerLifetimeNoAds(),
        _labelCancelSubscription(),
        _labelCommingPremium(),
      ],
    );
  
  }

  Widget _buildScreenIsNotAds() {

    final isActive = _purchaserInfo.entitlements.active.values.first;

    final String date = formatterDate(isActive.expirationDate);
    final String label = AppLocalizations.of(context).translate("enebled_subcription");
    final textDate = '$label $date';
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.card_giftcard, color: Colors.redAccent[400], size: 60,),
            Text(AppLocalizations.of(context).translate("thanks_for_support"),
            textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 10.0,),
            isActive.expirationDate == null 
            ? Container()
            : Text(textDate,
            textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _labelRemoveAds() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          AppLocalizations.of(context).translate("label_remove_ads"),
          textAlign:TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 22.0
          ),
        ),
      ),
    );
  }

  Widget _containerOneMouthNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 70.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey[400],
        ),
        child: ListTile(
          leading: Icon(Icons.exposure_plus_1, color: Colors.yellowAccent, size: 25.0,),
          title: Text(
             AppLocalizations.of(context).translate("label_month_ads"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
          ),
          //subtitle: Text('Cancel subscription any time in Google Play.'),
          onTap: () async {
            
            if(_offerings != null){
              final offering = _offerings.getOffering("no_ads_1_month");

              if(offering != null){
                final monthly = offering.monthly;
                _purchaseMonthly(monthly);
              }
            }
      
          },
        ),
      ), 
    );
  }

   _purchaseMonthly(Package monthly) async {
    try {
      PurchaserInfo purchaserInfo =
          await Purchases.purchasePackage(monthly);
      var isPro = purchaserInfo.entitlements.all["NoAds"].isActive;
      if (isPro) {
        return _buildScreenIsNotAds();
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }
    }
  }

  Widget _containerOneYearNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 50.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey[600],
        ),
        child: ListTile(
          leading: Icon(Icons.local_offer, color: Colors.pinkAccent[400], size: 30.0,),
          title: Text(
            AppLocalizations.of(context).translate("label_year_ads"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
          ),
          onTap: () async {
            if(_offerings != null){
              final offering = _offerings.getOffering("no_ads_yearly");

              if(offering != null){
                final annual = offering.annual;
                _purchaseAnnual(annual);
              }
            }
          },
        ),
      ), 
    );
  }

  _purchaseAnnual(Package annual) async {
    try {
      PurchaserInfo purchaserInfo =
          await Purchases.purchasePackage(annual);
      var isPro = purchaserInfo.entitlements.all["NoAds"].isActive;
      if (isPro) {
        return _buildScreenIsNotAds();
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }
    }
  }

  Widget _containerLifetimeNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 30.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: ListTile(
          leading: Icon(Icons.local_play, color: Colors.redAccent[400], size: 35.0,),
          title: Text(
            AppLocalizations.of(context).translate("label_never_ads"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
          ),
          subtitle: Text(
            AppLocalizations.of(context).translate("label_never_ads_with_premium"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              shadows: [
               Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
            ),
          onTap: () async{
            if(_offerings != null){
              final offering = _offerings.getOffering("NoAds");

              if(offering != null){
                final lifetime = offering.lifetime;
                _purchaseLifetime(lifetime);
              }
            }
          },
        ),
      ), 
    );
  }

  _purchaseLifetime(Package lifetime) async {
    try {
      PurchaserInfo purchaserInfo =
          await Purchases.purchasePackage(lifetime);
      var isPro = purchaserInfo.entitlements.all["NoAdsAndPremium"].isActive;
      if (isPro) {
        return _buildScreenIsNotAds();
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }
    }
  }

  Widget _labelCancelSubscription() {
    return Text(
      AppLocalizations.of(context).translate("label_subscription"),
      textAlign:TextAlign.center,
    );
  }

   Widget _labelCommingPremium() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
         AppLocalizations.of(context).translate("label_include_premium"),
        textAlign:TextAlign.center,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}




