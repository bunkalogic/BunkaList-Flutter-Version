import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';


class NoAdsPage extends StatefulWidget {

  @override
  _NoAdsPageState createState() => _NoAdsPageState();
}

class _NoAdsPageState extends State<NoAdsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_ads")),
          leading: AppBarButtonBack(),
        ),
      body: ListView(
      children: <Widget>[
        _labelRemoveAds(),
        _containerOneMouthNoAds(),
        _containerOneYearNoAds(),
        _containerLifetimeNoAds(),
        _labelCancelSubscription(),
        _labelCommingPremium(),
      ],
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
        horizontal: 60.0, 
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
          onTap: (){},
        ),
      ), 
    );
  }

  Widget _containerOneYearNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 40.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.tealAccent[400],
        ),
        child: ListTile(
          leading: Icon(Icons.local_offer, color: Colors.deepOrangeAccent[400], size: 30.0,),
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
          onTap: (){},
        ),
      ), 
    );
  }

  Widget _containerLifetimeNoAds() {
    return Padding(
      padding: EdgeInsets.symmetric( 
        horizontal: 20.0, 
        vertical: 15.0
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent[400],
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
          onTap: (){},
        ),
      ), 
    );
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