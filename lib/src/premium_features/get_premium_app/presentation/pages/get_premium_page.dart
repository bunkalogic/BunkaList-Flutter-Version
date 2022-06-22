import 'dart:ui';

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/countdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:bunkalist/src/core/reusable_widgets/flushbar_go_login_widget.dart';
import 'package:url_launcher/url_launcher.dart';



class GetPremiumPage extends StatefulWidget {

  @override
  _GetPremiumPageState createState() => _GetPremiumPageState();
}

class _GetPremiumPageState extends State<GetPremiumPage> {

  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  final Preferences prefs = Preferences();

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
    return _isPremiumScreen();
  }

   Widget _isPremiumScreen(){
    if(_purchaserInfo == null){
      return _buildListViewPremium();
    }else{

      bool isNotAds = _purchaserInfo.entitlements.active.containsKey("NoAds");

      bool isNotAdsAndPremium = _purchaserInfo.entitlements.active.containsKey("NoAdsAndPremium");

        if( isNotAds || isNotAdsAndPremium){
          return _buildScreenIsNotAds();
        }else {
          return _buildListViewPremium();
        }

    }
  }

  Widget _buildListViewPremium() {
    return Scaffold(
      body: ListView(
        children: [
          _tileClosePage(),
          SizedBox(height: 25.0,),
          _nameBanner(),
          _labelOfBanner(),
          // CountDownFinishOfferWidget(),
          //_rowOfItemPremium(),
          // _labelIncludeSubscription(),
          SizedBox(height: 25.0,),
          _labelOfUnlockFeature(),
          SizedBox(height: 10.0,),
          _itemUnlockFeature(
            Icons.auto_fix_high,
            AppLocalizations.of(context).translate("title_label_edit_home_tops"),
            AppLocalizations.of(context).translate("subtitle_label_edit_home_tops")
          ),

          _itemUnlockFeature(
            Icons.filter_9_plus_rounded,
            AppLocalizations.of(context).translate("title_item_unlock_premium_1"),
            AppLocalizations.of(context).translate("subtitle_item_unlock_premium_1")
          ),

          _itemUnlockFeature(
            Icons.video_collection,
            AppLocalizations.of(context).translate("title_item_unlock_premium_2"),
            AppLocalizations.of(context).translate("subtitle_item_unlock_premium_2")
          ),

          _itemUnlockFeature(
            Icons.filter_list,
            AppLocalizations.of(context).translate("title_item_unlock_premium_3"),
            AppLocalizations.of(context).translate("subtitle_item_unlock_premium_3")
          ),

          _itemUnlockFeature(
            Icons.block,
            AppLocalizations.of(context).translate("title_item_unlock_premium_4"),
            AppLocalizations.of(context).translate("subtitle_item_unlock_premium_4")
          ),

          _itemUnlockFeature(
            Icons.new_releases,
            AppLocalizations.of(context).translate("title_item_unlock_premium_5"),
            AppLocalizations.of(context).translate("subtitle_item_unlock_premium_5")
          ), 
        ],
      ),
      floatingActionButton: _fabGetPremium(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    
  }

  Widget _buildScreenIsNotAds() {


    
    final String label = AppLocalizations.of(context).translate("thanks_for_support");
    
    
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.0,
        leading: SizedBox.shrink(),
        centerTitle: false,
        title: ActionChip(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.pinkAccent[400],
        padding: const EdgeInsets.all(1.0),
        onPressed: (){},
        label: Text(
          'Premium',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
        ),
      ),
      actions: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
           decoration: BoxDecoration(
            color: Colors.blueGrey[400].withOpacity(0.2),
            borderRadius: BorderRadius.circular(40)
          ),
          child: IconButton(
            padding: const EdgeInsets.all(1.0),
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.close_rounded,
              color: Colors.pinkAccent[400],
              size: 25.0,
            ), 
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
        ),
      ),
      ] 
      ),
      body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _tileClosePage(),
            _nameBanner(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text( "🎉 $label 🎉",
              textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.pinkAccent
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            // isActive.expirationDate == null 
            // ? Container()
            // : Text(textDate,
            // textAlign: TextAlign.center, 
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.w500
            //   ),
            // ),
            
          ],
        ),
      ),
    ),
    floatingActionButton: _fabSendFeedback(),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

    
  }


  Widget _tileClosePage() {
    return ListTile(
      leading: ActionChip(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.pinkAccent[400],
        padding: const EdgeInsets.all(2.0),
        onPressed: (){},
        label: Text(
          'Premium',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
           decoration: BoxDecoration(
            color: Colors.blueGrey[400].withOpacity(0.2),
            borderRadius: BorderRadius.circular(40)
          ),
          child: IconButton(
            padding: const EdgeInsets.all(1.0),
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.close_rounded,
              color: Colors.pinkAccent[400],
              size: 25.0,
            ), 
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
        ),
      ),
    );
  }

  Widget _nameBanner() {
    return Center(
      child: Image(
        image: AssetImage('assets/banner-icon.png'),
        height: 55.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _labelOfBanner() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 15.0
        ),
        child: Text(
          AppLocalizations.of(context).translate("title_label_premium"),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            shadows: [
              Shadow(color: Colors.pinkAccent[400], blurRadius: 1.5)
            ]
          ),
        
        ),
      ),
    );
  }

  Widget _labelOffer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0
        ),
        child: Text(
         AppLocalizations.of(context).translate("label_offer"),
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.pinkAccent[400],
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 14.0
          ),
        
        ),
      ),
    );
  }

  Widget _labelIncludeSubscription() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0
        ),
        child: Text(
         AppLocalizations.of(context).translate("label_include_premium"),
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 16.0
          ),
        
        ),
      ),
    );
  }

  Widget _fabGetPremium(){

    final String lifetime = AppLocalizations.of(context).translate("title_lifetime");
    final String price = "1.49€"; 

    return FloatingActionButton.extended(
      onPressed: (){

          if(!prefs.currentUserHasToken){
            getFlushbarGoToLoginFromPremium(context);
            return;
          }

          if(_offerings != null){
          final offering = _offerings.getOffering("NoAds");

            if(offering != null){
            final lifetime = offering.lifetime;
            _purchaseLifetime(lifetime);
          }
          }
        }, 
      label: _titleLabelItem('$lifetime = $price'),
      elevation: 10,
    );
  }


  Widget _fabSendFeedback(){
    return FloatingActionButton.extended(
      onPressed: ()async {

          PackageInfo packageInfo = await PackageInfo.fromPlatform();            

          String _version = packageInfo.version;
          String _buildNumber = packageInfo.buildNumber;

            final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'bunkalist.client@gmail.com',
              queryParameters: {
                'subject': 'FEEDBACK PREMIUM ${prefs.getCurrentUsername} ',
                'body': 'VersionNumber: $_version BuildNumber: $_buildNumber LanguageDevice: ${prefs.getLanguageOfDevice} *DONT DELETE THIS, THANK YOU*'
              }
            );

            launch(_emailLaunchUri.toString());
        },
      label: _titleLabelItem(AppLocalizations.of(context).translate("label_feedback")),
      elevation: 10,
    );
  }

  Widget _rowOfItemPremium() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      child: _itemPremium(
        AppLocalizations.of(context).translate("title_lifetime"),
        "1.49€",
        onTap: (){

          if(!prefs.currentUserHasToken){
            getFlushbarGoToLoginFromPremium(context);
            return;
          }

          if(_offerings != null){
          final offering = _offerings.getOffering("NoAds");

            if(offering != null){
            final lifetime = offering.lifetime;
            _purchaseLifetime(lifetime);
          }
          }
        }, 
        margin: const EdgeInsets.symmetric(
        horizontal: 120.0,
        vertical: 60.0
        ),
      ),
    );
  }

  // _purchaseMonthly(Package monthly) async {
  //   try {
  //     PurchaserInfo purchaserInfo =
  //         await Purchases.purchasePackage(monthly);
  //     var isPro = purchaserInfo.entitlements.all["NoAds"].isActive;
  //     if (isPro) {
  //       return _buildScreenIsNotAds();
  //     }
  //   } on PlatformException catch (e) {
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
  //       print("User cancelled");
  //     } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
  //       print("User not allowed to purchase");
  //     }
  //   }
  // }

  // _purchaseAnnual(Package annual) async {
  //   try {
  //     PurchaserInfo purchaserInfo =
  //         await Purchases.purchasePackage(annual);
  //     var isPro = purchaserInfo.entitlements.all["NoAds"].isActive;
  //     if (isPro) {
  //       return _buildScreenIsNotAds();
  //     }
  //   } on PlatformException catch (e) {
  //     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  //     if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
  //       print("User cancelled");
  //     } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
  //       print("User not allowed to purchase");
  //     }
  //   }
  // }

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

  Widget _itemPremium( String labelTitle, String price, {List<BoxShadow> shadow, EdgeInsetsGeometry margin, String offerPrice, bool isOffer = false, String priceForMonth, bool isYear = false, Function() onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: MediaQuery.of(context).size.width * 0.33,
        decoration: BoxDecoration(
          color: Colors.blueGrey[400].withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: shadow
        ),
        child: Column(
          children: [
            SizedBox(height: 5.0),
            _titleLabelItem(labelTitle),
            isOffer ? SizedBox(height: 15.0,) : SizedBox(height: 30.0,),
            isOffer ? _totalPriceOffer(offerPrice) : Container(),
            _totalPrice(price),
            isYear ? _divider() : Container(),
            isYear ? _totalPriceforMonth(priceForMonth) : Container()
          ],
        ),
      ),
    );
  }

  Widget _titleLabelItem(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _totalPrice(String price) {
    return Text(
      price,
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _totalPriceOffer(String priceOffer) {
    return Text(
      priceOffer,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough, decorationStyle: TextDecorationStyle.solid),
    );
  }

  Widget _totalPriceforMonth(String priceforMonth) {
    return Text(
      priceforMonth,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600,),
    );
  }

  Widget _divider(){
    return Divider(
      color: Colors.pinkAccent[400],
      height: 15.0,
      thickness: 2.0,
      endIndent: 20.0,
      indent: 20.0,
    );
  }

  Widget _labelOfUnlockFeature() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).translate("label_of_unlock"),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0, 
            fontWeight: FontWeight.w700, 
          ),
        ),
        Divider(
      color: Colors.pinkAccent[400],
      height: 15.0,
      thickness: 3.0,
      endIndent: 100.0,
      indent: 100.0,
    )
      ],
    );
  }

  Widget _itemUnlockFeature(IconData icon, String labelTitle, String label){
    return Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.32,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.pinkAccent[400],
                    size: 70,
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    labelTitle,
                    textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent[400],
                        blurRadius: 1.0,
                        offset: Offset(0.1, 0.1),
                      ),
                      Shadow(
                        color: Colors.blueAccent[400],
                        blurRadius: 1.0,
                        offset: Offset(-0.1, 0.1),
                      ),
                      Shadow(
                        color: Colors.redAccent[400],
                        blurRadius: 1.0,
                        offset: Offset(0.1, -0.1),
                      ),
                    ]
                  ),
                  ),
                  SizedBox(height: 5.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
  }

  

  

  
}