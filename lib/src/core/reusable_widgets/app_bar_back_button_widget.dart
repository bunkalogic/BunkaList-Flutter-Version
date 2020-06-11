import 'package:flutter/material.dart';

class AppBarButtonBack extends StatelessWidget {
  const AppBarButtonBack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.deepPurpleAccent[400], size: 35.0,),
      onPressed: () => Navigator.pop(context),
    );

  }
}