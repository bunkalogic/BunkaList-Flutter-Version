import 'package:bunkalist/src/localization/app_localizations.dart';
import 'package:bunkalist/src/pages/profile_page.dart';
import 'package:bunkalist/src/pages/settings_page.dart';
import 'package:bunkalist/src/pages/timeline_page.dart';
import 'package:bunkalist/src/pages/tops_page.dart';
import 'package:bunkalist/src/theme/app_themes.dart';
import 'package:bunkalist/src/theme/bloc/bloc.dart';
import 'package:bunkalist/src/theme/bloc/theme_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //? Variables
  int _selectedTabIndex = 0;

  
  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      appBar: _createAppBarPlatform(context),
      body: _loadingPage(_selectedTabIndex),
      bottomNavBar: _createNavBarPlaform(context),
    );
  }
  
//!  Common Components (Android & iOS)


Widget _createAppBarPlatform(BuildContext context) {

    return PlatformAppBar(
      title: _titleAppBar(_selectedTabIndex),//Text(AppLocalizations.of(context).translate('btn_nav_timeline')),
      android: (context) => _appBarMaterial(),
      ios: (context) => _appBarCupertino(),
    
    );
  }

Widget _createNavBarPlaform(BuildContext context) {

  return PlatformNavBar(
    android: (context) => _navBarMaterial(),
    ios: (context) => _navBarCupertino(),
    currentIndex: _selectedTabIndex,
    itemChanged: (index) {
      setState(() {
        _selectedTabIndex = index;
      });
    },
  );

}

Widget _titleAppBar(int selectedTabIndex) {
  switch(selectedTabIndex){
    
    case 0: return Text(AppLocalizations.of(context).translate('btn_nav_top'));

    case 1: return Text(AppLocalizations.of(context).translate('btn_nav_timeline'));

    case 2: return Text(AppLocalizations.of(context).translate('btn_nav_profile'));

    case 3: return Text(AppLocalizations.of(context).translate('btn_nav_settings'));

    default: return Text(AppLocalizations.of(context).translate('btn_nav_top'));

  }
}

Widget _loadingPage(int position){
  
  switch(position){
    
    case 0: return TopsPage();

    case 1: return TimelinePage();

    case 2: return ProfilePage();

    case 3: return SettingsPage();

    default: return TopsPage();
    
  }
}
 

//! Material Components (Android)
    // BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: Apptheme.DarkTheme ));

  MaterialAppBarData _appBarMaterial() {
    return MaterialAppBarData(
      
      leading: Icon(Icons.account_circle, color: Colors.orange[900], size: 35.0 ,),
      actions: [
        _materialButtonSearch()
      ]
    );
  }

  Widget _materialButtonSearch() {
    return IconButton(
      iconSize: 35.0,
      color: Colors.orange[900],
      icon: Icon(Icons.search),
      onPressed: (){
        //* search all the TMDB
        
      },
    );
  }

  MaterialNavBarData _navBarMaterial() {
    return MaterialNavBarData(
      type: BottomNavigationBarType.fixed,
       items: [
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(Icons.home, color: Colors.blueGrey[500], size: 30.0, ),
           activeIcon: Icon(Icons.home, color: Colors.orange[900], size: 30.0, ),

         ),
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(Icons.line_weight, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(Icons.line_weight, color: Colors.orange[900], size: 30.0,),
         ),
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(Icons.person_pin, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(Icons.person_pin, color: Colors.orange[900], size: 30.0,), 
         ),
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(Icons.settings, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(Icons.settings, color: Colors.orange[900], size: 30.0,),
           
         ),
       ]
    );
  }


//! Cupertino Components (iOS)

  CupertinoNavigationBarData _appBarCupertino() {
    return CupertinoNavigationBarData(
      leading: Icon(CupertinoIcons.person, color: Colors.orange[900], size: 35.0,),
      trailing: _cupertinoButtonSearch(),
    );
  }

  Widget _cupertinoButtonSearch() {
    return IconButton(
      iconSize: 35.0,
      color: Colors.orange[900],
      icon: Icon(CupertinoIcons.search),
      onPressed: (){
        //* search all the TMDB
      },
    );
  }

  CupertinoTabBarData _navBarCupertino() {
    return CupertinoTabBarData(
      items: [
        BottomNavigationBarItem(
           title: Container(),
           icon: Icon(CupertinoIcons.home, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(CupertinoIcons.home, color: Colors.orange[900], size: 30.0,),

         ),
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(CupertinoIcons.collections, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(CupertinoIcons.collections, color: Colors.orange[900], size: 30.0,),
           
         ),
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(CupertinoIcons.profile_circled, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(CupertinoIcons.profile_circled, color: Colors.orange[900], size: 30.0,),
         ),
         BottomNavigationBarItem(
           title: Container(),
           icon: Icon(CupertinoIcons.settings, color: Colors.blueGrey[500], size: 30.0,),
           activeIcon: Icon(CupertinoIcons.settings, color: Colors.orange[900], size: 30.0,),
           
         ),
      ]
    );
  }

  

  

 

  

  
}