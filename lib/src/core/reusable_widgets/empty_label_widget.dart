import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class EmptyLabelIconWidget extends StatelessWidget {

  final String label;
  final IconData icon;

  const EmptyLabelIconWidget({this.label, this.icon});

  

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

    final Preferences prefs = Preferences();

    return Icon(
      icon,
      color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      size: 65.0,
    );
  }

  Widget _labelEmpty(BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Text(
        label,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}