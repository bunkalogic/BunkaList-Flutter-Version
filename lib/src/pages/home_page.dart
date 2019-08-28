import 'package:bunkalist/src/localization/app_localizations.dart';
import 'package:bunkalist/src/theme/app_themes.dart';
import 'package:bunkalist/src/theme/bloc/bloc.dart';
import 'package:bunkalist/src/theme/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  
  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      appBar: _createPlaformAppBar(context),
      android: (context) => _scaffoldMaterial(context),
      // Eliminar el appBar solo crear _scaffoldMaterial y _scaffoldCupertino
    );
  }

  MaterialScaffoldData _scaffoldMaterial(BuildContext context) {
    return MaterialScaffoldData(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens),
        onPressed:(){
          BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: Apptheme.DarkTheme ));
        } 
      )
    );
  }

  PlatformAppBar _createPlaformAppBar(BuildContext context) {
    return PlatformAppBar(
      android: (context) => _createToolbarMaterial(),
    );
  }

  MaterialAppBarData _createToolbarMaterial() {

    return MaterialAppBarData(
      title: Text(AppLocalizations.of(context).translate('btn_nav_timeline')),
    
    );
  }

  

  
}