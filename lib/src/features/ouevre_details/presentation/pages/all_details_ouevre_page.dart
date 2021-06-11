import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_controller_tab_view_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/all_details_header_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

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
  bool isExpandedHeight = false;

  bool isExtended = false;


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

      case 'movie': return 5;
        break;

      case 'tv': return 6;
        break;

      case 'anime': return 6;
        break;    

      default: return 6;
    }
  }

  List<Tab> _getListTabs(BuildContext context){

    final List<Tab> detailsMovieTabs = <Tab>[
    Tab(key: ValueKey(0), text: AppLocalizations.of(context).translate("info"),),
    Tab(key: ValueKey(1), text: AppLocalizations.of(context).translate("casting")),
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("trailer")),
    Tab(key: ValueKey(3), text: AppLocalizations.of(context).translate("review")),
    Tab(key: ValueKey(4), text: AppLocalizations.of(context).translate("video_review")),
    // Tab(key: ValueKey(5), text: AppLocalizations.of(context).translate("similar")),
    // Tab(key: ValueKey(6), text: AppLocalizations.of(context).translate("recommedation")),
  ];

  final List<Tab> detailsSerieTabs = <Tab>[
    Tab(key: ValueKey(0), text: AppLocalizations.of(context).translate("info"),),
    Tab(key: ValueKey(1), text: AppLocalizations.of(context).translate("season")),
    Tab(key: ValueKey(2), text: AppLocalizations.of(context).translate("video_review")),
    Tab(key: ValueKey(3), text: AppLocalizations.of(context).translate("casting")),
    Tab(key: ValueKey(4), text: AppLocalizations.of(context).translate("trailer")),
    Tab(key: ValueKey(5), text: AppLocalizations.of(context).translate("review")),
    // Tab(key: ValueKey(6), text: AppLocalizations.of(context).translate("similar")),
    // Tab(key: ValueKey(7), text: AppLocalizations.of(context).translate("recommedation")),
  ];

  final List<Tab> detailsAnimeTabs = <Tab>[
    Tab(key: ValueKey(0), text:AppLocalizations.of(context).translate("info"),),
    Tab(key: ValueKey(1), text:AppLocalizations.of(context).translate("season")),
    Tab(key: ValueKey(2), text:AppLocalizations.of(context).translate("video_review")),
    Tab(key: ValueKey(3), text:AppLocalizations.of(context).translate("casting")),
    Tab(key: ValueKey(4), text:AppLocalizations.of(context).translate("trailer")),
    Tab(key: ValueKey(5), text:AppLocalizations.of(context).translate("review")),
    // Tab(key: ValueKey(6), text:AppLocalizations.of(context).translate("similar")),
    // Tab(key: ValueKey(7), text:AppLocalizations.of(context).translate("recommedation")),
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
    final int id = widget.data['id'];
    final String type = widget.data['type'];

    return Scaffold(
      body: DefaultTabController(
        length: _getListTabs(context).length,
        child: _createHeaderSliverBuilder()
      ),
      floatingActionButton: BlocProvider<OuevreDetailsBloc>(
          create: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: FABAddToList(type: type, id: id, isScrolling: isExtended,),
        ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ); 
        
    
  }

  

  Widget _createHeaderSliverBuilder(){
    final int id = widget.data['id'];
    final String type = widget.data['type'];
    final String title = widget.data['title'];

    // return CustomScrollView(
    //         controller: _scrollViewController,
    //         physics: const BouncingScrollPhysics(),
    //         slivers: [
    //           _createSliverAppBar(),
    //           SliverFillRemaining(
    //             fillOverscroll: false,
    //             hasScrollBody: true,
    //             child: TabBarView(       
    //             physics: NeverScrollableScrollPhysics(),    
    //             controller: _tabController,
    //             children: _getListTabs(context).map((Tab tab) {
    //               return AllDetailsTabViewControllerWidget(idTab: tab.key, id: id, type: type, title: title,);
    //             }).toList(),
    //         ),
    //           ),
    //         ],
            
    //   );

    // return  NotificationListener<OverscrollIndicatorNotification>(
    //       onNotification: (overscroll) {
    //         overscroll.disallowGlow();
    //         return false;
    //       },
    //       child: NestedScrollView(
    //         controller: _scrollViewController,
    //         // physics: const BouncingScrollPhysics(),
    //         headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
    //           return <Widget>[
    //             _createSliverAppBar(innerBoxScrolled),
    //           ];
    //         },
    //         body: TabBarView(       
    //       // physics: NeverScrollableScrollPhysics(),    
    //       controller: _tabController,
    //       children: _getListTabs(context).map((Tab tab) {
    //         return AllDetailsTabViewControllerWidget(idTab: tab.key, id: id, type: type, title: title,);
    //       }).toList(),
    //     ),
    //   ),
    // );

    return   NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
            
            if (notification is ScrollStartNotification) {
              // Handle your desired action on scroll start here.
              setState(() {
                isExtended = !isExtended;
              });
            }

            
            if (notification is UserScrollNotification) {
              // Handle your desired action on scroll start here.
              setState(() {
                isExtended = false;
              });
            }

           

            if (notification is ScrollEndNotification) {
              // Handle your desired action on scroll start here.
              setState(() {
                isExtended = true;
              });
            }

            // Returning null (or false) to
            // "allow the notification to continue to be dispatched to further ancestors".
            return false;
          },
      child: NestedScrollView(
      controller: _scrollViewController,
      // physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
        return <Widget>[
          _createSliverAppBar(innerBoxScrolled),
        ];
      },
      body: TabBarView(       
    // physics: NeverScrollableScrollPhysics(),    
    controller: _tabController,
    children: _getListTabs(context).map((Tab tab) {
      return AllDetailsTabViewControllerWidget(idTab: tab.key, id: id, type: type, title: title,);
    }).toList(),
        ),
      )
    );
  }

  Widget _createSliverAppBar(bool innerBoxScrolled){

    final int id = widget.data['id'];
    final String type = widget.data['type'];
    
    

    return SliverAppBar(
        leading: AppBarButtonBack(),
        pinned: true,
        forceElevated: innerBoxScrolled,
        stretch: true,
        elevation: 10.0,
        expandedHeight: 280,
        flexibleSpace: BlocProvider<OuevreDetailsBloc>(
          create: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsHeaderInfo(id: id, type: type),
        ),

        // flexibleSpace: FlexibleSpaceBar(
        // stretchModes: <StretchMode>[
        //   StretchMode.zoomBackground,
        //   // StretchMode.blurBackground,
        //   // StretchMode.fadeTitle
        // ],       
        // // collapseMode: CollapseMode.parallax,
        // background:Image(image: AssetImage('assets/poster_placeholder.png'),fit: BoxFit.cover,) ,
        // centerTitle: true,
        // titlePadding: EdgeInsets.only(bottom: 65.0),
        // title: Text('Title')
        // ),
        bottom: _tabBar(),
        
    );
  }


  Widget _tabBar(){
    List<Shadow> shadowBlack = [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(1.0, 1.0))];
    List<Shadow> shadowWhite = [Shadow(blurRadius: 1.0, color:  Colors.white, offset: Offset(0.3, 0.3))];

    return TabBar(
      labelColor: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
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
      // indicator: MD2Indicator(
      //   indicatorHeight: 4, 
      //   indicatorColor: Colors.pinkAccent[400], 
      //   indicatorSize: MD2IndicatorSize.tiny
      // ),
      indicator: MaterialIndicator (
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        bottomLeftRadius: 2,
        bottomRightRadius: 2,
        topLeftRadius: 2,
        topRightRadius: 2,
        height: 3,
        horizontalPadding: 20,
        
        tabPosition: TabPosition.bottom
      ),
      isScrollable: true,
      tabs: _getListTabs(context),
      controller: _tabController,
    );
  }

  

  
   
}



class FABAddToList extends StatefulWidget {

  final int id;
  final String type;
  final bool isScrolling;

  FABAddToList({
    this.id,
    this.type,
    this.isScrolling
  });

  @override
  _FABAddToListState createState() => _FABAddToListState();
}

class _FABAddToListState extends State<FABAddToList> {
  
  Preferences prefs = Preferences();


   @override
  void initState() {
    BlocProvider.of<OuevreDetailsBloc>(context)
    ..add(GetDetailsOuevre(widget.id, widget.type));
    super.initState();
  } 


  
  
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
      builder: (context, state) {
        
        if(state is Empty){

          return SizedBox.shrink();
          

        }else if(state is Loading){
          
          return SizedBox.shrink();
            

        }else if(state is LoadedMovie){

          return buildFAB(
            context: context,
            title: AppLocalizations.of(context).translate("fab_label_add_movie"),
            onPressed: (){

              return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: state.movie,
              type: state.movie.type,
              objectType: ConstantsTypeObject.movieDetailsEntity
            ).showBottomModal();

            }
          );

        }else if(state is LoadedSerie){

          return buildFAB(
            context: context,
            title: AppLocalizations.of(context).translate("fab_label_add_serie"),
            onPressed: (){

            return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: state.serie,
              type: state.serie.type,
              objectType: ConstantsTypeObject.serieDetailsEntity
            ).showBottomModal();

            }
          );

        }else if(state is LoadedAnime){

          return buildFAB(
            context: context,
            title: AppLocalizations.of(context).translate("fab_label_add_anime"),
            onPressed: (){

            return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: state.anime,
              type: state.anime.type,
              objectType: ConstantsTypeObject.animeDetailsEntity
            ).showBottomModal();

            }
          );

        }else if(state is Error){
          
          return Center(
            child: Text(state.message),
          );

        }

        return Center(
            child: Text('something Error'),
          );

      },
    );

    
  }


  Widget buildFAB({BuildContext context, String title, Function() onPressed }){

    return FloatingActionButton.extended(
      isExtended: !widget.isScrolling,
      elevation: 1.0,
      backgroundColor: getBackgroundColorItemTheme(),
      onPressed: onPressed,
      label: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) =>
        FadeTransition(
          opacity: animation,
          child: SizeTransition(
            child: child,
            sizeFactor: animation,
            axis: Axis.horizontal,
          ),
        ) ,
        child: widget.isScrolling 
        ? Icon(
          Icons.add,
          size: 30,
          color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        ) 
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Icon(
                Icons.add_circle,
                size: 26,
                color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
                ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
                fontWeight: FontWeight.w800
              ),
            )
          ],
        ),
      )
    );

  }

   
}


