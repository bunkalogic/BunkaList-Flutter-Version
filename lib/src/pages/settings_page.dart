import 'package:bunkalist/src/preferences/shared_preferences.dart';
import 'package:bunkalist/src/theme/app_themes.dart';
import 'package:bunkalist/src/theme/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class SettingsPage extends StatefulWidget {

  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final prefs = new Preferences();

  bool whatModeIs;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _createListPlatformOptions(context),
    );
  }

  

  

  //!  Common Components (Android & iOS)

  Widget _createListPlatformOptions(BuildContext context) {
    return PlatformWidget(
      android: (context) => _listOptionMaterial(),
      ios: (context) => _listOptionCupertino(),
    );
  }

  Widget _titleOfSections(String title){
    //* title of sections
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold ),
      ),
    );
  }

  Widget _createItemSettings(Color color, IconData icon, String text) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 18.0),),
      leading: Icon(icon, size: 25.0, color: color,),
      trailing: Icon(Icons.arrow_forward_ios, size: 20.0,),
      onTap: (){
        //* pushNamed 
      } ,
    );
  }

  _changedTheme() {
    if(!prefs.whatModeIs) {
      whatModeIs = prefs.whatModeIs;
      prefs.whatModeIs = true;
      BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: Apptheme.DarkTheme ));
    }else{
      whatModeIs = prefs.whatModeIs;
      prefs.whatModeIs = false;
      BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: Apptheme.LightTheme ));
    }
  }

  //! Material Components (Android)

  Widget _listOptionMaterial() {
    return ListView(
      children: <Widget>[
        //TODO: agregar el banner de publicadad aqui
        SizedBox(height: 15.0,),
        //TODO: agregar el card the version premium
        _titleOfSections('Configuration'),
        Divider(),
        _createItemSettings( Colors.green , Icons.supervised_user_circle, 'Edit your Profile '),
        _createItemSettings( Colors.lightBlue, Icons.settings_applications, 'Edit your preferences'),
        _createItemSettings( Colors.red, Icons.local_play, 'Go Premium'),
        SizedBox(height: 10.0,),
        _titleOfSections('Changed Mode'),
        Divider(),
        SizedBox(height: 15.0,),
        _createButtonChangedThemeMaterial(),
        SizedBox(height: 15.0,),
        _titleOfSections('About the App'),
        Divider(),
        _createItemSettings(Colors.greenAccent, Icons.format_list_bulleted, "license of open source"),
        _createItemSettings(Colors.blueAccent, Icons.screen_lock_portrait, "policy of privacity"),
        _createItemSettings(Colors.redAccent, Icons.verified_user, "condtion of use"),
        _createItemSettings(Colors.purpleAccent, Icons.rate_review, "rate the App"),
        Divider(),
        SizedBox(height: 10.0,),
        _buttonLogOutMaterial(),

      ],
    );
  }

  

  Widget _createButtonChangedThemeMaterial(){
    return IconButton(
      icon: _changedIconThemeMaterial(), //? is responsible for changing the icon depending on the theme
      onPressed: () => _changedTheme(), // ? is responsible for changing the theme
    );
  }
      
  Widget _changedIconThemeMaterial() {
    
    if(prefs.whatModeIs){
      return Icon(Icons.wb_incandescent, size: 40.0, color: Colors.yellow,);
    }else{
      return Icon(Icons.lightbulb_outline, size: 40.0, color: Colors.orange,);
    }
  }

  Widget _buttonLogOutMaterial(){
    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.purple,
        textColor: Colors.white,
        child: Text('LogOut', style: TextStyle(fontSize: 18.0),),
        onPressed: (){
          //TODO: Agregar logOut
        },

      ),
    );
  }

  //! Cupertino Components (iOS)

  Widget _listOptionCupertino() {
    return ListView(
      children: <Widget>[
        //TODO: agregar el banner de publicadad aqui
        SizedBox(height: 15.0,),
        //TODO: agregar el card the version premium
        _titleOfSections('Configuration'),
        Divider(),
        _createItemSettings( Colors.green , CupertinoIcons.profile_circled, 'Edit your Profile '),
        _createItemSettings( Colors.lightBlue, CupertinoIcons.settings, 'Edit your preferences'),
        _createItemSettings( Colors.red, CupertinoIcons.plus_circled, 'Go Premium'),
        SizedBox(height: 10.0,),
        _titleOfSections('Changed Mode'),
        Divider(),
         SizedBox(height: 15.0,),
        _createButtonChangedThemeCupertino(),
        SizedBox(height: 15.0,),
        _titleOfSections('About the App'),
        Divider(),
        _createItemSettings(Colors.greenAccent, CupertinoIcons.folder_open, "license of open source"),
        _createItemSettings(Colors.blueAccent, CupertinoIcons.info, "policy of privacity"),
        _createItemSettings(Colors.redAccent, CupertinoIcons.bookmark, "condtion of use"),
        _createItemSettings(Colors.purpleAccent, CupertinoIcons.check_mark, "rate the App"),
        Divider(),
        SizedBox(height: 10.0,),
        _buttonLogOutCupertino()
      ],
    );
  }

  Widget _createItemSettingsCupertino(Color color, IconData icon, String text) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 18.0),),
      leading: Icon(icon, size: 25.0, color: color,),
      trailing: Icon(Icons.arrow_forward_ios, size: 20.0,),
      onTap: (){
        //* pushNamed 
      } ,
    );
  }

  Widget _createButtonChangedThemeCupertino(){
    return IconButton(
      icon: _changedIconThemeCupertino(), //? is responsible for changing the icon depending on the theme
      onPressed: () => _changedTheme(), // ? is responsible for changing the theme
    );
  }

   Widget _changedIconThemeCupertino() {
    
    if(prefs.whatModeIs){
      return Icon(CupertinoIcons.lab_flask_solid, size: 40.0, color: Colors.yellow,);
    }else{
      return Icon(CupertinoIcons.lab_flask, size: 40.0, color: Colors.orange,);
    }
  }

  Widget _buttonLogOutCupertino() {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.purple,
      child: Text('LogOut', style: TextStyle(backgroundColor: Colors.white) ,),
      onPressed: (){
        //TODO: Agregar logOut
      },
    );
  }
      
        

  

  
}