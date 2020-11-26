import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_controller_tab_view_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_header_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import '../../../../../injection_container.dart';


class AllDetailsOuevrePage extends StatefulWidget {

  final Map data;

  AllDetailsOuevrePage({@required this.data});

  

  _AllDetailsOuevrePageState createState() => _AllDetailsOuevrePageState();
}


class _AllDetailsOuevrePageState extends State<AllDetailsOuevrePage> with SingleTickerProviderStateMixin {


  TabController _tabController;
  ScrollController _scrollViewController;
  Preferences prefs = Preferences();

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = TabController(vsync: this, length: getTotalTabs());
    
  }

  @override
  void dispose() {
    _scrollViewController.dispose(); 
    _tabController.dispose();
    super.dispose();
  }

  int getTotalTabs(){
    final String type = widget.data['type'];

    switch(type){

      case 'movie': return 7;
        break;

      case 'tv': return 8;
        break;

      case 'anime': return 8;
        break;    

      default: return 8;
    }
  }

  List<Tab> _getListTabs(BuildContext context){

    final List<Tab> detailsMovieTabs = <Tab>[
    Tab(key: ValueKey(0), text: AppLocalizations.of(context).translate("info"),),
    Tab(key: ValueKey(1), text: AppLocalizations.of(context).translate("casting")),
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("trailer")),
    Tab(key: ValueKey(3), text: AppLocalizations.of(context).translate("review")),
    Tab(key: ValueKey(4), text: AppLocalizations.of(context).translate("video_review")),
    Tab(key: ValueKey(5), text: AppLocalizations.of(context).translate("similar")),
    Tab(key: ValueKey(6), text: AppLocalizations.of(context).translate("recommedation")),
  ];

  final List<Tab> detailsSerieTabs = <Tab>[
    Tab(key: ValueKey(0), text: AppLocalizations.of(context).translate("info"),),
    Tab(key: ValueKey(1), text: AppLocalizations.of(context).translate("season")),
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("video_review")),
    Tab(key: ValueKey(3), text: AppLocalizations.of(context).translate("casting")),
    Tab(key: ValueKey(4), text: AppLocalizations.of(context).translate("trailer")),
    Tab(key: ValueKey(5), text: AppLocalizations.of(context).translate("review")),
    Tab(key: ValueKey(6), text: AppLocalizations.of(context).translate("similar")),
    Tab(key: ValueKey(7), text: AppLocalizations.of(context).translate("recommedation")),
  ];

  final List<Tab> detailsAnimeTabs = <Tab>[
    Tab(key: ValueKey(0), text:AppLocalizations.of(context).translate("info"),),
    Tab(key: ValueKey(1), text:AppLocalizations.of(context).translate("season")),
    Tab(key: ValueKey(2), text:AppLocalizations.of(context).translate("video_review")),
    Tab(key: ValueKey(3), text:AppLocalizations.of(context).translate("casting")),
    Tab(key: ValueKey(4), text:AppLocalizations.of(context).translate("trailer")),
    Tab(key: ValueKey(5), text:AppLocalizations.of(context).translate("review")),
    Tab(key: ValueKey(6), text:AppLocalizations.of(context).translate("similar")),
    Tab(key: ValueKey(7), text:AppLocalizations.of(context).translate("recommedation")),
    //Tab(key: ValueKey(8), text:'Opennings'), //si es un anime
  ];



    final String type = widget.data['type'];

    switch(type){

      case 'movie': return detailsMovieTabs;
        break;

      case 'tv': return detailsSerieTabs;
        break;

      case 'anime': return detailsAnimeTabs;
        break;    

      default: return detailsMovieTabs;
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _getListTabs(context).length,
        child: _createHeaderSliverBuilder()
      ),
    ); 
        
    
  }

  Widget _createHeaderSliverBuilder(){
    final int id = widget.data['id'];
    final String type = widget.data['type'];
    final String title = widget.data['title'];


    return NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
            return <Widget>[
              _createSliverAppBar(innerBoxScrolled),
            ];
          },
          body: TabBarView(   
        physics: NeverScrollableScrollPhysics(),    
        controller: _tabController,
        children: _getListTabs(context).map((Tab tab) {
          return AllDetailsTabViewControllerWidget(idTab: tab.key, id: id, type: type, title: title,);
        }).toList(),
      ),
    );
  }

  Widget _createSliverAppBar(bool innerBoxScrolled){

    final int id = widget.data['id'];
    final String type = widget.data['type'];
    

    return SliverAppBar(
        leading: AppBarButtonBack(),
        pinned: true,
        floating: false,
        forceElevated: innerBoxScrolled,
        expandedHeight: MediaQuery.of(context).size.height / 2.5,
        // expandedHeight: 320.0,
        flexibleSpace: new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsHeaderInfo(id: id, type: type),
        ),
        bottom: _tabBar(),
        
    );
  }


  Widget _tabBar(){
    List<Shadow> shadowBlack = [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(1.0, 1.0))];
    List<Shadow> shadowWhite = [Shadow(blurRadius: 1.0, color:  Colors.white, offset: Offset(0.3, 0.3))];

    return TabBar(
      labelColor: Colors.pinkAccent[400],
      unselectedLabelColor: prefs.whatModeIs ? Colors.grey[400] : Colors.grey[800],
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w600,
        shadows: prefs.whatModeIs ? shadowBlack : shadowWhite,
      ),
      labelStyle: TextStyle(
        fontSize: 16.0, 
        fontWeight: FontWeight.w700,
        shadows: prefs.whatModeIs ? shadowBlack : shadowWhite,
      ),
      indicator: MD2Indicator(
        indicatorHeight: 3, 
        indicatorColor: Colors.pinkAccent[400], 
        indicatorSize: MD2IndicatorSize.normal
      ),
      isScrollable: true,
      tabs: _getListTabs(context),
      controller: _tabController,
    );
  }

  

  
   
}