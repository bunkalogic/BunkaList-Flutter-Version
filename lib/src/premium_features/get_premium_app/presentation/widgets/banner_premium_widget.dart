import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class BannerPremiumWidget extends StatefulWidget {


  @override
  _BannerPremiumWidgetState createState() => _BannerPremiumWidgetState();
}

class _BannerPremiumWidgetState extends State<BannerPremiumWidget> {
  Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    
    return (prefs.isNotAds)
    ? Container() 
    : Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 95.0,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 6.0,
                color: Colors.blueGrey.withOpacity(0.3),
                spreadRadius: 2.0
              )
            ],
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: [
                Colors.indigoAccent,
                Colors.deepPurpleAccent, 
                Colors.pinkAccent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 0.3, 0.7],
              
            ) 
          ),
          child: _buttomGoToPremium(),
      ),
    );
  }

  Widget _buttomGoToPremium() {
    return Center(
      child: ListTile(
        title: _titleGoToPremium(),
        leading: Icon(Icons.local_play, size: 40.0, color: Colors.pinkAccent[400],),
        onTap: () {
          Navigator.pushNamed(context, '/NoAds');
        },
      ),
    );
  }

  Widget _titleGoToPremium() {
    return Text(
      AppLocalizations.of(context).translate("label_remove_ads"), 
    style: TextStyle(
      color: Colors.white, 
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      shadows:  [
        Shadow(
          color: Colors.greenAccent[400],
          blurRadius: 1.0,
          offset: Offset(0.3, 0.3),
        ),
        Shadow(
          color: Colors.blueAccent[400],
          blurRadius: 1.0,
          offset: Offset(-0.3, 0.3),
        ),
        Shadow(
          color: Colors.redAccent[400],
          blurRadius: 1.0,
          offset: Offset(0.3, -0.3),
        ),
      ]
    ),
    //textAlign: TextAlign.center,
    );
  }
}