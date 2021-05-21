import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void getFlushbarGoToLogin(BuildContext context){
  Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    borderRadius: 10,
    backgroundColor: Colors.blueGrey[800],
    animationDuration: Duration(seconds: 2),
    duration: Duration(seconds: 12),
    icon: Icon(
      Icons.info_outline_rounded,
      color: Colors.pinkAccent[400],
      size: 28,
    ),
    titleText: Text(
      AppLocalizations.of(context).translate('login'),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w700
      ),
    ),
    // ignore: deprecated_member_use
    mainButton: FlatButton(
      onPressed: (){
        return Navigator.pushNamed(context, '/Login');
      }, 
      child: Text(
          AppLocalizations.of(context).translate('login'),
          style: TextStyle(
            color: Colors.pinkAccent[400],
            fontSize: 14.0,
            fontWeight: FontWeight.w800
          ),
        ),
    ),
    messageText: Text(
          AppLocalizations.of(context).translate('label_add_to_list_login_first'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w500
          ),
        ),
    
  )..show(context);
}

void getFlushbarGoToLoginFromPremium(BuildContext context){
  Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    borderRadius: 10,
    backgroundColor: Colors.blueGrey[800],
    animationDuration: Duration(seconds: 2),
    duration: Duration(seconds: 12),
    icon: Icon(
      Icons.info_outline_rounded,
      color: Colors.pinkAccent[400],
      size: 28,
    ),
    titleText: Text(
      AppLocalizations.of(context).translate('login'),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w700
      ),
    ),
    // ignore: deprecated_member_use
    mainButton: FlatButton(
      onPressed: (){
        return Navigator.pushNamed(context, '/Login');
      }, 
      child: Text(
          AppLocalizations.of(context).translate('login'),
          style: TextStyle(
            color: Colors.pinkAccent[400],
            fontSize: 14.0,
            fontWeight: FontWeight.w800
          ),
        ),
    ),
    messageText: Text(
          AppLocalizations.of(context).translate('label_use_feature_login_first'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w500
          ),
        ),
    
  )..show(context);
}