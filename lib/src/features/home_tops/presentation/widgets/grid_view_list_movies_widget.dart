import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/core/utils/get_size_grid_item_image_util.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridViewListMoviesWidget extends StatefulWidget {

  final MovieEntity movie;

  GridViewListMoviesWidget({@required this.movie});


  @override
  _GridViewListMoviesWidgetState createState() => _GridViewListMoviesWidgetState();
}

class _GridViewListMoviesWidgetState extends State<GridViewListMoviesWidget> {
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _itemImageAndRating(), flex: 6,),
            Expanded(child: _itemTitle(), flex: 1,),
            Expanded(child: _iconButton(), flex: 1,),
          ], 
      ),
    );
  }

  

  Widget _itemImageAndRating(){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(),
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

  Widget _itemImage() {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.movie.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (widget.movie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: getWidthGridItemImage(),
              height: getHeightGridItemImage(),
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

  Widget _iconButton(){
  return ButtonAddedArrowDown(ouevre: widget.movie, type: widget.movie.type, isUpdated: false, objectType: ConstantsTypeObject.movieEntity ,);
  }
}