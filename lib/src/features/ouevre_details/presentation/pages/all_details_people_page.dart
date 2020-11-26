import 'package:flutter/material.dart';

import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_person_tab_controller.dart';


class AllDetailsPeoplePage extends StatefulWidget {

  final Map data;

  const AllDetailsPeoplePage({ @required this.data});

  @override
  _AllDetailsPeoplePageState createState() => _AllDetailsPeoplePageState();
}

class _AllDetailsPeoplePageState extends State<AllDetailsPeoplePage> with SingleTickerProviderStateMixin {


  TabController _tabController;

  final List<Tab> personTabs = <Tab>[
    Tab(key: ValueKey(0), text:'Info'),
    Tab(key: ValueKey(1), text:'Cast'),
    Tab(key: ValueKey(2), text:'Crew'),
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
          return AllDetailsTabPersonControllerWidget(idStatus: tab.key, idCast: widget.data['id'],);
        }).toList(),
      ),
    );
  }

  Widget _appBarPeople() {
    return AppBar(
      leading: AppBarButtonBack(),
      title: Text(widget.data['name']),
      bottom: _tabBar(),
    );
  }

  Widget _tabBar(){
    return TabBar(
      labelColor: Colors.pink,
      isScrollable: true,
      tabs: personTabs,
      controller: _tabController,
    );
  }
}