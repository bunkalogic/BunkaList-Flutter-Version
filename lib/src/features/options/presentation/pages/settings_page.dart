import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/theme/save_default_theme.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';
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

  

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _createListPlatformOptions(context),
    );
  }

  

  

  //!  Common Components (Android & iOS)

  Widget _createListPlatformOptions(BuildContext context) {
    return PlatformWidget(
      android: (context) => _listOptionMaterial(context),
      ios: (context) => _listOptionCupertino(context),
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

  Widget _createItemSettings(BuildContext context, Color color, IconData icon, String text, String routeName) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 18.0),),
      leading: Icon(icon, size: 25.0, color: color,),
      trailing: Icon(Icons.arrow_forward_ios, size: 20.0,),
      onTap: () => Navigator.pushNamed(context, routeName),
    );
  }

  //! Material Components (Android)

  Widget _listOptionMaterial(BuildContext context) {
    return ListView(
      children: <Widget>[
        //TODO: agregar el banner de publicadad aqui
        SizedBox(height: 15.0,),
        //TODO: agregar el card the version premium
        _titleOfSections('Configuration'),
        Divider(),
        _createItemSettings(context, Colors.green , Icons.supervised_user_circle, 'Edit your Profile', '' ),
        _createItemSettings(context, Colors.lightBlue, Icons.settings_applications, 'Edit your preferences', ''),
        _createItemSettings(context, Colors.red, Icons.local_play, 'Go Premium', ''),
        SizedBox(height: 10.0,),
        _titleOfSections('Changed Mode'),
        Divider(),
        SizedBox(height: 15.0,),
        _createButtonChangedThemeMaterial(context),
        SizedBox(height: 15.0,),
        _titleOfSections('About the App'),
        Divider(),
        _createItemSettings(context, Colors.greenAccent, Icons.format_list_bulleted, "license of open source", '/Licenses'),
        _createItemSettings(context, Colors.blueAccent, Icons.screen_lock_portrait, "policy of privacity", ''),
        _createItemSettings(context, Colors.redAccent, Icons.verified_user, "condtion of use", ''),
        _createItemSettings(context, Colors.purpleAccent, Icons.rate_review, "rate the App", ''),
        Divider(),
        SizedBox(height: 10.0,),
        BlocProvider<AuthenticationBloc>(
      builder: (_) => serviceLocator<AuthenticationBloc>(),
      child: ButtomLogOut(),
      ),

      ],
    );
  }

  

  Widget _createButtonChangedThemeMaterial(BuildContext context){
    return IconButton(
      icon: _changedIconThemeMaterial(), //? is responsible for changing the icon depending on the theme
      onPressed: () => SaveDefaultTheme().changedTheme(context), // ? is responsible for changing the theme
    );
  }
      
  Widget _changedIconThemeMaterial() {
    
    if(prefs.whatModeIs){
      return Icon(Icons.brightness_2, size: 40.0, color: Colors.yellow,);
    }else{
      return Icon(Icons.brightness_7, size: 40.0, color: Colors.orange,);
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
          BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
          Navigator.pushNamedAndRemoveUntil(context, '/Login', (_) => false);
        },

      ),
    );
  }

  //! Cupertino Components (iOS)

  Widget _listOptionCupertino(BuildContext context) {
    return ListView(
      children: <Widget>[
        //TODO: agregar el banner de publicadad aqui
        SizedBox(height: 15.0,),
        //TODO: agregar el card the version premium
        _titleOfSections('Configuration'),
        Divider(),
        _createItemSettings(context, Colors.green , CupertinoIcons.profile_circled, 'Edit your Profile', ''),
        _createItemSettings(context, Colors.lightBlue, CupertinoIcons.settings, 'Edit your preferences', ''),
        _createItemSettings(context, Colors.red, CupertinoIcons.plus_circled, 'Go Premium', ''),
        SizedBox(height: 10.0,),
        _titleOfSections('Changed Mode'),
        Divider(),
         SizedBox(height: 15.0,),
        _createButtonChangedThemeCupertino(context),
        SizedBox(height: 15.0,),
        _titleOfSections('About the App'),
        Divider(),
        _createItemSettings(context, Colors.greenAccent, CupertinoIcons.folder_open, "license of open source", ''),
        _createItemSettings(context, Colors.blueAccent, CupertinoIcons.info, "policy of privacity", ''),
        _createItemSettings(context, Colors.redAccent, CupertinoIcons.bookmark, "condtion of use", ''),
        _createItemSettings(context, Colors.purpleAccent, CupertinoIcons.check_mark, "rate the App", ''),
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

  Widget _createButtonChangedThemeCupertino(BuildContext context){
    return IconButton(
      icon: _changedIconThemeCupertino(), //? is responsible for changing the icon depending on the theme
      onPressed: () => SaveDefaultTheme().changedTheme(context), // ? is responsible for changing the theme
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


class ButtomLogOut extends StatelessWidget {
  const ButtomLogOut({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Preferences prefs = new Preferences();

    return Center(
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.purple,
        textColor: Colors.white,
        child: Text('LogOut', style: TextStyle(fontSize: 18.0),),
        onPressed: (){
          
          prefs.getCurrentUsername = '';
          prefs.getCurrentUserPhoto = '';
          prefs.getCurrentUserUid = '';
          prefs.currentUserHasToken = false;

          BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
          _goToLogin(context);
        },

      ),
    );
  }

  _goToLogin(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(context, '/Login', (_) => false);
  }
}