import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:bunkalist/src/features/search/presentation/bloc/bloc.dart';
import 'package:bunkalist/src/features/search/presentation/pages/search_page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/home_tops/presentation/pages/tops_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/settings_page.dart';
import 'package:bunkalist/src/features/profile/presentation/pages/profile_page.dart';
import 'package:bunkalist/src/features/timeline/presentation/pages/timeline_page.dart';


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
             image: AssetImage('assets/bunkalist-banner.png'),
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


  Widget _createNavBar(){
    return FancyBottomNavigation(
      activeIconColor: Colors.deepOrangeAccent[400] ,
      inactiveIconColor: Colors.deepPurpleAccent[700] ,
      circleColor: Colors.deepPurpleAccent[700],
      initialSelection: _selectedTabIndex,
      onTabChangedListener: (position) {
        setState(() {
          _selectedTabIndex = position;
        });
      },
      tabs: [
        TabData(title: AppLocalizations.of(context).translate('btn_nav_top'), iconData: Icons.home, ),
        TabData(title: AppLocalizations.of(context).translate('btn_nav_profile'), iconData: Icons.person, ),
        TabData(title: AppLocalizations.of(context).translate('btn_nav_settings'), iconData: Icons.settings, ),
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

// Widget _createNavBarPlaform(BuildContext context) {

//   return PlatformNavBar(
//     backgroundColor: prefs.whatModeIs ? Colors.grey[900] : Colors.grey[100],
//     android: (context) => _navBarMaterial(),
//     ios: (context) => _navBarCupertino(),
//     currentIndex: _selectedTabIndex,
//     itemChanged: (index) {
//       setState(() {
//         _selectedTabIndex = index;
//       });
//     },
//   );

// }

// Widget _titleAppBar(int selectedTabIndex) {
//   switch(selectedTabIndex){
    
//     case 0: return Text(
//       AppLocalizations.of(context).translate('btn_nav_top'),
//       );

//     case 1: return Text(
//       AppLocalizations.of(context).translate('btn_nav_timeline'),
//       );

//     case 2: return Text(
//       AppLocalizations.of(context).translate('btn_nav_profile'),
//       );

//     case 3: return Text(
//       AppLocalizations.of(context).translate('btn_nav_settings'),
//       );

//     default: return Text(
//       AppLocalizations.of(context).translate('btn_nav_top'),
//       );

//   }
// }


 

//! Material Components (Android)
    // BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: Apptheme.DarkTheme ));

  // MaterialAppBarData _appBarMaterial() {
  //   return MaterialAppBarData(
      
  //     leading: Icon(Icons.account_circle, color: Colors.purple[500], size: 35.0 ,),
  //     actions: [
  //       _materialButtonSearch()
  //     ]
  //   );
  // }

  // MaterialAppBarData _appBarMaterial() {
  //   return MaterialAppBarData(
      
  //     // leading: SizedBox(
  //     //   height: double.infinity,
  //     //   width: 140.0,
  //     //   child: Padding(
  //     //     padding: const EdgeInsets.only(left: 5.0),
  //     //     child: Image(
  //     //       image: AssetImage('assets/bunkalist-banner.png'),
  //     //     ),
  //     //   ),
  //     // ),
  //     actions: [
  //       _materialButtonSearch()
  //     ]
  //   );
  // }

  // MaterialNavBarData _navBarMaterial() {
  //   return MaterialNavBarData( 
  //     elevation: 10.0,
  //     type: BottomNavigationBarType.fixed,
  //      items: [
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(Icons.home, color: Colors.blueGrey[500], size: 30.0, ),
  //          activeIcon: Icon(Icons.home, color: Colors.purple[500], size: 30.0, ),

  //        ),
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(Icons.line_weight, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(Icons.line_weight, color: Colors.purple[500], size: 30.0,),
  //        ),
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(Icons.person_pin, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(Icons.person_pin, color: Colors.purple[500], size: 30.0,), 
  //        ),
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(Icons.settings, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(Icons.settings, color: Colors.purple[500], size: 30.0,),
           
  //        ),
  //      ]
  //   );
  // }


//! Cupertino Components (iOS)

  // CupertinoNavigationBarData _appBarCupertino() {
  //   return CupertinoNavigationBarData(
  //     leading: Icon(CupertinoIcons.person, color: Colors.purple[500], size: 35.0,),
  //     trailing: _cupertinoButtonSearch(),
  //   );
  // }

  // Widget _cupertinoButtonSearch() {
  //   return IconButton(
  //     iconSize: 35.0,
  //     color: Colors.purple[500],
  //     icon: Icon(CupertinoIcons.search),
  //     onPressed: (){
  //       //* search all the TMDB
  //     },
  //   );
  // }

  // CupertinoTabBarData _navBarCupertino() {
  //   return CupertinoTabBarData(
  //     items: [
  //       BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(CupertinoIcons.home, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(CupertinoIcons.home, color: Colors.purple[500], size: 30.0,),

  //        ),
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(CupertinoIcons.collections, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(CupertinoIcons.collections, color: Colors.purple[500], size: 30.0,),
           
  //        ),
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(CupertinoIcons.profile_circled, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(CupertinoIcons.profile_circled, color: Colors.purple[500], size: 30.0,),
  //        ),
  //        BottomNavigationBarItem(
  //          title: Container(),
  //          icon: Icon(CupertinoIcons.settings, color: Colors.blueGrey[500], size: 30.0,),
  //          activeIcon: Icon(CupertinoIcons.settings, color: Colors.purple[500], size: 30.0,),
           
  //        ),
  //     ]
  //   );
  // }

}


class SearchButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      iconSize: 35.0,
      color: Colors.deepPurpleAccent[400],
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