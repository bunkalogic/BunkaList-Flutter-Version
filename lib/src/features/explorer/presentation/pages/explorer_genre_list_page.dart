import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/bottom_loader_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:bunkalist/src/features/explorer/presentation/bloc/bloc_explorer_animes/animes_explorer_bloc.dart';
import 'package:bunkalist/src/features/explorer/presentation/bloc/bloc_explorer_movies/moviesexplorer_bloc.dart';
import 'package:bunkalist/src/features/explorer/presentation/bloc/bloc_explorer_series/series_explorer_bloc.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/bottom_modal_filter.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_series_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';


class ExplorerGenreListPage extends StatefulWidget {
  final Genres data;
  ExplorerGenreListPage({@required this.data});

  @override
  _ExplorerGenreListPageState createState() => _ExplorerGenreListPageState();
}

class _ExplorerGenreListPageState extends State<ExplorerGenreListPage> {
  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
         BlocProvider<MoviesExplorerBloc>(
          builder: (_) => serviceLocator<MoviesExplorerBloc>(),
        ),
         BlocProvider<SeriesExplorerBloc>(
          builder: (_) => serviceLocator<SeriesExplorerBloc>(),
        ),
         BlocProvider<AnimesExplorerBloc>(
          builder: (_) => serviceLocator<AnimesExplorerBloc>(),
        ),
      ], 
      child: BuildExplorerListPage(data: widget.data),
    );
  }
}


class BuildExplorerListPage extends StatefulWidget {
  final Genres data;
  BuildExplorerListPage({@required this.data});

  @override
  _BuildExplorerListPageState createState() => _BuildExplorerListPageState();
}

class _BuildExplorerListPageState extends State<BuildExplorerListPage> {
  
  //? Variables
  final double _aspectRatio = 2.7 / 4.2;

  FilterOptions finalFilterOptions = new FilterOptions();

  ScrollController _scrollController;
  final _scrollThreshold = 100.0;

  
  bool isLoading = false;
  bool changeDesign = false;
  int page = 1;


  

  @override
  void initState() {
    _scrollController = ScrollController();
    //_scrollController.addListener(_onScroll);
    super.initState();

  }

  
  

  

  @override
  Widget build(BuildContext context) {   

    return Scaffold(
      appBar: _createAppBar(context, _whatTypeIs(context)),
      body:   _changedListDesign(),
    );
  }




  Widget _createAppBar(BuildContext context, String title) {
    
    return AppBar(
      title: Text(title),
      leading: AppBarButtonBack(),
      //bottom: _tabBar(context),
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
        ),
        IconButton(
          icon: Icon(Icons.tune, size: 26,), 
          onPressed: () async {
            FilterOptions result = await showModalBottomSheet<FilterOptions>(
              isScrollControlled: true,
              elevation: 10.0,
              isDismissible: false,
              backgroundColor: _getBackgroundColorTheme(), 
              context: context,
              builder: (context) => BuildBottomModalFilter(type: widget.data.type,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30)
                )
              )
            );

            
            
            finalFilterOptions = result;
            print('result of showModal year: ${result.year}');

             print('result of showModal sort by: ${result.sortBy}');

            setState(() {}); 

             switch(widget.data.type){
        
              case 'movies' : {
                
                BlocProvider.of<MoviesExplorerBloc>(context)
                ..add(GetMoviesExplorer(
                  page: page,
                  sortBy: finalFilterOptions.sortBy ?? ConstSortBy.popularityDesc,
                  genre: widget.data.id,
                  year: finalFilterOptions.year ?? 0,

                ));
              }
              break;

              case 'tv'     : {
                BlocProvider.of<SeriesExplorerBloc>(context)
                ..add(GetSeriesExplorer(
                  page: page,
                  sortBy: finalFilterOptions.sortBy ?? ConstSortBy.popularityDesc,
                  genre: widget.data.id,
                  year: finalFilterOptions.year ?? 0
                ));
              }
              break;

              case 'animes' : {
                
                 BlocProvider.of<AnimesExplorerBloc>(context)
                  ..add(GetAnimesExplorer(
                    page: page,
                    sortBy: finalFilterOptions.sortBy?? ConstSortBy.popularityDesc,
                    genre: (widget.data.isKeyword) ? null : widget.data.id,
                    withKeywords: (widget.data.isKeyword) ? widget.data.id : null,
                    year: finalFilterOptions.year ?? 0
                  ));

              }
              break;

              default: return Center(child: Text('No type'),);

            }

          }
        ),
      ],
    ); 
  }

  

   Color _getBackgroundColorTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false){
      return Colors.blueGrey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs == true){
      return Colors.grey[900];
    }
    else{
      return Colors.grey[100];
    }
  }

  

  String _whatTypeIs(BuildContext context){
      switch(widget.data.type){
        
        case 'movies' :{
          final String type = AppLocalizations.of(context).translate('movies');

          final String title = "$type ${widget.data.label}";

          return title;
        } 
        break;

        case 'tv'     :{
          final String type = AppLocalizations.of(context).translate('series');

          final String title = "$type ${widget.data.label}";

          return title;
        } 
        break;

        case 'animes' : {
          final String type = AppLocalizations.of(context).translate('animes');

          final String title = "$type ${widget.data.label}";

          return title;
        } 
        break;

        default: return 'No type found';

      }
  }


  


  Widget _changedListDesign() {

     switch(widget.data.type){
        
        case 'movies' : {
          return _buildCardOrGridViewMovies();
        }
        break;

        case 'tv'     : {
          return _buildCardOrGridViewSeries();
        }
        break;

        case 'animes' : {
          return _buildCardOrGridViewAnimes();
        }
        break;

        default: return Center(child: Text('No type'),);

    }
      
      
  }

  Widget _changedIcon() {
     
      if(!changeDesign){
        return Icon(Icons.art_track, size: 32, );
      }else {
        return Icon(Icons.view_module, size: 32 ,);
      }
      
      
  }

  
  
 

  Widget _buildCardOrGridViewMovies(){

      return BlocBuilder<MoviesExplorerBloc, MoviesExplorerState>(
        builder: (context, state) {
              
          if(state is MoviesExplorerInitial){

            if(page == 1){
              BlocProvider.of<MoviesExplorerBloc>(context)
            ..add(GetMoviesExplorer(
              page: page,
              sortBy: ConstSortBy.popularityDesc,
              genre: widget.data.id,
            ));
            }
             
            
          }
          
          if (state is LoadedExplorerMovies){
            
            isLoading = false;

            if(state.movies.isEmpty){

              return EmptyIconWidget();

            }else{

              if(!changeDesign){
                
              
              return NotificationListener<ScrollNotification>(
                 onNotification: _handleScrollNotification,
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) {
                    return i >= state.movies.length
                      ? BottomLoader()
                      : GridViewListMoviesWidget(movie: state.movies[i],);
                  }, 
                  itemCount: state.hasReachedMax
                    ? state.movies.length
                    : state.movies.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _aspectRatio
                  ),
                ),
              );
              

            }else {
              
              return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                  ? state.movies.length
                  : state.movies.length + 1,
                itemBuilder: (context , i){
                  
                  return i >= state.movies.length
                    ? BottomLoader()
                    : CardViewListMoviesWidget(movie: state.movies[i],);
                  
                } 
              ),
            );

            }

            }

            

            
            
          }
           if(state is ErrorExplorerMovies){
            return Text(state.message);
          }

          return LoadingCustomWidget();
        },
      );
  }

  Widget _buildCardOrGridViewSeries(){
      return BlocBuilder<SeriesExplorerBloc, SeriesExplorerState>(
        builder: (context, state) {
          if(state is SeriesExplorerInitial){

            if(page == 1){
               BlocProvider.of<SeriesExplorerBloc>(context)
            ..add(GetSeriesExplorer(
              page: page,
              sortBy: ConstSortBy.popularityDesc,
              genre: widget.data.id,
            ));
            }
            
            
            
          }
          
          if (state is LoadedExplorerSeries){
            
            //isLoading = state.hasReachedMax;
            isLoading = false;

            if(state.series.isEmpty){

              return EmptyIconWidget();

            }else{

              if(!changeDesign){
              
              return NotificationListener<ScrollNotification>(
                 onNotification: _handleScrollNotification,
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) {
                    return i >= state.series.length
                      ? BottomLoader()
                      : GridViewListSeriesWidget(series: state.series[i],);
                  }, 
                  itemCount: state.hasReachedMax
                    ? state.series.length
                    : state.series.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _aspectRatio
                  ),
                ),
              );
              

            }else {
              
              return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                  ? state.series.length
                  : state.series.length + 1,
                itemBuilder: (context , i){
                  
                  return i >= state.series.length
                    ? BottomLoader()
                    : CardViewListSeriesWidget(series: state.series[i],);
                  
                } 
              ),
            );

            }

            }

            

            
            
          }
           if(state is ErrorExplorerSeries){
            return Text(state.message);
          }

          return LoadingCustomWidget();
        },
      );
  }

  Widget _buildCardOrGridViewAnimes(){
      return BlocBuilder<AnimesExplorerBloc, AnimesExplorerState>(
        builder: (context, state) {
          if(state is AnimesExplorerInitial){

            if(page == 1){
              BlocProvider.of<AnimesExplorerBloc>(context)
            ..add(GetAnimesExplorer(
              page: page,
              sortBy: ConstSortBy.popularityDesc,
              genre: (widget.data.isKeyword) ? null : widget.data.id,
              withKeywords: (widget.data.isKeyword) ? widget.data.id : null
            ));
            }
            
            
            
            
          }
          
          if (state is LoadedExplorerAnimes){
            
            //isLoading = state.hasReachedMax;
            isLoading = false;

            if(state.animes.isEmpty){

              return EmptyIconWidget();

            }else{

              if(!changeDesign){
              
              return NotificationListener<ScrollNotification>(
                 onNotification: _handleScrollNotification,
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) {
                    return i >= state.animes.length
                      ? BottomLoader()
                      : GridViewListAnimesWidget(anime: state.animes[i],);
                  }, 
                  itemCount: state.hasReachedMax
                    ? state.animes.length
                    : state.animes.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _aspectRatio
                  ),
                ),
              );
              

            }else {
              
              return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                  ? state.animes.length
                  : state.animes.length + 1,
                itemBuilder: (context , i){
                  
                  return i >= state.animes.length
                    ? BottomLoader()
                    : CardViewListAnimesWidget(anime: state.animes[i],);
                  
                } 
              ),
            );

            }

            }

            

            
            
          }
           if(state is ErrorExplorerAnimes){
            return Text(state.message);
          }

          return LoadingCustomWidget();
        },
      );
  }



  bool _handleScrollNotification(ScrollNotification notification) {

     final offsetVisibleThreshold = 50; // or something else..

    if (notification is ScrollEndNotification &&
       _scrollController.offset + offsetVisibleThreshold >=
        _scrollController.position.maxScrollExtent) {
      switch(widget.data.type){
        
        case 'movies' : {  

          isLoading = true;
          print('movies page initial: $page');

          (!isLoading) ? page : page++;

          print('movies page++: $page');

           BlocProvider.of<MoviesExplorerBloc>(context)
                ..add(GetMoviesExplorer(
                  page: page,
                  sortBy: finalFilterOptions.sortBy?? ConstSortBy.popularityDesc,
                  genre: widget.data.id,
                  year: finalFilterOptions.year ?? null,

                ));
          
          
        }
        break;

        case 'tv'     : {
          
          isLoading = true;

          print('series page initial: $page');

          (!isLoading) ? page : page++;
          
          print('series page++: $page');

          BlocProvider.of<SeriesExplorerBloc>(context)
                ..add(GetSeriesExplorer(
                  page: page,
                  sortBy: finalFilterOptions.sortBy?? ConstSortBy.popularityDesc,
                  genre: widget.data.id,
                  year: finalFilterOptions.year ?? null
                ));
           
           
        }
        break;

        case 'animes' : {
          
          isLoading = true;

          print('animes page initial: $page');

          (!isLoading) ? page : page++;
          
          print('animes page++: $page');

          BlocProvider.of<AnimesExplorerBloc>(context)
                  ..add(GetAnimesExplorer(
                    page: page,
                    sortBy: finalFilterOptions.sortBy ?? ConstSortBy.popularityDesc,
                    genre: (widget.data.isKeyword) ? null : widget.data.id,
                    withKeywords: (widget.data.isKeyword) ? widget.data.id : null,
                    year: finalFilterOptions.year ?? null
                  ));
            
            
        }
        break;

        }
    }
      isLoading = false;
    return isLoading;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



}