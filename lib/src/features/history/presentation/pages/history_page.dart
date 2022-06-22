import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/last_added_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import '../../../../../injection_container.dart';



class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  int _activeTabIndex;
  Preferences prefs = Preferences();

  bool isActiveTab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(_setActiveTabIndex);
    
  }

  void _setActiveTabIndex() {
  _activeTabIndex = _tabController.index;

  isActiveTab = _activeTabIndex == 0;

  setState(() {});
  }
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        backgroundColor: getBackgroundColorTheme(),
        flexibleSpace: _tabBar(),
        elevation: 4.0,
      ),
      body: _buildBodyTab(),
    );


    
  }


  Widget _tabBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,  
      children: [
        TabBar(
          tabs: [
            Tab(text: AppLocalizations.of(context).translate("movies"),),
            Tab(text: AppLocalizations.of(context).translate("series"),),
            Tab(text: AppLocalizations.of(context).translate("animes"),),
          ],
          controller: _tabController,
          indicator: MD2Indicator(
            indicatorHeight: 3, 
            indicatorColor: prefs.whatModeIs ?  Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
            indicatorSize: MD2IndicatorSize.normal
          ),
        ),
      ],
    );
  }

  Widget _buildBodyTab(){
    return TabBarView(
      controller: _tabController,
      children: [
        new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child: LastAddedItem(status: ListProfileQuery.AllOrderDate, type: 'movie',),
        ),
         new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child: LastAddedItem(status: ListProfileQuery.AllOrderDate, type: 'tv',),
        ),
         new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child:  LastAddedItem(status: ListProfileQuery.AllOrderDate, type: 'anime',),
        ),
      ]
    );
  }
}