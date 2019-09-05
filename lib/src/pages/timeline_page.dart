import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class TimelinePage extends StatefulWidget {
  TimelinePage({Key key}) : super(key: key);

  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: Text('Timeline Page'),
      ),
    );
  }

  
  //!  Common Components (Android & iOS)

  //! Material Components (Android)
  
  //! Cupertino Components (iOS)
}