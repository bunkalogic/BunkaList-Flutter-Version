import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/theme/app_themes.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/list_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class ListProfilePage extends StatefulWidget {

  final int data;


  ListProfilePage({Key key, @required this.data}) : super(key: key);

  _ListProfilePageState createState() => _ListProfilePageState();
}

class _ListProfilePageState extends State<ListProfilePage> with SingleTickerProviderStateMixin {

  final prefs = new Preferences();

  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(text:'Completed', icon: Icon(Icons.check_circle, color: Colors.green,) ,),
    Tab(text:'Watching',  icon: Icon(Icons.play_circle_filled, color: Colors.blue, ),),
    Tab(text:'On Pause',  icon: Icon(Icons.pause_circle_filled, color: Colors.orange),),
    Tab(text:'Dropped',   icon: Icon(Icons.remove_circle, color: Colors.redAccent,),),
    Tab(text:'WhishList', icon: Icon(Icons.add_circle, color: Colors.purple,),),

  ];



  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

  /**
   * TODO: crear los design de los item de cada status:
   * * - watching 
   * * - onPause & Dropped (comparten design)
   * * - WhishList
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(),
        bottom: _tabBar(),
        leading: AppBarButtonBack(),
        ),
      body:  TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return ListTabProfileWidget();
        }).toList(),
      ),  
    );
  }

  Widget _appBarTitle(){
    switch(widget.data){

      case 0: return Text('List Movies');
      case 1: return Text('List Series TV');
      case 2: return Text('List Anime');

      default: return Text('List Movies');
    }
  }

  Widget _tabBar() {
    return TabBar(
      isScrollable: true,
      tabs: myTabs,
      controller: _tabController,
    );
  }
}