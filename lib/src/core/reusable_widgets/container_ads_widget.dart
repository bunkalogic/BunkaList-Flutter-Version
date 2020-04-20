import 'dart:async';

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';


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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      height: 95.0,
      color: Colors.blueGrey[400].withOpacity(0.1),
      child: NativeAdmob(
        adUnitID: widget.adUnitID,
        controller: _nativeAdController,
        loading: LoadingCustomWidget(),
        error: EmptyIconWidget(),
        type: NativeAdmobType.banner,
        options: NativeAdmobOptions(
          showMediaContent: false,
          headlineTextStyle: NativeTextStyle(
            fontSize: 16.0,
            color: (prefs.whatModeIs) ? Colors.white : Colors.black 
          ),
          bodyTextStyle: NativeTextStyle(
            fontSize: 12.0,
            color: (prefs.whatModeIs) ? Colors.white : Colors.black 
          )
        ) ,
      ),
    );
  }
}


class BigContainerAdsWidget extends StatefulWidget {
  final String adUnitID;
  

  BigContainerAdsWidget({this.adUnitID});

  @override
  _BigContainerAdsWidgetState createState() => _BigContainerAdsWidgetState();
}

class _BigContainerAdsWidgetState extends State<BigContainerAdsWidget> {

  final _nativeAdController = NativeAdmobController();
  

  double _height = 0;

  StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
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
          _height = 330;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: _height,
      child: NativeAdmob(
        adUnitID: widget.adUnitID,
        controller:  _nativeAdController,
        loading: LoadingCustomWidget(),
        error: Container(),
        type: NativeAdmobType.full,
      ),
    );
  }


  
}