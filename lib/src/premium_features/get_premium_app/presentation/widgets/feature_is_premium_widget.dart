import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class FeaturePremiumWidget extends StatefulWidget {
  FeaturePremiumWidget({Key key}) : super(key: key);

  @override
  _FeaturePremiumWidgetState createState() => _FeaturePremiumWidgetState();
}

class _FeaturePremiumWidgetState extends State<FeaturePremiumWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.33,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  color: Colors.blueGrey[400].withOpacity(0.3),
                  spreadRadius: 1.5
                )
              ],
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                colors: [
                  Colors.indigoAccent[400].withOpacity(0.2),
                  Colors.deepPurpleAccent[400].withOpacity(0.2), 
                  Colors.pinkAccent[400].withOpacity(0.2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.1, 0.3, 0.7],
                
              ) 
            ),
            child: _columnGoPremium(),
        ),
      ),
    );  
  }

  Widget _columnGoPremium() {
    return Column(
      children: [
        _itemUnlockFeature(),
        _btnGoToPremium()
      ],
    );
  }

  Widget _itemUnlockFeature(){
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_activity_rounded,
            color: Colors.pinkAccent[400],
            size: 60,
          ),
          SizedBox(height: 5.0,),
          Text(
            AppLocalizations.of(context).translate("big_banner_premium_title"),
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
              vertical: 5.0,
            ),
            child: Text(
              AppLocalizations.of(context).translate("big_banner_premium_subtitle"),
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

  Widget _btnGoToPremium() {
    return ActionChip(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.pinkAccent[400],
        padding: const EdgeInsets.all(2.0),
        onPressed: (){
          Navigator.pushNamed(context, '/Premium');
        },
        label: Text(
          AppLocalizations.of(context).translate("btn_go_to_premium"),
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
        ),
      );
  }
}