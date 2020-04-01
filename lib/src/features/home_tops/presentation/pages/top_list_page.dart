import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/list_all_tops_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';


class TopsListPage extends StatelessWidget {
  
  final String data;

  TopsListPage({
    @required this.data
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
        ),
         BlocProvider<TopsSeriesBloc>(
          builder: (_) => serviceLocator<TopsSeriesBloc>(),
        ),
         BlocProvider<TopsAnimesBloc>(
          builder: (_) => serviceLocator<TopsAnimesBloc>(),
        ),
      ], 
      child: BuildTopsListPage(data: data),
    );
  }
}



class BuildTopsListPage extends StatefulWidget {
  
  
  final String data;


  BuildTopsListPage({
    Key key,
    @required this.data
  }) : super(key: key);

  @override
  _BuildTopsListPageState createState() => _BuildTopsListPageState();
}

class _BuildTopsListPageState extends State<BuildTopsListPage> with SingleTickerProviderStateMixin {
  //? Variables
  final double _aspectRatio = 2.7 / 4.2;

  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;

  ScrollController _scrollController;


  bool isLoading = false;
  bool changeDesign = false;
  int page = 1;
  int ouevreTopId = -1;
  String titleUpdated = '';


  _scrollListener(){
    
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent 
      && !_scrollController.position.outOfRange){
           

        print('page initial: $page');

        switch(widget.data){
        
        case 'movies' : { 
          final topMovieId = (ouevreTopId == -1) ? Constants.topsMoviesPopularId : ouevreTopId; 

          isLoading = true;
          print('movies page initial: $page');

          (!isLoading) ? page : page++;

          print('movies page++: $page');

          BlocProvider.of<TopsMoviesBloc>(context)
          ..add(GetMoviesTops( topMovieId, page ));
          
          
        }
        break;

        case 'tv'     : {
          final topSerieId = (ouevreTopId == -1) ? Constants.topsSeriesPopularId : ouevreTopId;
          isLoading = true;

          print('series page initial: $page');

          (!isLoading) ? page : page++;
          
          print('series page++: $page');

          BlocProvider.of<TopsSeriesBloc>(context)
            ..add(GetSeriesTops(topSerieId, page));
           
           
        }
        break;

        case 'animes' : {
          final topAnimeId = (ouevreTopId == -1) ? Constants.topsAnimePopularId : ouevreTopId;
          isLoading = true;

          print('animes page initial: $page');

          (!isLoading) ? page : page++;
          
          print('animes page++: $page');

            BlocProvider.of<TopsAnimesBloc>(context)
            ..add(GetAnimesTops(topAnimeId, page));
            
            
        }
        break;

        }
        
      }

      if(_scrollController.offset <= _scrollController.position.minScrollExtent 
      && !_scrollController.position.outOfRange ){
          page = (page-- == 0 ) ? 1 : page--;
          print('page--: $page');
          
        switch(widget.data){
        
        case 'movies' : {
          final topMovieId = (ouevreTopId == -1) ? Constants.topsMoviesPopularId : ouevreTopId;  

          BlocProvider.of<TopsMoviesBloc>(context)
          ..add(GetMoviesTops( topMovieId, page ));

        }
        break;

        case 'tv'     : {
          final topSerieId = (ouevreTopId == -1) ? Constants.topsSeriesPopularId : ouevreTopId;

          BlocProvider.of<TopsSeriesBloc>(context)
            ..add(GetSeriesTops(topSerieId, page));
        }
        break;

        case 'animes' : {
            final topAnimeId = (ouevreTopId == -1) ? Constants.topsAnimePopularId : ouevreTopId;
            
            BlocProvider.of<TopsAnimesBloc>(context)
            ..add(GetAnimesTops(topAnimeId, page));
            
        }
        break;

        }
      }
      
  }



  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  
  


  

  @override
  Widget build(BuildContext context) {   

    return Scaffold(
      appBar: _createAppBar(context, (titleUpdated == '') ? _whatTypeIs(context) : titleUpdated),
      body:   _changedListDesign(),
    );
  }




  Widget _createAppBar(BuildContext context, String title) {
    
    return AppBar(
      title: _titleWithButton(title),
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
          )
      ],
    ); 
  }

  Widget _titleWithButton(String title){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => getListTopsOptions(),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis, 
              // style: TextStyle(
              //   fontSize: 18.0, 
              //   fontWeight: FontWeight.w400, 
              //   fontStyle: FontStyle.italic
              // ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_drop_down, size: 30.0,), 
          onPressed: () => getListTopsOptions(),
        ),
      ],
    );
  }

  void getListTopsOptions() async {
    
    var result = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => ListSelectOfTypeTops(type: widget.data, ),
    ));

    Map<String, dynamic> mapResults = result as Map;
    String newTitle = (mapResults['title'] == '' ) ? _whatTypeIs(context) : mapResults['title'];
    int topId = mapResults['topid'];

    print(topId);
    print(newTitle);

    titleUpdated = newTitle;
    ouevreTopId = topId;

    setState(() {});

    switch(widget.data){
        
        case 'movies' : {
          final topMovieId = (ouevreTopId == -1) ? Constants.topsMoviesPopularId : ouevreTopId;  

          page = 1;  

          BlocProvider.of<TopsMoviesBloc>(context)
            ..add(GetMoviesTops( topMovieId, page ));
        }
        break;

        case 'tv'     : {
          final topSerieId = (ouevreTopId == -1) ? Constants.topsSeriesPopularId : ouevreTopId;

          page = 1;

          BlocProvider.of<TopsSeriesBloc>(context)
            ..add(GetSeriesTops(topSerieId, page));
        }
        break;

        case 'animes' : {
          final topAnimeId = (ouevreTopId == -1) ? Constants.topsAnimePopularId : ouevreTopId;

          page = 1;
            
            BlocProvider.of<TopsAnimesBloc>(context)
            ..add(GetAnimesTops(topAnimeId, page));
        }
        break;

      }
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


  


  Widget _changedListDesign() {

     switch(widget.data){
        
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
      return Container(
      child: BlocBuilder<TopsMoviesBloc, TopsMoviesState>(
        builder: (context, state) {
          if(state is EmptyMovies){

            if(ouevreTopId == -1){
              BlocProvider.of<TopsMoviesBloc>(context)
            ..add(GetMoviesTops(Constants.topsMoviesPopularId, page));
            }
            
            return loadingPage;
            
          }else if(state is LoadingMovies){

            return loadingPage;

          }else if (state is LoadedMovies){
            isLoading = false;  

            if(!changeDesign){
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) => GridViewListMoviesWidget(movie: state.movies[i],),
                  itemCount: state.movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _aspectRatio
                  ),
                ),
              );
              

            }else {

              return Container(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.movies.length,
                itemBuilder: (context , i) => CardViewListMoviesWidget(movie: state.movies[i],),
              ),
            );

            }
      
            

            
          }else if(state is ErrorMovies){
            return Text(state.message);
          }

          return Center(child: Text('something Error'));
        },
      ),  
    );
  }

  Widget _buildCardOrGridViewSeries(){
      return Container(
      child: BlocBuilder<TopsSeriesBloc, TopsSeriesState>(
        builder: (context, state) {
          if(state is EmptySeries){

            if(ouevreTopId == -1){
              BlocProvider.of<TopsSeriesBloc>(context)
            ..add(GetSeriesTops(Constants.topsSeriesPopularId, page));
            }
            

            return loadingPage;
            
          }else if(state is LoadingSeries){

            return loadingPage;

          }else if (state is LoadedSeries){
            isLoading = false;
            if(!changeDesign){
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) =>  GridViewListSeriesWidget(series: state.series[i]) ,  
                  itemCount: state.series.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _aspectRatio
                  ),
                ),
              );
              

            }else {

              return Container(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.series.length,
                itemBuilder: (context , i) => CardViewListSeriesWidget(series: state.series[i],),
              ),
            );

            }

            
          }else if(state is ErrorSeries){
            return Text(state.message);
          }

          return Center(child: Text('something Error'));
        },
      ),  
    );
  }

  Widget _buildCardOrGridViewAnimes(){
      return Container(
      child: BlocBuilder<TopsAnimesBloc, TopsAnimesState>(
        builder: (context, state) {
          if(state is EmptyAnimes){

            if(ouevreTopId == -1){
              BlocProvider.of<TopsAnimesBloc>(context)
            ..add(GetAnimesTops(Constants.topsAnimePopularId, page));
            }
            

            return loadingPage;
            
          }else if(state is LoadingAnimes){

            return loadingPage;

          }else if (state is LoadedAnimes){
            isLoading = false;
            if(!changeDesign){
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) => GridViewListAnimesWidget(anime: state.animes[i]) ,
                  itemCount: state.animes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: _aspectRatio
                  ),
                ),
              );
              

            }else {

              return Container(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.animes.length,
                itemBuilder: (context , i) => CardViewListAnimesWidget(anime: state.animes[i],),
              ),
            );

            }

            
          }else if(state is ErrorAnimes){
            return Text(state.message);
          }

          return Center(child: Text('something Error'));
        },
      ),  
    );
  }



}

