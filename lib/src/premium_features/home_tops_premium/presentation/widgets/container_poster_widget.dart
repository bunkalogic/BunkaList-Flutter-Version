import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:flutter/material.dart';


class ContainerPosterMovieWidget extends StatefulWidget {

  final MovieEntity movie;

  ContainerPosterMovieWidget({@required this.movie});

  @override
  _ContainerPosterMovieWidgetState createState() => _ContainerPosterMovieWidgetState();
}

class _ContainerPosterMovieWidgetState extends State<ContainerPosterMovieWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 20.0
      ),
      color: Colors.transparent,
      child: Container(
        child: _stackTextAndIcon(),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        ) 
      ),

    );
  }

  Widget _stackTextAndIcon() {
    return Stack(
      children: <Widget>[
        _imageBackground(),
        _itemRating(),
        _nameItem(),
        _buttonItem()
      ],
    );
  }

  Widget _itemRating(){
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        widget.movie.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _imageBackground() {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w780${ widget.movie.backdropPath }');

    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.movie.id, widget.movie.type, widget.movie.title));
      },
      child: Container(
        width: double.infinity,
        child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: (widget.movie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
                  placeholder: placeholder, //? PlaceHolder Item,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );



  }


  Widget _nameItem(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
              widget.movie.title,//? Title of Item
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,  
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
                ]
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,

            ),
      ),
    );
  }

  Widget _buttonItem(){
    return Align(
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: (){
          return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: widget.movie,
              type: widget.movie.type,
              objectType: ConstantsTypeObject.movieEntity
            ).showBottomModal();
        },
        heroTag: null,
        elevation: 10.0,
        mini: true,
        child: Icon(Icons.add, color: Colors.pinkAccent[400], size: 20.0,),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: Colors.pinkAccent[400],
            width: 2.0
          ),
        ),
      ),
    );
  }
}


class ContainerPosterSerieWidget extends StatefulWidget {
  
  final SeriesEntity serie;

  ContainerPosterSerieWidget({@required this.serie});

  @override
  _ContainerPosterSerieWidgetState createState() => _ContainerPosterSerieWidgetState();
}

class _ContainerPosterSerieWidgetState extends State<ContainerPosterSerieWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 20.0
      ),
      color: Colors.transparent,
      child: Container(
        child: _stackTextAndIcon(),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        ) 
      ),

    );
  }

  Widget _stackTextAndIcon() {
    return Stack(
      children: <Widget>[
        _imageBackground(),
        _itemRating(),
        _nameItem(),
        _buttonItem()
      ],
    );
  }

  Widget _itemRating(){
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        widget.serie.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _imageBackground() {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w780${ widget.serie.backdropPath }');

    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.serie.id, widget.serie.type, widget.serie.name));
      },
      child: Container(
        width: double.infinity,
        child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: (widget.serie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
                  placeholder: placeholder, //? PlaceHolder Item,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );



  }


  Widget _nameItem(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
              widget.serie.name,//? Title of Item
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,  
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
                ]
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,

            ),
      ),
    );
  }

  Widget _buttonItem(){
    return Align(
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: (){
          return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: widget.serie,
              type: widget.serie.type,
              objectType: ConstantsTypeObject.serieEntity
            ).showBottomModal();
        },
        heroTag: null,
        elevation: 10.0,
        mini: true,
        child: Icon(Icons.add, color: Colors.pinkAccent[400], size: 20.0,),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: Colors.pinkAccent[400],
            width: 2.0
          ),
        ),
      ),
    );
  }

}


class ContainerPosterAnimeWidget extends StatefulWidget {
  
   final AnimeEntity anime;

  ContainerPosterAnimeWidget({@required this.anime});

  @override
  _ContainerPosterAnimeWidgetState createState() => _ContainerPosterAnimeWidgetState();
}

class _ContainerPosterAnimeWidgetState extends State<ContainerPosterAnimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 20.0
      ),
      color: Colors.transparent,
      child: Container(
        child: _stackTextAndIcon(),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        ) 
      ),

    );
  }

  Widget _stackTextAndIcon() {
    return Stack(
      children: <Widget>[
        _imageBackground(),
        _itemRating(),
        _nameItem(),
        _buttonItem()
      ],
    );
  }

  Widget _itemRating(){
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        widget.anime.voteAverage.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
          shadows: [
           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
      ),
    );
  }

  Widget _imageBackground() {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w780${ widget.anime.backdropPath }');

    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.anime.id, widget.anime.type, widget.anime.name));
      },
      child: Container(
        width: double.infinity,
        child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: (widget.anime.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
                  placeholder: placeholder, //? PlaceHolder Item,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );



  }


  Widget _nameItem(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
              widget.anime.name,//? Title of Item
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,  
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
                ]
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,

            ),
      ),
    );
  }

  Widget _buttonItem(){
    return Align(
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: (){
          return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: widget.anime,
              type: widget.anime.type,
              objectType: ConstantsTypeObject.animeEntity
            ).showBottomModal();
        },
        heroTag: null,
        elevation: 10.0,
        mini: true,
        child: Icon(Icons.add, color: Colors.pinkAccent[400], size: 20.0,),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: Colors.pinkAccent[400],
            width: 2.0
          ),
        ),
      ),
    );
  }
}