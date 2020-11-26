import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/bottom_modal_filter.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/build_bottom_modal_filter_completed.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/list_profile_widget.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';


class ListProfilePage extends StatefulWidget {

  final int data;


  ListProfilePage({Key key, @required this.data}) : super(key: key);

  _ListProfilePageState createState() => _ListProfilePageState();
}

class _ListProfilePageState extends State<ListProfilePage> with SingleTickerProviderStateMixin {

  final prefs = new Preferences();

  TabController _tabController;

  int _activeTabIndex;

  // ListProfileQuery typeListCompl = ListProfileQuery.Completed;

  bool isActiveTab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 5);

    _tabController.addListener(_setActiveTabIndex);
    
  }

  void _setActiveTabIndex() {
  _activeTabIndex = _tabController.index;

  isActiveTab = _activeTabIndex == 0;

  setState(() {});
  }

  @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

   List<Tab> _getListTabs(BuildContext context){

    final List<Tab> myTabs = <Tab>[
    Tab(key: ValueKey(0), text: AppLocalizations.of(context).translate("status_completed"), icon: Icon(Icons.check_circle, color: Colors.greenAccent[400],) ,),
    Tab(key: ValueKey(1), text: AppLocalizations.of(context).translate("status_watching"),  icon: Icon(Icons.play_circle_filled, color: Colors.blueAccent[400], ),),
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("status_pause"),     icon: Icon(Icons.pause_circle_filled, color: Colors.orangeAccent[400]),),
    Tab(key: ValueKey(3), text: AppLocalizations.of(context).translate("status_dropped"),   icon: Icon(Icons.remove_circle, color: Colors.redAccent[400],),),
    Tab(key: ValueKey(4), text: AppLocalizations.of(context).translate("status_wishlist"),  icon: Icon(Icons.add_circle, color: Colors.purpleAccent[400],),),

    ];

    return myTabs;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:  buildTabBarView(context),  
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: _appBarTitle(),
      bottom: _tabBar(),
      leading: AppBarButtonBack(),
    );
  }

 

  TabBarView buildTabBarView(BuildContext context) {
    return TabBarView(
      children: _getListTabs(context).map((Tab tab) {
        return new BlocProvider<GetListsBloc>(
          builder: (_) => serviceLocator<GetListsBloc>(),
          child: ListTabProfileWidget(idStatus: tab.key, type: _getTypeName(),),
        );
        
      }).toList(),
      controller: _tabController,
    );
  }

 

  String _getTypeName(){
    switch(widget.data){
      
      case 0: return 'movie';

      case 1: return 'tv';

      case 2: return 'anime';

      default: return 'movie';
    }
  }

  Widget _appBarTitle(){
    switch(widget.data){

      case 0: return Text(AppLocalizations.of(context).translate("list_movies"));
      case 1: return Text(AppLocalizations.of(context).translate("list_series"));
      case 2: return Text(AppLocalizations.of(context).translate("list_animes"));

      default: return Text(AppLocalizations.of(context).translate("list_movies"));
    }
  }

  Widget _tabBar() {
    return TabBar(
      isScrollable: true,
      tabs: _getListTabs(context),
      controller: _tabController,
      indicator: MD2Indicator(
        indicatorHeight: 3, 
        indicatorColor: Colors.pinkAccent[400], 
        indicatorSize: MD2IndicatorSize.normal
      ),
    );
  }

  Color _getBackgroundColorTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false){
      return Colors.blueGrey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs == true){
      return Colors.grey[900];
    }
    else{
      return Colors.grey[100];
    }
  }
}