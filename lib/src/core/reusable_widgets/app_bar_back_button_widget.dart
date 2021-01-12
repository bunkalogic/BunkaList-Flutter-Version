import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppBarButtonBack extends StatelessWidget {
  const AppBarButtonBack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Preferences prefs = Preferences();

    return IconButton(
      icon: Icon(
        Icons.keyboard_arrow_down_rounded, 
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
        size: 38.0,
      ),
      onPressed: () => Navigator.pop(context),
    );

  }
}