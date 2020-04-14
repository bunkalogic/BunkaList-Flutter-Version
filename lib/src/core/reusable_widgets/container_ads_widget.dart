import 'dart:async';

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
          _height = 200;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: _height,
      child: NativeAdmob(
        adUnitID: widget.adUnitID,
        controller: _nativeAdController,
        loading: LoadingCustomWidget(),
        error: Container(),
      ),
    );
  }
}


class BigContainerAdsWidget extends StatefulWidget {
  final String adUnitID;
  final NativeAdmobController controller;

  BigContainerAdsWidget({this.adUnitID, this.controller});

  @override
  _BigContainerAdsWidgetState createState() => _BigContainerAdsWidgetState();
}

class _BigContainerAdsWidgetState extends State<BigContainerAdsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 300.0,
      child: NativeAdmob(
        adUnitID: widget.adUnitID,
        controller: widget.controller,
        loading: LoadingCustomWidget(),
        error: Container(),
      ),
    );
  }
}