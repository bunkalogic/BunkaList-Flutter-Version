import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';

class LicensePage extends StatelessWidget {
  const LicensePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: _appBar(),
    //   body: _listLicense(),
    // );
    return Container();
  }

  // Widget _appBar() {
  //   return AppBar(
  //     title: Text('Open Source Licenses'),
  //     leading: AppBarButtonBack(),
  //   );
  // }

  // Widget _listLicense() {
  //   return ListView(
  //     children: <Widget>[
  //       _itemLicense('Bloc', 'https://github.com/felangel/bloc'),
  //     ],
  //   );
  // }

  // Widget _itemLicense(String nameProject, String linkProject){
  //   return ListTile(
  //     title: Text(
  //       nameProject,
  //       style: TextStyle(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.w600
  //       ),
  //     ),
  //     subtitle: Text(
  //       linkProject,
  //       style: TextStyle(
  //         fontSize: 16.0,
  //         fontWeight: FontWeight.w500,
  //         color: Colors.blue,
  //         decoration: TextDecoration.underline
  //       ),
  //     ),
  //   );
  // }
}