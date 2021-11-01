import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/last_added__stacked_cards_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/last_added_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class TabBarRecentAddedToListsWidget extends StatefulWidget {
  TabBarRecentAddedToListsWidget({Key key}) : super(key: key);

  @override
  _TabBarRecentAddedToListsWidgetState createState() => _TabBarRecentAddedToListsWidgetState();
}

class _TabBarRecentAddedToListsWidgetState extends State<TabBarRecentAddedToListsWidget> with SingleTickerProviderStateMixin {
  

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
     return Column(
      children: [
        _titleScrollSection(AppLocalizations.of(context).translate("label_history_list")),
        _tabBar(),
        _buildBodyTab()
      ],
    );
  }

  Widget _titleScrollSection(String title) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,),
            ),
          ),
        ),
        Spacer(),
        _buttonChangedDesign()
      ],
    );
  }

  Widget _buttonChangedDesign(){
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        padding: EdgeInsets.only(right: 12.0),
        icon: Icon(
          prefs.currentDesignHistory ? Icons.amp_stories : Icons.horizontal_split_rounded,
          color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
          size: 34,
        ), 
        onPressed: (){
          
          if(prefs.isNotAds){
            prefs.currentDesignHistory = !prefs.currentDesignHistory;
            setState(() {});
          }else{
            Navigator.pushNamed(context, '/Premium');
          }
          
        }
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      height: 45.0,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
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
      ),
    );
  }

  Widget _buildBodyTab(){
    return Container(
      height: 240,
      child: TabBarView(
        controller: _tabController,
        children: [
          new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: !prefs.currentDesignHistory ? LastAddedItem(status: ListProfileQuery.Last, type: 'movie',) : LastAddedItemStackedCardsWidget(status: ListProfileQuery.Last, type: 'movie',),
          ),
           new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: !prefs.currentDesignHistory ? LastAddedItem(status: ListProfileQuery.Last, type: 'tv',) : LastAddedItemStackedCardsWidget(status: ListProfileQuery.Last, type: 'tv',),
          ),
           new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: !prefs.currentDesignHistory ? LastAddedItem(status: ListProfileQuery.Last, type: 'anime',) : LastAddedItemStackedCardsWidget(status: ListProfileQuery.Last, type: 'anime',),
          ),
        ]
      ),
    );
  }
}
