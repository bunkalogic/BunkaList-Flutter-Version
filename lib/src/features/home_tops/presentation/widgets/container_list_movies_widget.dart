import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/bottom_loader_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/title_tops_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_cinema_movie/cinemamovie_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContainerListMoviesWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListMoviesWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListMoviesWidgetState createState() => _ContainerListMoviesWidgetState();
}

class _ContainerListMoviesWidgetState extends State<ContainerListMoviesWidget> {

  int page = 1;

  ScrollController _scrollController;
  bool isLoading = true;


  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }  

  

  @override
  Widget build(BuildContext context) {


    return new Container(
      height: 300,
      child: Column(
        children: <Widget>[
          // titleListTop(widget.title, context),
          TitleTopsWidget(
            titleLabel: widget.title, 
            typeLabel:AppLocalizations.of(context).translate('movies'),
            onTap: (){
              Navigator.pushNamed(context, '/TopList', arguments: 'movies');
            },
          ),
          SizedBox(height: 10.0,),
          Expanded(child: BlocBuilder<TopsMoviesBloc, TopsMoviesState>(
        //bloc: serviceLocator<TopsMoviesBloc>(),
        builder: (context, state) {
          if(state is EmptyMovies){

            if(page == 1){
              BlocProvider.of<TopsMoviesBloc>(context)
              ..add(GetMoviesTops(widget.typeId, page));
            }  
            
            

          }else if(state is LoadingMovies){

            return LoadingCustomWidget();

          }else if (state is LoadedMovies){
            
            isLoading = false;

            if(state.movies.isNotEmpty){

            //    return Container(
            //   child: CarouselSlider.builder(
            //     options: CarouselOptions(
            //       enlargeCenterPage: true, 
            //       aspectRatio: 16 / 9,
            //       autoPlay: false,
            //       viewportFraction: 0.35,
            //     ),
            //     itemCount: state.movies.length,
            //     itemBuilder: (context, i, h) =>  ItemPosterMovies(state.movies[i])
            //   ),
            // );

              
              return NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification, 
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return i >= state.movies.length
                      ? BottomLoader()
                      : ItemPosterMovies(state.movies[i]);
                  } ,
                  itemCount: state.hasReachedMax
                        ? state.movies.length
                        : state.movies.length + 1,
                  itemExtent: 130,
                ),
              );




             }else{
               return EmptyIconWidget();
             }


            
          }else if(state is ErrorMovies){
            return Text(state.message);
          }
          return EmptyIconWidget();
        },
      ),  
      ),
    ],
  ),
);  


  }

  bool _handleScrollNotification(ScrollNotification notification){

    final offsetVisibleThreshold = 50;

    if(notification is ScrollEndNotification && 
      _scrollController.offset + offsetVisibleThreshold >=
      _scrollController.position.maxScrollExtent){

      isLoading = true;
      print('movies page initial: $page');

      (!isLoading) ? page : page++;

      print('movies page++: $page');

      BlocProvider.of<TopsMoviesBloc>(context)
      ..add(GetMoviesTops(widget.typeId, page));  

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


class ContainerListCinemaMoviesWidget extends StatefulWidget {
  final String title;
  
  
  ContainerListCinemaMoviesWidget({@required this.title,});

  @override
  _ContainerListCinemaMoviesWidgetState createState() => _ContainerListCinemaMoviesWidgetState();
}

class _ContainerListCinemaMoviesWidgetState extends State<ContainerListCinemaMoviesWidget> {

  int page = 1;


  @override
  void initState() {
    BlocProvider.of<CinemaMovieBloc>(context)
    ..add(GetMoviesCinema(page));
    super.initState();
  }  

  

  @override
  Widget build(BuildContext context) {


    return new Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: <Widget>[
          TitleTopsWidget(
            titleLabel: widget.title, 
            typeLabel:AppLocalizations.of(context).translate('movies'),
            onTap: (){
              Navigator.pushNamed(context, '/TopList', arguments: 'movies');
            },
          ),
          //titleListTop(widget.title, context),
          Expanded(child: BlocBuilder<CinemaMovieBloc, CinemaMovieState>(
        //bloc: serviceLocator<TopsMoviesBloc>(),
        builder: (context, state) {
          if(state is CinemaMovieInitial){

            return LoadingCustomWidget();

          }else if(state is CinemaMovieLoading){

            return LoadingCustomWidget();

          }else if (state is CinemaMovieLoaded ){
            
              if(state.movies.isNotEmpty){

               return Container(
      
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  enlargeCenterPage: true, 
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  viewportFraction: 0.35,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, i, h) =>  ItemPosterMovies(state.movies[i])
              ),
            );

             }else{
               return EmptyIconWidget();
             }


            
          }else if(state is CinemaMovieError){
            return Text(state.message);
          }
          return EmptyIconWidget();
        },
      ),  
      ),
    ],
  ),
);  


  }

  Widget titleListTop(String title, BuildContext context ){
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/TopList', arguments: 'movies');
      },
      title: Text(title, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }

}



  




class ItemPosterMovies extends StatelessWidget {
  final MovieEntity movieEntity;

  const ItemPosterMovies(this.movieEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.only(right: 15.0,),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _itemImageAndRating(context), flex: 2,),
            _itemTitle(),
            Expanded(child: _iconButton(context), flex: 1,),
          ],
      ),
    );
  }

  
 

  Widget _itemImageAndRating(BuildContext context){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context, ),
          _itemRating()
        ],
      ),
    );
  }

  Widget _itemRating(){
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        movieEntity.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _itemImage(BuildContext context) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ movieEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (movieEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: 95,
              height: 130,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(movieEntity.id, movieEntity.type, movieEntity.title));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            movieEntity.title,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: movieEntity, type: movieEntity.type, isUpdated: false, objectType: ConstantsTypeObject.movieEntity,);
  }
}