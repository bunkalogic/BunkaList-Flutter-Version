import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_controller_tab_view_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_header_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';


class AllDetailsOuevrePage extends StatefulWidget {

  final Map data;

  AllDetailsOuevrePage({@required this.data});

  

  _AllDetailsOuevrePageState createState() => _AllDetailsOuevrePageState();
}


class _AllDetailsOuevrePageState extends State<AllDetailsOuevrePage> with SingleTickerProviderStateMixin {


  TabController _tabController;

  final List<Tab> detailsTabs = <Tab>[
    Tab(key: ValueKey(0), text:'Info', ),
    Tab(key: ValueKey(1), text:'Casting'),
    Tab(key: ValueKey(2), text:'Trailers'),
    Tab(key: ValueKey(3), text:'Review'),
    Tab(key: ValueKey(4), text:'Video Review'),
    Tab(key: ValueKey(5), text:'Similar'),
    Tab(key: ValueKey(6), text:'Recomendation'),
    Tab(key: ValueKey(7), text:' Season'), //si es una serie o anime
    Tab(key: ValueKey(8), text:' Opennings'), //si es un anime
  ];

  final List<Tab> detailsSerieTabs = <Tab>[
    Tab(key: ValueKey(0), text:'Info', ),
    Tab(key: ValueKey(1), text:'Casting'),
    Tab(key: ValueKey(2), text:'Trailers'),
    Tab(key: ValueKey(3), text:'Review'),
    Tab(key: ValueKey(4), text:'Video Review'),
    Tab(key: ValueKey(5), text:'Similar'),
    Tab(key: ValueKey(6), text:'Recomendation'),
    Tab(key: ValueKey(7), text:' Season'), //si es una serie o anime
  ];

  final List<Tab> detailsAnimeTabs = <Tab>[
    Tab(key: ValueKey(0), text:'Info', ),
    Tab(key: ValueKey(1), text:'Casting'),
    Tab(key: ValueKey(2), text:'Trailers'),
    Tab(key: ValueKey(3), text:'Review'),
    Tab(key: ValueKey(4), text:'Video Review'),
    Tab(key: ValueKey(5), text:'Similar'),
    Tab(key: ValueKey(6), text:'Recomendation'),
    Tab(key: ValueKey(7), text:' Season'), //si es una serie o anime
    Tab(key: ValueKey(8), text:' Opennings'), //si es un anime
  ];

  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = TabController(vsync: this, length: detailsTabs.length);
  }

  @override
  void dispose() {
    _scrollViewController.dispose(); 
    _tabController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: detailsTabs.length,
        child: _createHeaderSliverBuilder()
      ),
    ); 
        
    
  }

  Widget _createHeaderSliverBuilder(){
    final int id = widget.data['id'];
    final String type = widget.data['type'];


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
        children: detailsTabs.map((Tab tab) {
          return AllDetailsTabViewControllerWidget(idStatus: tab.key, id: id, type: type,);
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
        expandedHeight: 300.0,
        flexibleSpace: new BlocProvider<OuevreDetailsBloc>(
          builder: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsHeaderInfo(id: id, type: type),
        ),
        bottom: _tabBar(),
        
    );
  }


  Widget _tabBar(){
    return TabBar(
      labelColor: Colors.deepOrangeAccent[400],
      unselectedLabelColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w700,
        shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(1.0, 1.0))]
      ),
      isScrollable: true,
      tabs: detailsTabs,
      controller: _tabController,
    );
  }

  
   
}