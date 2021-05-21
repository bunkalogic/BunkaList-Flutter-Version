import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:flutter/material.dart';



class ItemPosterMovieWidget extends StatefulWidget {

  final MovieEntity movie;

  ItemPosterMovieWidget({@required this.movie});

  @override
  _ItemPosterMovieWidgetState createState() => _ItemPosterMovieWidgetState();
}

class _ItemPosterMovieWidgetState extends State<ItemPosterMovieWidget> {
  
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
        widget.movie.voteAverage.toString(),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.movie.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (widget.movie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.movie.id, widget.movie.type, widget.movie.title));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            widget.movie.title,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: widget.movie, type: widget.movie.type, isUpdated: false, objectType: ConstantsTypeObject.movieEntity,);
  }

}





class ItemPosterSerieWidget extends StatefulWidget {

  final SeriesEntity series;

  ItemPosterSerieWidget({@required this.series});

  @override
  _ItemPosterSerieWidgetState createState() => _ItemPosterSerieWidgetState();
}

class _ItemPosterSerieWidgetState extends State<ItemPosterSerieWidget> {
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
        widget.series.voteAverage.toString(),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.series.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (widget.series.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.series.id, widget.series.type, widget.series.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            widget.series.name,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: widget.series, type: widget.series.type, isUpdated: false, objectType: ConstantsTypeObject.serieEntity,);
  }

}




class ItemPosterAnimeWidget extends StatefulWidget {

  final AnimeEntity anime;

  ItemPosterAnimeWidget({@required this.anime});

  @override
  _ItemPosterAnimeWidgetState createState() => _ItemPosterAnimeWidgetState();
}

class _ItemPosterAnimeWidgetState extends State<ItemPosterAnimeWidget> {
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
        widget.anime.voteAverage.toString(),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.anime.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (widget.anime.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.anime.id, widget.anime.type, widget.anime.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            widget.anime.name,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: widget.anime, type: widget.anime.type, isUpdated: false, objectType: ConstantsTypeObject.animeEntity,);
  }
}