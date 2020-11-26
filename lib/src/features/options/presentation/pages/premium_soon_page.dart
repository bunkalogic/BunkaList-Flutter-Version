
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';

/*

Terminar o agregar cuando quede para poder sacar el premium maximo un mes 

*/
class PremiumSoonPage extends StatelessWidget {
  const PremiumSoonPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_premium")),
          leading: AppBarButtonBack(),
        ),
      body: ListView(
      children: <Widget>[
        _headerPremium(),
      ],
    ),
    );
  }

  Widget _headerPremium() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(   
          child: _columnHeaderPremium() ,
          height: 180.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueGrey[500].withOpacity(0.4),
                Colors.blueGrey[600].withOpacity(0.3),
                Colors.blueGrey[700].withOpacity(0.2),
                Colors.blueGrey[800].withOpacity(0.1)
              ]
            ) 
          ),
        ),
    );
  }

  Widget _columnHeaderPremium() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _bannerApp(),
        _labelBanner(),
        Spacer(),
        _dateLabel(),
        SizedBox(height: 10.0,)
      ],
    );
  }

  Widget _bannerApp(){
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0,),
        child: Image(image: AssetImage('assets/bunkalist-banner.png'), height: 80.0, fit: BoxFit.fill,),
      ),
    );
  }

  Widget _labelBanner() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _labelWith(),
        SizedBox(width: 6.0,),
        _labelPremium()
      ],
    );
  }

  Widget _labelWith() {
    return Text(
      'with',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.pinkAccent[400],
        fontWeight: FontWeight.w400
      ),
    );
  }

  Widget _labelPremium() {
    return Text(
      'Premium',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.pinkAccent[400],
        fontWeight: FontWeight.w800
      ),
    );
  }

  Widget _dateLabel() {
    return Text(
      'Comming Soon',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.deepPurpleAccent[400],
        fontWeight: FontWeight.w600
      ),
    );
  }


}