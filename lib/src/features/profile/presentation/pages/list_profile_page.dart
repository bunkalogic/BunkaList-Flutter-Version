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
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("status_pause"),     icon: Icon(Icons.pause_circle_filled, color: Colors.deepOrangeAccent[400]),),
    Tab(key: ValueKey(3), text: AppLocalizations.of(context).translate("status_dropped"),   icon: Icon(Icons.remove_circle, color: Colors.redAccent[400],),),
    Tab(key: ValueKey(4), text: AppLocalizations.of(context).translate("status_wishlist"),  icon: Icon(Icons.add_circle, color: Colors.deepPurpleAccent[400],),),

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
      // title: _appBarTitle(),
      title: _buttonsTypeListMaterial(context),
      bottom: _tabBar(),
      leading: AppBarButtonBack(),
    );
  }




  Widget _buttonsTypeListMaterial(BuildContext context){ 
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        widget.data == 0 
        ? bottonActive(context, AppLocalizations.of(context).translate("movies"),  Colors.redAccent[400], 0)
        : bottonDesactive(context, AppLocalizations.of(context).translate("movies"),  Colors.redAccent[400], 0),
        SizedBox(width: 10.0,),
        widget.data == 1 
        ? bottonActive(context, AppLocalizations.of(context).translate("series"),  Colors.greenAccent[400], 1)
        : bottonDesactive(context, AppLocalizations.of(context).translate("series"),  Colors.greenAccent[400], 1), 
        
        SizedBox(width: 10.0,),
        widget.data == 2 
        ? bottonActive(context, AppLocalizations.of(context).translate("animes"),  Colors.lightBlueAccent[400], 2)
        : bottonDesactive(context, AppLocalizations.of(context).translate("animes"),  Colors.lightBlueAccent[400], 2),
        
      ],
    );
  }

  Widget bottonActive(BuildContext context,String title, Color color, int typeActive){

    return Flexible(
        // ignore: deprecated_member_use
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title,
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
          ),
          onPressed: (){
            
            Navigator.pushReplacementNamed(context, '/ListProfile', arguments: typeActive);
            
          },
      ),
    );


  }


  Widget bottonDesactive(BuildContext context,String title, Color color, int typeDesactive){

    return Flexible(
        // ignore: deprecated_member_use
        child: OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderSide: BorderSide(color: color, width: 1.0),
          
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title,
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
          ),
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/ListProfile', arguments: typeDesactive);
          },
      ),
    );


  }

 

  TabBarView buildTabBarView(BuildContext context) {

    return TabBarView(
      children: _getListTabs(context).map((Tab tab) {
        return new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
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
        indicatorColor: prefs.whatModeIs ?  Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], 
        indicatorSize: MD2IndicatorSize.normal
      ),
    );
  }

  
}