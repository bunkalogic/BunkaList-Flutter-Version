import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/list_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListProfilePage extends StatefulWidget {

  final int data;


  ListProfilePage({Key key, @required this.data}) : super(key: key);

  _ListProfilePageState createState() => _ListProfilePageState();
}

class _ListProfilePageState extends State<ListProfilePage> with SingleTickerProviderStateMixin {

  final prefs = new Preferences();

  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(key: ValueKey(0) , text:'Completed', icon: Icon(Icons.check_circle, color: Colors.green,) ,),
    Tab(key: ValueKey(1), text:'Watching',  icon: Icon(Icons.play_circle_filled, color: Colors.blue, ),),
    Tab(key: ValueKey(2), text:'On Pause',  icon: Icon(Icons.pause_circle_filled, color: Colors.orange),),
    Tab(key: ValueKey(3), text:'Dropped',   icon: Icon(Icons.remove_circle, color: Colors.redAccent,),),
    Tab(key: ValueKey(4), text:'WhishList', icon: Icon(Icons.add_circle, color: Colors.purple,),),

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
          return new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: ListTabProfileWidget(idStatus: tab.key, type: _getTypeName(),),
          );
          
        }).toList(),
      ),  
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