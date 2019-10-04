import 'package:flutter/material.dart';

class AppBarButtonBack extends StatelessWidget {
  const AppBarButtonBack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    );

  }
}