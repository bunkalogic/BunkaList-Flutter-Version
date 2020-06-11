import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class ListFavoriteProfilePage extends StatefulWidget {
  ListFavoriteProfilePage({Key key}) : super(key: key);

  @override
  _ListFavoriteProfilePageState createState() => _ListFavoriteProfilePageState();
}

class _ListFavoriteProfilePageState extends State<ListFavoriteProfilePage> with SingleTickerProviderStateMixin{
  
  final prefs = new Preferences();

  TabController _tabController;

  

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   _tabController = TabController(vsync: this, length: _getListTabs(context).length);
    // });
    
  }

  @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

   List<Tab> _getListTabs(BuildContext context){

    final List<Tab> myTabs = <Tab>[
    Tab(key: ValueKey(0), text: AppLocalizations.of(context).translate("list_movies"),),
    Tab(key: ValueKey(1), text: AppLocalizations.of(context).translate("list_series"),),
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("list_animes"),),

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
      title: Text("Your Favorites Ouevres"),
      bottom: _tabBar(),
      leading: AppBarButtonBack(),
      );
  }

  TabBarView buildTabBarView(BuildContext context) {
    return TabBarView(
      children: _getListTabs(context).map((Tab tab) {
        // return new BlocProvider<GetListsBloc>(
        //   builder: (_) => serviceLocator<GetListsBloc>(),
        //   child: ListTabProfileWidget(idStatus: tab.key, type: _getTypeName(),),
        // );

        return Center(child: Text("${tab.text}"));
        
      }).toList(),
      controller: _tabController,
    );
  }

  Widget _tabBar() {
    return TabBar(
      isScrollable: true,
      tabs: _getListTabs(context),
      controller: _tabController,
      indicator: MD2Indicator(
        indicatorHeight: 3, 
        indicatorColor: Colors.deepOrangeAccent[400], 
        indicatorSize: MD2IndicatorSize.normal
      ),
    );
  }

}