import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({Key key}) : super(key: key);

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
      color: Colors.deepPurpleAccent[400],
      size: 80.0,
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