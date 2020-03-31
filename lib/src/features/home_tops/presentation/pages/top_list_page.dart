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
  bool changeDesign = false;
  //TabController _tabController;
  int ouevreTopId = -1;
  String titleUpdated = '';

  final double _aspectRatio = 2.7 / 4.2;

  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;


  @override
  void initState() {
    super.initState();
    print('initial topId: $ouevreTopId');
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

          BlocProvider.of<TopsMoviesBloc>(context)
            ..add(GetMoviesTops( topMovieId ));
        }
        break;

        case 'tv'     : {
          final topSerieId = (ouevreTopId == -1) ? Constants.topsSeriesPopularId : ouevreTopId;

          BlocProvider.of<TopsSeriesBloc>(context)
            ..add(GetSeriesTops(topSerieId));
        }
        break;

        case 'animes' : {
          final topAnimeId = (ouevreTopId == -1) ? Constants.topsAnimePopularId : ouevreTopId;
            
            BlocProvider.of<TopsAnimesBloc>(context)
            ..add(GetAnimesTops(topAnimeId));
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
            ..add(GetMoviesTops(Constants.topsMoviesPopularId));
            }
              
            return loadingPage;
            
          }else if(state is LoadingMovies){

            return loadingPage;

          }else if (state is LoadedMovies){


            if(!changeDesign){
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
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
            ..add(GetSeriesTops(Constants.topsSeriesPopularId));
            }

            return loadingPage;
            
          }else if(state is LoadingSeries){

            return loadingPage;

          }else if (state is LoadedSeries){
      
            if(!changeDesign){
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
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
            ..add(GetAnimesTops(Constants.topsAnimePopularId));
            }

            return loadingPage;
            
          }else if(state is LoadingAnimes){

            return loadingPage;

          }else if (state is LoadedAnimes){
      
            if(!changeDesign){
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
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

