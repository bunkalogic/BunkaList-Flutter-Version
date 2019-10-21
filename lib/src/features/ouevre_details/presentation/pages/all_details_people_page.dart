import 'package:flutter/material.dart';

import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_person_tab_controller.dart';


class AllDetailsPeoplePage extends StatefulWidget {

  final int data;

  const AllDetailsPeoplePage({Key key, @required this.data}) : super(key: key);

  @override
  _AllDetailsPeoplePageState createState() => _AllDetailsPeoplePageState();
}

class _AllDetailsPeoplePageState extends State<AllDetailsPeoplePage> with SingleTickerProviderStateMixin {


  TabController _tabController;

  final List<Tab> personTabs = <Tab>[
    Tab(key: ValueKey(0), text:'Info'),
    Tab(key: ValueKey(1), text:'Movies'),
    Tab(key: ValueKey(2), text:'Series TV'),
    Tab(key: ValueKey(3), text:'Anime'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: personTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarPeople(),
      body:  TabBarView(
        controller: _tabController,
        children: personTabs.map((Tab tab) {
          return AllDetailsTabPersonControllerWidget(idStatus: tab.key,);
        }).toList(),
      ),
    );
  }

  Widget _appBarPeople() {
    return AppBar(
      leading: AppBarButtonBack(),
      title: Text('Damian Lewis'),
      bottom: _tabBar(),
    );
  }

  Widget _tabBar(){
    return TabBar(
      labelColor: Colors.deepOrange,
      isScrollable: true,
      tabs: personTabs,
      controller: _tabController,
    );
  }
}