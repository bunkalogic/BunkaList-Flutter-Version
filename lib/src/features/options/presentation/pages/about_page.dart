
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_about_bunkalist")),
          leading: AppBarButtonBack(),
        ),
      body: ListView(
      children: <Widget>[
        _logoApp(),
        _bannerApp(),
        _labelApi(context),
        SizedBox(height: 20.0),
        _rowLogoApis(),
        _labelAttributeUses(context)
      ],
      ),
    );
  }

  Widget _logoApp(){
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
        child: Image(image: AssetImage('assets/ic_launcher_round.png'), height: 120.0,),
      ),
    );
  }

  Widget _bannerApp(){
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 60.0, right: 60.0),
        child: Image(image: AssetImage('assets/bunkalist-banner.png'), height: 80.0,),
      ),
    );
  }

  Widget _labelApi(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context).translate("api_label"),
        style: TextStyle(
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  _rowLogoApis() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _tmdbLogo(),
        _youtubeLogo()
      ],
    );
  }

  Widget _youtubeLogo(){
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Image(image: AssetImage('assets/icon-youtube.png'), height: 60.0,),
      ),
    );
  }

  Widget _tmdbLogo(){
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/tmdb_logo.svg', 
          height: 60.0,
          semanticsLabel: 'TMDb Logo',
        ),
      ),
    );
  }

  Widget _labelAttributeUses(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Text(
          AppLocalizations.of(context).translate("attribute_label"),
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

}