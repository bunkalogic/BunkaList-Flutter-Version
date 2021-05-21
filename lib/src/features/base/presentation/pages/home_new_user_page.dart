import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/explorer/presentation/pages/explorer_page.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/filter_personalized_dailog_widget.dart';
import 'package:bunkalist/src/features/login/data/datasources/get_guest_sesion_id_data_remote_source.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:bunkalist/src/features/search/presentation/bloc/bloc.dart';
import 'package:bunkalist/src/features/search/presentation/pages/search_page.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/pages/tops_favorites_page.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/pages/personal_home_tops.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/widgets/list_personalized_tops_widget.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/home_tops/presentation/pages/tops_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/settings_page.dart';
import 'package:bunkalist/src/features/profile/presentation/pages/profile_page.dart';
import 'package:in_app_update/in_app_update.dart';


class HomeNewUserPage extends StatefulWidget {

  _HomeNewUserPageState createState() => _HomeNewUserPageState();
}

class _HomeNewUserPageState extends State<HomeNewUserPage> {

  //? Variables
  int _selectedTabIndex = 0;
  final prefs = new Preferences();
  AppUpdateInfo _updateInfo;
  bool _flexibleUpdateAvailable = false;


  ///TODO implement In App Update for native app android, example:
  ///https://github.com/feilfeilundfeil/flutter_in_app_update/blob/master/example/lib/main.dart

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
  }

   void _showError(dynamic exception) {
     FlushbarHelper.createError(message: exception.toString(), title: 'Error');
   }

   startFlexibleUpdate(){
     if(_updateInfo?.updateAvailable == true){

      InAppUpdate.startFlexibleUpdate().then((_) {
        setState(() {
          _flexibleUpdateAvailable = true;
        });
      }).catchError((e) => _showError(e));

     }
   }

   completeFlexibleUpdate(){
     if(_flexibleUpdateAvailable){
        InAppUpdate.completeFlexibleUpdate().then((_) {
          FlushbarHelper.createSuccess(message: 'Success!!!');
        }).catchError((e) => _showError(e));
     }
     
   }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _createAppBarPlatform(context),
      body: _loadingPage(),
      bottomNavigationBar: _buildBottomNav(),  //_createNavBar(),  
    );
  }
  
//!  Common Components (Android & iOS)

Widget _hideAppbar(){
  return PreferredSize(
    preferredSize: Size(0.0, 0.0),
    child: Container(),
  );
}


Widget _createAppBarPlatform(BuildContext context) {

    return AppBar(
      //title: _titleAppBar(_selectedTabIndex),//Text(AppLocalizations.of(context).translate('btn_nav_timeline')),
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: <Widget>[
      //     Image(
      //       height: 22.0,
      //        image: _getAppBarImage(),
      //      ),
      //   ],
      // ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        _titleSection(),
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold
        ),
      ),
      actions: <Widget>[
        if(_selectedTabIndex != 2) new BlocProvider(
          create: (_) => serviceLocator<SearchBloc>(),
          child:SearchButton(),
        ),
        if(_selectedTabIndex != 2) FilterButton(),
        if(_selectedTabIndex == 0) EditHomeButton(),
      ],
    
    );
  }

  String _titleSection(){
   
   switch(_selectedTabIndex){
    
    case 0: return AppLocalizations.of(context).translate("btn_nav_top");

    case 1: return AppLocalizations.of(context).translate("btn_nav_explore");

    case 2: return AppLocalizations.of(context).translate("btn_nav_settings");

    default: return AppLocalizations.of(context).translate("btn_nav_top");
    
  }

 }

  ImageProvider _getAppBarImage(){
    final bool theme = prefs.whatModeIs;

    if(theme){
      return AssetImage('assets/bunkalist-banner.png');
    }else{
      return AssetImage('assets/bunkalist-banner-purple.png');
    }
  }


  Widget _buildBottomNav(){

    List<TabItem<dynamic>> items = [
      TabItem(
        icon: Icon(Icons.home_outlined, size: 26.0, color: _getColorOffIcon(),), 
        activeIcon: Icon(Icons.home_outlined, size: 26.0, color: _getColorActiveIcon(),),
        title: AppLocalizations.of(context).translate("btn_nav_top"), 
      ),
      TabItem(
        icon: Icon(Icons.explore_outlined, size: 26.0, color: _getColorOffIcon(),), 
        activeIcon: Icon(Icons.explore_outlined, size: 26.0, color: _getColorActiveIcon(),),
        title: AppLocalizations.of(context).translate("btn_nav_explore"), 
      ),
      TabItem(
        icon: Icon(Icons.settings_applications_outlined, size: 26.0, color: _getColorOffIcon(),), 
        activeIcon: Icon(Icons.settings_applications_outlined, size: 26.0, color: _getColorActiveIcon()),
        title: AppLocalizations.of(context).translate("btn_nav_settings"), 
      ),
      
    ];

    return ConvexAppBar(
      items: items,
      style: TabStyle.flip,
      height: 65,
      color: _getColorOffIcon(),
      backgroundColor: _getTabbarBackgroundColor(),
      activeColor: _getColorActiveIcon(),
      elevation: 12.0,
      top: 0,
      onTap: (index) {
        setState(() {
          _selectedTabIndex = index;
        });
      },
    );

  }



  // Widget _createNavBar(){
  //   return FancyBottomNavigation(
  //     barBackgroundColor: _getTabbarBackgroundColor(),
  //     activeIconColor: Colors.pinkAccent[400] ,
  //     inactiveIconColor: Colors.deepPurpleAccent,
  //     circleColor: Colors.deepPurpleAccent[400],
  //     initialSelection: _selectedTabIndex,
  //     onTabChangedListener: (position) {
  //       setState(() {
  //         _selectedTabIndex = position;
  //       });
  //     },
  //     tabs: [
  //       TabData(title: AppLocalizations.of(context).translate("btn_nav_top"), iconData: Icons.home, ),
  //       TabData(title: AppLocalizations.of(context).translate("btn_nav_explore"), iconData: Icons.explore, ),
  //       TabData(title: AppLocalizations.of(context).translate("btn_nav_profile"), iconData: Icons.person, ),
  //       TabData(title: 'Tops', iconData: Icons.stacked_bar_chart, ),
  //       TabData(title: AppLocalizations.of(context).translate("btn_nav_settings"), iconData: Icons.settings, ),
  //     ],
  //   );
  // }

  Widget _loadingPage(){
  
  switch(_selectedTabIndex){
    
    case 0: return TopsPage();

    case 1: return ExplorerPage();

    case 2: return SettingsPage();

    default: return TopsPage();
    
  }
}


 Color _getColorActiveIcon(){
   final bool theme = prefs.whatModeIs;

   return theme ?  Colors.pinkAccent[400] : Colors.deepPurpleAccent[400];
 }

 Color _getColorOffIcon(){
   final bool theme = prefs.whatModeIs;
   final bool themeDark = prefs.whatDarkIs;

   return theme 
   ? themeDark 
      ? Colors.grey[700] 
      : Colors.blueGrey[500]
   : Colors.blueGrey[300];
 }


 Color _getTabbarBackgroundColor(){

    final bool theme = prefs.whatModeIs;
    final bool dark = prefs.whatDarkIs;
    
    if(theme && dark == false){
      return Colors.blueGrey[800];
    }else if(theme && dark){
      return Colors.grey[900];
    }else{
      return Colors.grey[100];
    }
 }


}


class SearchButton extends StatelessWidget{

  final prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      iconSize: 28.0,
      color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      icon: Icon(Icons.search_rounded),
      onPressed: (){
        
         showSearch<ResultsEntity>(
          context: context,
          delegate: MultiSearchWidget(BlocProvider.of<SearchBloc>(context)),
        );
       
      },
    );

  }

}

class FilterButton extends StatelessWidget{

  final prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      iconSize: 26.0,
      color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      icon: Icon(Icons.filter_list_rounded),
      onPressed: (){
        
         Navigator.of(context).push(PageRouteBuilder(
            opaque: true,
            pageBuilder: (BuildContext context, _, __) => BuildFilterParamsExplorerWidget(),
          ));
       
      },
    );

  }

}




class EditHomeButton extends StatelessWidget{

  final prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      iconSize: 26.0,
      color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      icon: Icon(Icons.auto_fix_high),
      onPressed: (){

        prefs.isNotAds 
          ? getListPersonalizeTops(context) 
          : Navigator.pushNamed(context, '/Premium');
        
      },
    );

  }

  void getListPersonalizeTops(BuildContext context){


    Navigator.of(context).push(PageRouteBuilder(
      opaque: true,
      pageBuilder: (BuildContext context, _, __) => ListPersonalizedTopsWidget(),
    ));

  }

}