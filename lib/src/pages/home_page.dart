import 'package:bunkalist/src/localization/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
          child: Text(
            AppLocalizations.of(context).translate('btn_nav_timeline'),
            style: TextStyle(fontSize: 25.0),
            ),
      ),
    );
  }
}