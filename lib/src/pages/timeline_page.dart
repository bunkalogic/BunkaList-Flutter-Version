import 'package:bunkalist/src/widgets/card_timelime_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class TimelinePage extends StatefulWidget {
  

  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _createTimelineDesign(context)
    );
  }

  
  //!  Common Components (Android & iOS)

  Widget _createTimelineDesign(BuildContext context) {
    return PlatformWidget(
      android: (context) => _createTimelineMaterial(context),
      ios: (context) => _createTimelineCupertino(),
    );
  }

  

  //! Material Components (Android)
  
  Widget _createTimelineMaterial(BuildContext context) {
      return ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) => CardTimelineWidget(),
      );
  }
  
  //! Cupertino Components (iOS)

  Widget _createTimelineCupertino(){

  }

}