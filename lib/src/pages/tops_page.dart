import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



class TopsPage extends StatefulWidget {
  TopsPage({Key key}) : super(key: key);

  _TopsPageState createState() => _TopsPageState();
}

class _TopsPageState extends State<TopsPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: Text('Tops Page')    
      ),
    );
  }

  
  
  //!  Common Components (Android & iOS)

  //! Material Components (Android)
  
  //! Cupertino Components (iOS)


  
}