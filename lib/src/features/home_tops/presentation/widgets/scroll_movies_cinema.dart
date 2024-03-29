

import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/solid_button_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_cinema_movie/cinemamovie_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_movies/selectionmovies_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CarouselMoviesInCinemaWidget extends StatefulWidget {


  @override
  _CarouselMoviesInCinemaWidgetState createState() => _CarouselMoviesInCinemaWidgetState();
}

class _CarouselMoviesInCinemaWidgetState extends State<CarouselMoviesInCinemaWidget> {
  
  MovieEntity _movieEntity;
  Preferences prefs = Preferences();
  
  
  @override
  void initState() {
     BlocProvider.of<CinemaMovieBloc>(context)
    ..add(GetMoviesCinema( 1 ));
    super.initState();
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.15,
      child: BlocBuilder<CinemaMovieBloc, CinemaMovieState>(
      builder: (context, state) {
        
        if(state is CinemaMovieInitial){

          return LoadingCustomWidget();

        }else if(state is CinemaMovieLoading){

          return LoadingCustomWidget();

        }else if(state is CinemaMovieLoaded){

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               CarouselSlider.builder(
                  options: CarouselOptions(   
                  enlargeCenterPage: true, 
                  height: MediaQuery.of(context).size.height / 2.6,
                  autoPlay: false,
                  viewportFraction: 0.50,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, i, h)  {
                    _movieEntity = state.movies[i];

                    return _itemCarousel(context, _movieEntity);
                  } ,
                ),
              _iconButton(context),

            ],
          );

        }else if(state is CinemaMovieError){

          return EmptyIconWidget();

        }

        return EmptyIconWidget();

      },
      )  
    );
  }

  _itemCarousel(BuildContext context, MovieEntity movie) {
    return Column(
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, movie), flex: 12,),
          Expanded(child: _itemTitle(movie), flex: 2,),
          //Expanded(child: _iconButton(context, movie), flex: 2,),
        ],
    );
  }

  Widget _itemImageAndRating(BuildContext context, MovieEntity movieEntity){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context, movieEntity),
          _itemRating(movieEntity)
        ],
      ),
    );
  }

  Widget _itemRating(MovieEntity movieEntity){
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        movieEntity.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _itemImage(BuildContext context, MovieEntity movieEntity) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w500${ movieEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (movieEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height / 2.8,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(movieEntity.id, movieEntity.type, movieEntity.title));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle(MovieEntity movieEntity) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
            movieEntity.title,//? Title of Item
            style: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.w600,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context,){
    return RaisedButton(
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        elevation: 5.0,
        child: Text(
          AppLocalizations.of(context).translate("add_in_list"),
          style: TextStyle(
            color: Colors.white,
            shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: (){
          setState(() {});

          return ButtonClikedAdded(
            context: context,
            isUpdated: false,
            ouevre: _movieEntity,
            type: _movieEntity.type,
            objectType: ConstantsTypeObject.movieEntity
          ).showBottomModal();
        },
    );
  }
}




class CarouselMoviesSelectionWidget extends StatefulWidget {


  @override
  _CarouselMoviesSelectionWidgetState createState() => _CarouselMoviesSelectionWidgetState();
}

class _CarouselMoviesSelectionWidgetState extends State<CarouselMoviesSelectionWidget> {
  
  MovieEntity _movieEntity;
  
  
  @override
  void initState() {
     BlocProvider.of<SelectionmoviesBloc>(context)
    ..add(GetSelectionMovies( Constants.topsMoviesPopularId, 1 ));

    // BlocProvider.of<TopsMoviesBloc>(context)
    // ..add(GetMoviesTops(Constants.topsMoviesPopularId, 1));

    super.initState();
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.15,
      child: BlocBuilder<SelectionmoviesBloc, SelectionmoviesState>(
      builder: (context, state) {
        
        if(state is SelectionmoviesInitial){

          return LoadingCustomWidget();

        }else if(state is MovieLoading){

          return LoadingCustomWidget();

        }else if(state is MovieLoaded){

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               CarouselSlider.builder(
                  options: CarouselOptions(   
                  enlargeCenterPage: true, 
                  height: MediaQuery.of(context).size.height / 2.6,
                  autoPlay: false,
                  viewportFraction: 0.50,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, i, h)  {
                    _movieEntity = state.movies[i];

                    return _itemCarousel(context, _movieEntity);
                  } ,
                ),
              _iconButton(context),

            ],
          );

        }else if(state is MovieError){

          return EmptyIconWidget();

        }

        return EmptyIconWidget();

      },
      )  
    );
  }

  _itemCarousel(BuildContext context, MovieEntity movie) {
    return Column(
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, movie), flex: 12,),
          Expanded(child: _itemTitle(movie), flex: 2,),
          //Expanded(child: _iconButton(context, movie), flex: 2,),
        ],
    );
  }

  Widget _itemImageAndRating(BuildContext context, MovieEntity movieEntity){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context, movieEntity),
          _itemRating(movieEntity)
        ],
      ),
    );
  }

  Widget _itemRating(MovieEntity movieEntity){
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        movieEntity.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _itemImage(BuildContext context, MovieEntity movieEntity) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w500${ movieEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (movieEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height / 2.8,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(movieEntity.id, movieEntity.type, movieEntity.title));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle(MovieEntity movieEntity) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
            movieEntity.title,//? Title of Item
            style: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.w600,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context,){
    return RaisedButton(
        color: Colors.pinkAccent[400],
        elevation: 5.0,
        child: Text(
          AppLocalizations.of(context).translate("add_in_list"),
          style: TextStyle(
            color: Colors.white,
            shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: (){
          setState(() {});

          return ButtonClikedAdded(
            context: context,
            isUpdated: false,
            ouevre: _movieEntity,
            type: _movieEntity.type,
            objectType: ConstantsTypeObject.movieEntity
          ).showBottomModal();
        },
    );
  }
}
