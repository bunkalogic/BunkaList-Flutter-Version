import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class SearchIconWidget extends StatefulWidget {
  const SearchIconWidget({Key key}) : super(key: key);

  @override
  _SearchIconWidgetState createState() => _SearchIconWidgetState();
}

class _SearchIconWidgetState extends State<SearchIconWidget> {
  
  Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _iconSearch(),
          _labelSearch(context)
        ],
      ),
    );
  }

  Widget _iconSearch() {
    return Icon(
      Icons.search,
      color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      size: 85.0,
    );
  }

  Widget _labelSearch(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        AppLocalizations.of(context).translate("search_label"),
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}