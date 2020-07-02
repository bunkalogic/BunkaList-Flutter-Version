import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class EmptyIconWidget extends StatelessWidget {
  const EmptyIconWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _iconEmpty(),
          _labelEmpty(context)
        ],
      ),
    );
  }

  Widget _iconEmpty() {
    return Icon(
      Icons.error_outline,
      color: Colors.deepPurpleAccent[400],
      size: 80.0,
    );
  }

  Widget _labelEmpty(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        AppLocalizations.of(context).translate("empty_search_label"),
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}