import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:bunkalist/src/features/search/presentation/bloc/bloc.dart';
import 'package:bunkalist/src/features/search/presentation/pages/search_page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/home_tops/presentation/pages/tops_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/settings_page.dart';
import 'package:bunkalist/src/features/profile/presentation/pages/profile_page.dart';


class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //? Variables
  int _selectedTabIndex = 0;
  final prefs = new Preferences();

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _createAppBarPlatform(context),
      body: _loadingPage(_selectedTabIndex),
      bottomNavigationBar: _createNavBar(),
    );
  }
  
//!  Common Components (Android & iOS)


Widget _createAppBarPlatform(BuildContext context) {

    return AppBar(
      //title: _titleAppBar(_selectedTabIndex),//Text(AppLocalizations.of(context).translate('btn_nav_timeline')),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            height: 60.0,
             image: _getAppBarImage(),
           ),
        ],
      ),

      actions: <Widget>[
        new BlocProvider(
          builder: (_) => serviceLocator<SearchBloc>(),
          child:SearchButton(),
        ),
        
      ],
    
    );
  }

  ImageProvider _getAppBarImage(){
    final bool theme = prefs.whatModeIs;

    if(theme){
      return AssetImage('assets/bunkalist-banner-purple.png');
    }else{
      return AssetImage('assets/bunkalist-banner.png');
    }
  }

  Widget _createNavBar(){
    return FancyBottomNavigation(
      barBackgroundColor: _getTabbarBackgroundColor(),
      activeIconColor: Colors.deepOrangeAccent[400] ,
      inactiveIconColor: Colors.deepPurpleAccent,
      circleColor: Colors.deepPurpleAccent[400],
      initialSelection: _selectedTabIndex,
      onTabChangedListener: (position) {
        setState(() {
          _selectedTabIndex = position;
        });
      },
      tabs: [
        TabData(title: AppLocalizations.of(context).translate("btn_nav_top"), iconData: Icons.home, ),
        TabData(title: AppLocalizations.of(context).translate("btn_nav_profile"), iconData: Icons.person, ),
        TabData(title: AppLocalizations.of(context).translate("btn_nav_settings"), iconData: Icons.settings, ),
      ],
    );
  }

  Widget _loadingPage(int position){
  
  switch(position){
    
    case 0: return TopsPage();

    case 1: return ProfilePage();

    case 2: return SettingsPage();

    default: return TopsPage();
    
  }
}

 Color _getTabbarBackgroundColor(){

    final bool theme = prefs.whatModeIs;
    
    if(theme){
      return Colors.blueGrey[800];
    }else{
      return Colors.grey[100];
    }
 }


}


class SearchButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      iconSize: 35.0,
      color: Colors.deepPurpleAccent,
      icon: Icon(Icons.search),
      onPressed: (){
        
         showSearch<ResultsEntity>(
          context: context,
          delegate: MultiSearchWidget(BlocProvider.of<SearchBloc>(context)),
        );
       
      },
    );

  }

}