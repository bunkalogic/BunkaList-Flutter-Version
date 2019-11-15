import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/utils/get_top_id_from_key.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_series_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';


class TopsListPage extends StatefulWidget {
  
  
  final String data;


  TopsListPage({
    Key key,
    @required this.data
  }) : super(key: key);

  @override
  _TopsListPageState createState() => _TopsListPageState();
}

class _TopsListPageState extends State<TopsListPage> with SingleTickerProviderStateMixin {
  //? Variables
  bool changeDesign = false;
  TabController _tabController;
  


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 18 );
  }

  @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _createAppBar(context, _whatTypeIs(context)),
      body:   _changedListDesign(context),
    );
  }

  Widget _createAppBar(BuildContext context, String title) {
    
    return AppBar(
      title: Text(title),
      leading: AppBarButtonBack(),
      bottom: _tabBar(context),
      actions: <Widget>[
        IconButton(
          icon: _changedIcon(),
          onPressed: (){
            if(!changeDesign){
              changeDesign = true;
              setState(() { });
            }else{
              changeDesign = false;
              setState(() { });
            }
          },
          )
      ],
    ); 
  }

  String _whatTypeIs(BuildContext context){
      switch(widget.data){
        
        case 'movies' : return AppLocalizations.of(context).translate('top_movies');
        break;

        case 'tv'     : return AppLocalizations.of(context).translate('top_series');
        break;

        case 'animes' : return AppLocalizations.of(context).translate('top_animes');
        break;

        default: return 'No type found';

      }
  }


  


  Widget _changedListDesign(BuildContext context) {

     
      if(!changeDesign){
        
        return TabBarView(
        controller: _tabController,
        children: _getTabs(context).map((Tab tab) {
          return _getGridViewList(GetTopIdFromKey().getTopId(tab.key));
        }).toList(),
       );

      }else {

        return TabBarView(
        controller: _tabController,
        children: _getTabs(context).map((Tab tab) {
          return _getCardViewList(GetTopIdFromKey().getTopId(tab.key));
        }).toList(),
       );

      }
      
      
  }

  Widget _changedIcon() {
     
      if(!changeDesign){
        return Icon(Icons.art_track, size: 32, );
      }else {
        return Icon(Icons.view_module, size: 32 ,);
      }
      
      
  }

  Widget _tabBar(BuildContext context) {
    return TabBar(
      labelColor: Colors.deepOrange,
      isScrollable: true,
      tabs: _getTabs(context),
      controller: _tabController,
      
    );
  }

  List<Tab> _getTabs(BuildContext context) {

  // movies tabs length  = 18
  final List<Tab> moviesTabs = <Tab>[
    Tab(key: ValueKey(Constants.topsMoviesPopularId), text: AppLocalizations.of(context).translate("movies_popular")),
    Tab(key: ValueKey(Constants.topsMoviesRatedId), text: AppLocalizations.of(context).translate("movies_rated")),
    Tab(key: ValueKey(Constants.topsMoviesUpcommingId), text: AppLocalizations.of(context).translate("movies_upcoming")),
    Tab(key: ValueKey(Constants.topsMoviesActionId), text: AppLocalizations.of(context).translate("movies_action")),
    Tab(key: ValueKey(Constants.topsMoviesAdventureId), text: AppLocalizations.of(context).translate("movies_adventure")),      
    Tab(key: ValueKey(Constants.topsMoviesComedyId), text: AppLocalizations.of(context).translate("movies_comedy")),
    Tab(key: ValueKey(Constants.topsMoviesWarId), text: AppLocalizations.of(context).translate("movies_war")),
    Tab(key: ValueKey(Constants.topsMoviesScienceFictionId), text: AppLocalizations.of(context).translate("movies_scifi")),
    Tab(key: ValueKey(Constants.topsMoviesCrimeId), text: AppLocalizations.of(context).translate("movies_crime")),
    Tab(key: ValueKey(Constants.topsMoviesDramaId), text: AppLocalizations.of(context).translate("movies_drama")),
    Tab(key: ValueKey(Constants.topsMoviesFantasyId), text: AppLocalizations.of(context).translate("movies_fantasy")),
    Tab(key: ValueKey(Constants.topsMoviesHistoryId), text: AppLocalizations.of(context).translate("movies_history")),
    Tab(key: ValueKey(Constants.topsAnimeMisteryId), text: AppLocalizations.of(context).translate("movies_mistery")),
    Tab(key: ValueKey(Constants.topsMoviesMusicalId), text: AppLocalizations.of(context).translate("movies_musical")),
    Tab(key: ValueKey(Constants.topsMoviesRomanceId), text: AppLocalizations.of(context).translate("movies_romance")),
    Tab(key: ValueKey(Constants.topsMoviesThillerId), text: AppLocalizations.of(context).translate("movies_thiller")),
    Tab(key: ValueKey(Constants.topsMoviesTerrorId), text: AppLocalizations.of(context).translate("movies_terror")),
    Tab(key: ValueKey(Constants.topsMoviesWesternId), text: AppLocalizations.of(context).translate("movies_western")),
    
    
  ];

  // series tabs length  = 18
  final List<Tab> seriesTabs = <Tab>[
    Tab(key: ValueKey(Constants.topsSeriesPopularId), text: AppLocalizations.of(context).translate("series_popular"           )),
    Tab(key: ValueKey(Constants.topsSeriesRatedId), text: AppLocalizations.of(context).translate("series_rated"             )),
    Tab(key: ValueKey(Constants.topsSeriesUpcommingId), text: AppLocalizations.of(context).translate("series_upcomming "        )),
    Tab(key: ValueKey(Constants.topsSeriesActAndAdvId), text: AppLocalizations.of(context).translate("series_act_and_adv"       )),
    Tab(key: ValueKey(Constants.topsSeriesComedyId), text: AppLocalizations.of(context).translate("series_comedy"            )),
    Tab(key: ValueKey(Constants.topsSeriesCrimenId), text: AppLocalizations.of(context).translate("series_crimen"            )),
    Tab(key: ValueKey(Constants.topsSeriesDocumentalId), text: AppLocalizations.of(context).translate("series_documental"        )),
    Tab(key: ValueKey(Constants.topsSeriesFamilyId), text: AppLocalizations.of(context).translate("series_family"            )),
    Tab(key: ValueKey(Constants.topsSeriesDramaId), text: AppLocalizations.of(context).translate("series_drama"             )),
    Tab(key: ValueKey(Constants.topsSeriesMisteryId), text: AppLocalizations.of(context).translate("series_mistery"           )),
    Tab(key: ValueKey(Constants.topsSeriesFantasyAndSciFiId), text: AppLocalizations.of(context).translate("series_fantasy_and_sci_fi")),
    Tab(key: ValueKey(Constants.topsSeriesWarAndPoliticsId), text: AppLocalizations.of(context).translate("series_war_and_politics " )),
    Tab(key: ValueKey(Constants.topsSeriesWesternId), text: AppLocalizations.of(context).translate("series_western"           )),
    Tab(key: ValueKey(Constants.topsSeriesNetflixId), text: AppLocalizations.of(context).translate("series_netflix"           )),
    Tab(key: ValueKey(Constants.topsSeriesHBOId), text: AppLocalizations.of(context).translate("series_hbo"               )),
    Tab(key: ValueKey(Constants.topsSeriesAmazonPrimeId), text: AppLocalizations.of(context).translate("series_amazon_prime"      )),
    Tab(key: ValueKey(Constants.topsSeriesBBCOneId), text: AppLocalizations.of(context).translate("series_bbc_one"           )), 
    Tab(key: ValueKey(Constants.topsSeriesAMCId), text: AppLocalizations.of(context).translate("series_amc"               )),
  ];
  
  // animes tabs length  = 18
  final List<Tab> animesTabs = <Tab>[
    Tab(key: ValueKey(Constants.topsAnimePopularId), text: AppLocalizations.of(context).translate("anime_popular"             )),
    Tab(key: ValueKey(Constants.topsAnimeRatedId), text: AppLocalizations.of(context).translate("anime_rated"               )),
    Tab(key: ValueKey(Constants.topsAnimeSeasonId), text: AppLocalizations.of(context).translate("anime_season"              )),
    Tab(key: ValueKey(Constants.topsAnimeUpcomingNextSeasonId), text: AppLocalizations.of(context).translate("anime_upcoming_next_season")),
    Tab(key: ValueKey(Constants.topsAnimeActionAndAdventureId), text: AppLocalizations.of(context).translate("anime_action_and_adventure")),
    Tab(key: ValueKey(Constants.topsAnimeComedyId), text: AppLocalizations.of(context).translate("anime_comedy"              )),
    Tab(key: ValueKey(Constants.topsAnimeCrimenId), text: AppLocalizations.of(context).translate("anime_crimen"              )),
    Tab(key: ValueKey(Constants.topsAnimeDramaId), text: AppLocalizations.of(context).translate("anime_drama"               )),
    Tab(key: ValueKey(Constants.topsAnimeMisteryId), text: AppLocalizations.of(context).translate("anime_mistery"             )),
    Tab(key: ValueKey(Constants.topsAnimeFantasyAndSciFiId), text: AppLocalizations.of(context).translate("anime_fantasy_and_sci_fi"  )),
    Tab(key: ValueKey(Constants.topsAnimeWarAndPoliticsId), text: AppLocalizations.of(context).translate("anime_war_and_politics"    )),
    Tab(key: ValueKey(Constants.topsAnimeShonenId), text: AppLocalizations.of(context).translate("anime_shonen"              )),
    Tab(key: ValueKey(Constants.topsAnimeSpokonId), text: AppLocalizations.of(context).translate("anime_spokon"              )),
    Tab(key: ValueKey(Constants.topsAnimeMechaId), text: AppLocalizations.of(context).translate("anime_mecha"               )),
    Tab(key: ValueKey(Constants.topsAnimeSliceOfLifeId), text: AppLocalizations.of(context).translate("anime_slice_of_life"       )),
    Tab(key: ValueKey(Constants.topsAnimeBasedOnMangaId), text: AppLocalizations.of(context).translate("anime_based_on_manga"      )),
    Tab(key: ValueKey(Constants.topsAnimeRomanceId), text: AppLocalizations.of(context).translate("anime_romance"             )),
    Tab(key: ValueKey(Constants.topsAnimeSuperNaturalId), text: AppLocalizations.of(context).translate("anime_super_natural"       )),
  ];

    switch (widget.data) {
      case 'movies': {
        return moviesTabs;
        }
        break;

      case  'tv': { 
        return seriesTabs;
      }
        break;

      case  'animes': {
        return animesTabs;
        }
        break;

      default: return [];
    }
  }

  Widget _getCardViewList(int key){
    
    switch(widget.data){
        
        case 'movies' : {
          return BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
          child: CardViewListMoviesWidget(topId: key)
        );
        }
        break;

        case 'tv'     : {
          return BlocProvider<TopsSeriesBloc>(
          builder: (_) => serviceLocator<TopsSeriesBloc>(),
          child: CardViewListSeriesWidget(typeId: key,)
        );
        }
        break;

        case 'animes' : {
          return BlocProvider<TopsAnimesBloc>(
          builder: (_) => serviceLocator<TopsAnimesBloc>(),
          child: CardViewListAnimesWidget(typeId: key,)
        );
        }
        break;

        default: return Center(child: Text('No type'),);

    }
  }


  Widget _getGridViewList(int key){
    
    switch(widget.data){
        
        case 'movies' : {
          return BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
          child: GridViewListMoviesWidget(typeId: key,)
        );
        }
        break;

        case 'tv'     : {
          return BlocProvider<TopsSeriesBloc>(
          builder: (_) => serviceLocator<TopsSeriesBloc>(),
          child: GridViewListSeriesWidget(typeId: key)
        );
        }
        break;

        case 'animes' : {
          return BlocProvider<TopsAnimesBloc>(
          builder: (_) => serviceLocator<TopsAnimesBloc>(),
          child: GridViewListAnimesWidget(typeId: key)
        );
        }
        break;

        default: return Center(child: Text('No type'),);

    }
  }



}

