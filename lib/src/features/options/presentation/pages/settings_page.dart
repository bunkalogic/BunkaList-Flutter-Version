import 'package:app_review/app_review.dart';
import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/theme/app_themes.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/theme/save_default_theme.dart';
import 'package:bunkalist/src/features/login/data/datasources/get_guest_sesion_id_data_remote_source.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:package_info/package_info.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsPage extends StatefulWidget {

  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final prefs = new Preferences();
  final _controller = NativeAdmobController();


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createListPlatformOptions(context),
    );
  }

  

  

  //!  Common Components (Android & iOS)

  Widget _createListPlatformOptions(BuildContext context) {
    return _listOptionMaterial(context);
  }

  Widget _titleOfSections(String title){
    //* title of sections
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold ),
      ),
    );
  }

  Widget _createItemSettings(BuildContext context, Color color, IconData icon, String text, Function() onTap) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 18.0),),
      leading: Icon(icon, size: 25.0, color: color,),
      trailing: Icon(Icons.arrow_forward_ios, size: 20.0,),
      onTap: onTap,
    );
  }

  //! Material Components (Android)

  Widget _listOptionMaterial(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 15.0,),
        !prefs.currentUserHasToken 
        ? BlocProvider<AuthenticationBloc>(
          create: (_) => serviceLocator<AuthenticationBloc>(),
          child: ButtomLogOut(),
        )
        : Container(),
        !prefs.currentUserHasToken 
        ? SizedBox(height: 15.0,)
        : SizedBox.shrink(),
        _titleOfSections(AppLocalizations.of(context).translate("configuration")),
        Divider(),
        prefs.currentUserHasToken 
        ? _createItemSettings(context, Colors.greenAccent , Icons.supervised_user_circle, AppLocalizations.of(context).translate("label_edit_profile"), (){
          Navigator.pushNamed(context, '/EditProfile');
        } )
        : Container(),
        _createItemSettings(context, Colors.deepOrangeAccent, Icons.settings_applications, AppLocalizations.of(context).translate("label_edit_preferences"), (){
          Navigator.pushNamed(context, '/EditPreferences');
        } 
        ),
        _createItemSettings(context, Colors.pinkAccent, Icons.local_play, AppLocalizations.of(context).translate("label_premium"), (){
          Navigator.pushNamed(context, '/Premium');
        }),
        // _createItemSettings(context, Colors.blueAccent, Icons.card_giftcard, AppLocalizations.of(context).translate("label_ads"), (){
        //   Navigator.pushNamed(context, '/NoAds');
        //   //_flushbarInProgress();
        // } ),
        _createItemSettings(context, Colors.lightBlueAccent, Icons.translate, AppLocalizations.of(context).translate("label_change_language"), () async{
          final result = await Navigator.pushNamed(context, '/Language');

          if(result){
            setState(() {});
          }
        } ),
        SizedBox(height: 10.0,),
        _titleOfSections(AppLocalizations.of(context).translate("label_change_theme")),
        Divider(),
        SizedBox(height: 15.0,),
        //_createButtonChangedThemeMaterial(context),
        _createItemSettings(context, Colors.yellowAccent[400], Icons.lightbulb_outline, AppLocalizations.of(context).translate("label_change_theme"), () => _showBottomModalChangedTheme() ),
        SizedBox(height: 15.0,),
        _titleOfSections(AppLocalizations.of(context).translate("label_about_app")),
        Divider(),
        _createItemSettings(context, Colors.yellowAccent, Icons.email_rounded, AppLocalizations.of(context).translate("label_feedback"), () async {

          PackageInfo packageInfo = await PackageInfo.fromPlatform();            

          String _version = packageInfo.version;
          String _buildNumber = packageInfo.buildNumber;

            final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'bunkalist.client@gmail.com',
              queryParameters: {
                'subject': 'FEEDBACK ${prefs.getCurrentUsername} ',
                'body': 'VersionNumber: $_version BuildNumber: $_buildNumber LanguageDevice: ${prefs.getLanguageOfDevice}'
              }
            );

            launch(_emailLaunchUri.toString());
        }),

        _createItemSettings(context, Colors.deepPurpleAccent, Icons.rate_review, AppLocalizations.of(context).translate("label_rate_app"), (){
          AppReview.writeReview.then((onValue){
            setState(() {
              print(onValue);
            });
            
          });
        }),
        _createItemSettings(context, Colors.redAccent, Icons.business_center, AppLocalizations.of(context).translate("label_about_bunkalist"), (){
          Navigator.pushNamed(context, '/About');
        }),
        _createItemSettings(context, Colors.greenAccent, Icons.format_list_bulleted, AppLocalizations.of(context).translate("label_license_open_source"), (){
          Navigator.pushNamed(context, '/Licenses');
        }),
        _createItemSettings(context, Colors.blueAccent, Icons.screen_lock_portrait, AppLocalizations.of(context).translate("label_privacity"), (){
          launch('https://www.freeprivacypolicy.com/live/8eee355a-3a31-4a3c-9eb3-5b71051ddd83');
        }),
        Divider(),
        SizedBox(height: 10.0,),
        prefs.currentUserHasToken 
        ? BlocProvider<AuthenticationBloc>(
          create: (_) => serviceLocator<AuthenticationBloc>(),
          child: ButtomLogOut(),
        )
        : Container(),
        SizedBox(height: 10.0,),
      //MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/4711162518',),
      ],
    );
  }


  void _flushbarInProgress(){
     Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.blueAccent[700], Colors.blueAccent[400]],),
      backgroundColor: Colors.blue[500],
      boxShadows: [BoxShadow(color: Colors.blue[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 5),
      messageText: Text(
        AppLocalizations.of(context).translate("in_progress"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
  }

  

  // Widget _createButtonChangedThemeMaterial(BuildContext context){
  //   return IconButton(
  //     icon: _changedIconThemeMaterial(), //? is responsible for changing the icon depending on the theme
  //     onPressed: () => SaveDefaultTheme().changedTheme(context), // ? is responsible for changing the theme
  //   );
  // }
      
  // Widget _changedIconThemeMaterial() {
    
  //   if(prefs.whatModeIs){
  //     return Icon(Icons.brightness_2, size: 40.0, color: Colors.yellow,);
  //   }else{
  //     return Icon(Icons.brightness_7, size: 40.0, color: Colors.orange,);
  //   }
  // }

    _showBottomModalChangedTheme(){
      showModalBottomSheet(
      elevation: 10.0,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      builder: (_) => BuildBottomModalChangedTheme(), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
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
        _createItemSettings(context, Colors.green , CupertinoIcons.profile_circled, 'Edit your Profile', null),
        _createItemSettings(context, Colors.lightBlue, CupertinoIcons.settings, 'Edit your preferences', null),
        _createItemSettings(context, Colors.red, CupertinoIcons.plus_circled, 'Go Premium', null),
        SizedBox(height: 10.0,),
        _titleOfSections('Changed Mode'),
        Divider(),
         SizedBox(height: 15.0,),
        // _createButtonChangedThemeCupertino(context),
        SizedBox(height: 15.0,),
        _titleOfSections('About the App'),
        Divider(),
        _createItemSettings(context, Colors.greenAccent, CupertinoIcons.folder_open, "license of open source", null),
        _createItemSettings(context, Colors.blueAccent, CupertinoIcons.info, "policy of privacity", null),
        _createItemSettings(context, Colors.redAccent, CupertinoIcons.bookmark, "condtion of use", null),
        _createItemSettings(context, Colors.purpleAccent, CupertinoIcons.check_mark, "rate the App", null),
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

  // Widget _createButtonChangedThemeCupertino(BuildContext context){
  //   return IconButton(
  //     icon: _changedIconThemeCupertino(), //? is responsible for changing the icon depending on the theme
  //     onPressed: () => SaveDefaultTheme().changedTheme(context), // ? is responsible for changing the theme
  //   );
  // }

  //  Widget _changedIconThemeCupertino() {
    
  //   if(prefs.whatModeIs){
  //     return Icon(CupertinoIcons.lab_flask_solid, size: 40.0, color: Colors.yellow,);
  //   }else{
  //     return Icon(CupertinoIcons.lab_flask, size: 40.0, color: Colors.orange,);
  //   }
  // }

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

class BuildBottomModalChangedTheme extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _createItemSettings(context, Colors.orangeAccent[400], Icons.brightness_7_rounded, 
        AppLocalizations.of(context).translate("label_theme_light"),
        () {
          prefs.whatModeIs = false;
          prefs.whatDarkIs = false;
          prefs.whatSepia = false;
          prefs.whatDarkBlue = false;
          SaveDefaultTheme().changedTheme(context, Apptheme.LightTheme,);
          Navigator.of(context).pop();
        },), 
        _createItemSettings(context, Colors.yellow[100], Icons.brightness_6_rounded, 
        AppLocalizations.of(context).translate("label_theme_light_sepia"),
        () {
          prefs.whatModeIs = false;
          prefs.whatDarkIs = false;
          prefs.whatSepia = true;
          prefs.whatDarkBlue = false;
          SaveDefaultTheme().changedTheme(context, Apptheme.SepiaTheme,);
          Navigator.of(context).pop();
        },), 
        _createItemSettings(context, Colors.yellowAccent[400], Icons.brightness_1_rounded,
        AppLocalizations.of(context).translate("label_theme_light_dark"),
         () {
          prefs.whatModeIs = true;
          prefs.whatDarkIs = false;
          prefs.whatSepia = false;
          prefs.whatDarkBlue = false;
          SaveDefaultTheme().changedTheme(context, Apptheme.DarkTheme,);
          Navigator.of(context).pop();
        },), 
        _createItemSettings(context, Colors.yellowAccent[700], Icons.brightness_3_rounded, 
        AppLocalizations.of(context).translate("label_theme_dark"),
         () {
          prefs.whatModeIs = true;
          prefs.whatDarkIs = true;
          prefs.whatSepia = false;
          prefs.whatDarkBlue = false;
          SaveDefaultTheme().changedTheme(context, Apptheme.DarkerTheme,);
          Navigator.of(context).pop();
        },), 
        _createItemSettings(context, Colors.indigoAccent[100], Icons.brightness_4_rounded, 
        AppLocalizations.of(context).translate("label_theme_light_blue"),
         () {
          prefs.whatModeIs = true;
          prefs.whatDarkIs = true;
          prefs.whatSepia = false;
          prefs.whatDarkBlue = true;
          SaveDefaultTheme().changedTheme(context, Apptheme.BlueDarkTheme,);
          Navigator.of(context).pop();
        },), 
      ],
    );
  }
  
  Widget _createItemSettings(BuildContext context, Color color, IconData icon, String text, Function() onTap) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 18.0),),
      leading: Icon(icon, size: 25.0, color: color,),
      onTap: onTap,
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
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        textColor: Colors.white,
        child: Text(
          prefs.currentUserHasToken ? AppLocalizations.of(context).translate("button_logout") : AppLocalizations.of(context).translate("login"), 
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        onPressed: (){
          if(!prefs.currentUserHasToken){
            return Navigator.pushNamed(context, '/Login');
          }
           _alertDialogOfDelete(context);
        },

      ),
    );
  }

  void _alertDialogOfDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_){
        return BlocProvider<AuthenticationBloc>(
        create: (_) => serviceLocator<AuthenticationBloc>(),
        child: BuildLogoutDialog(),
      );
      }
    );
  }

  
}


class BuildLogoutDialog extends StatefulWidget {
 

  BuildLogoutDialog();


  @override
  _BuildLogoutDialogState createState() => _BuildLogoutDialogState();
}

class _BuildLogoutDialogState extends State<BuildLogoutDialog> {
  
   final prefs = new Preferences();
  
  @override
  Widget build(BuildContext context) {
    return Container( 
       child: AlertDialog(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),   
        backgroundColor: getBackgroundColorTheme(),
        elevation: 10.0,
        title: Text(
          AppLocalizations.of(context).translate("label_dialog_logout"),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        content: Text(
          AppLocalizations.of(context).translate("Label_subtitle_logout"),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
        actions: <Widget>[
          _buttonCancel(context),
          SizedBox(width: 2,),
          _buttonAccept(context),
          SizedBox(width: 5,),
        ],
       ),
    );
  }

  

  Widget _buttonCancel(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      color: Colors.blueGrey[500].withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), 
      child: Text(
        AppLocalizations.of(context).translate("cancel"),
        style: TextStyle(
          color: prefs.whatModeIs ? Colors.pinkAccent[400] :  Colors.deepPurpleAccent[400],
          fontSize: 16.0,
          fontWeight: FontWeight.w700
          ),
        )
    );
  }

  _buttonAccept(BuildContext context) {
    return FlatButton(
      color: Colors.blueGrey[500].withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: () {

        

          prefs.getCurrentUsername = '';
          prefs.getCurrentUserPhoto = '';
          prefs.getCurrentUserUid = '';
          prefs.currentUserHasToken = false;
          prefs.isNotAds = false;
          prefs.listMoviesIds = [];
          prefs.listSerieIds = [];
          prefs.listAnimeIds = [];

          Purchases.reset();

          BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
         

        getFlushbarSuccessDelete(context);

        return Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
       
      }, 
      child: Text(
        AppLocalizations.of(context).translate("button_logout"),
        style: TextStyle(
          color: prefs.whatModeIs ? Colors.pinkAccent[400] :  Colors.deepPurpleAccent[400],
          fontSize: 16.0,
          fontWeight: FontWeight.w700
          ),
        )
    );
  }


  _goToLogin(BuildContext context){
    return Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }


  void getFlushbarSuccessDelete(BuildContext context){

    final String label = AppLocalizations.of(context).translate("button_logout");

    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.redAccent[700], Colors.redAccent[400]],),
      backgroundColor: Colors.red[500],
      boxShadows: [BoxShadow(color: Colors.red[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 2),
      messageText: Text(
        '$label ...',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    

  }
}