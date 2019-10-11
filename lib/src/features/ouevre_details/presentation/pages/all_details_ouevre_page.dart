import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_controller_tab_view_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_header_info_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/sliver_app_bar_delegate.dart';
import 'package:flutter/material.dart';


class AllDetailsOuevrePage extends StatefulWidget {

  final int data;

  AllDetailsOuevrePage({Key key, @required this.data}) : super(key: key);

  

  _AllDetailsOuevrePageState createState() => _AllDetailsOuevrePageState();
}


class _AllDetailsOuevrePageState extends State<AllDetailsOuevrePage> with SingleTickerProviderStateMixin {


  TabController _tabController;

  final List<Tab> detailsTabs = <Tab>[
    Tab(key: ValueKey(0), text:'Info' ),
    Tab(key: ValueKey(1), text:'Casting'),
    Tab(key: ValueKey(2), text:' Trailers'),
    Tab(key: ValueKey(3), text:'Review'),
    Tab(key: ValueKey(4), text:'Video Review'),
    Tab(key: ValueKey(5), text:'Similar'),
    Tab(key: ValueKey(6), text:'Recomendation'),
    Tab(key: ValueKey(7), text:' Season'), //si es una serie o anime
    Tab(key: ValueKey(8), text:' Opennings'), //si es un anime

  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: detailsTabs.length);
  }

  @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: detailsTabs.length,
        child: _creteHeaderSliverBuilder()
      ),
    ); 
        
    
  }

  Widget _creteHeaderSliverBuilder(){
    return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
            return <Widget>[
              _createSliverAppBar(),
              _createSliverPersistentHeader()
            ];
          },
          body: TabBarView(
        controller: _tabController,
        children: detailsTabs.map((Tab tab) {
          return AllDetailsTabViewControllerWidget(idStatus: tab.key);
        }).toList(),
      ),
    );
  }

  Widget _createSliverAppBar(){
    return SliverAppBar(
        snap: true,
        leading: AppBarButtonBack(),
        floating: true,
        pinned: true,
        expandedHeight: 350.0,
        flexibleSpace: AllDetailsHeaderInfo(),
        
    );
  }



  Widget _createSliverPersistentHeader() {

    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(_tabBar()),
      pinned: true,
    );

  }  


  Widget _tabBar(){
    return TabBar(
      isScrollable: true,
      tabs: detailsTabs,
      controller: _tabController,
    );
  }

  
   
}