import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_similar/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AllDetailsSimilarTab extends StatefulWidget{

  final int id;
  final String type;

  const AllDetailsSimilarTab({@required this.id, @required this.type});

  @override
  _AllDetailsSimilarTabState createState() => _AllDetailsSimilarTabState();
}

class _AllDetailsSimilarTabState extends State<AllDetailsSimilarTab> {
  
  //  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   BlocProvider.of<SimilarBloc>(context)
  //   ..add((GetSimilar(widget.id, widget.type)));
  // }

  @override
  void initState() {
    BlocProvider.of<SimilarBloc>(context)
    ..add((GetSimilar(widget.id, widget.type)));
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    //final double _aspectRatio = 2.8 / 4.1;
    final double _aspectRatio = 2.7 / 4.2;

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15.0),
      child: BlocBuilder<SimilarBloc, SimilarState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is LoadedMovie){

            if(state.movie.isNotEmpty){

              return Container(
                height: 220,
                child: ListView.builder(
                  itemExtent: 130.0,
                  itemBuilder: (context, i) => ItemPosterMovie(movie: state.movie[i]),  //itemPoster(context),
                  itemCount: state.movie.length,
                  scrollDirection: Axis.horizontal,
                ),
              );

             }else{

              return EmptyIconWidget();

             }

          }else if(state is LoadedSerie){

            if(state.serie.isNotEmpty){

              return Container(
                height: 220,
                child: ListView.builder(
                  itemExtent: 130.0,
                  itemBuilder: (context, i) => ItemPosterSerie(serie: state.serie[i]),
                  itemCount: state.serie.length,
                  scrollDirection: Axis.horizontal,
                ),
              );

             }else{
               return EmptyIconWidget();
             }


          }else if(state is LoadedAnime){

            if(state.anime.isNotEmpty){

              return Container(
              height: 220,                
              child: ListView.builder(
                itemExtent: 130.0,
                itemBuilder: (context, i) => ItemPosterAnime(anime: state.anime[i]),
                itemCount: state.anime.length,
                scrollDirection: Axis.horizontal,
                ),
              );

             }else{
               return EmptyIconWidget();
             }

          }else if(state is Error){
            
            return EmptyIconWidget();

          }

         return EmptyIconWidget();

        },
      ),
    );
  }
}

class ItemPosterMovie extends StatelessWidget{

  final MovieEntityRS movie;

  ItemPosterMovie({@required this.movie});

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
        movie.voteAverage.toString(),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ movie.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (movie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(movie.id, movie.type, movie.title));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            movie.title,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: movie, type: movie.type, isUpdated: false, objectType: ConstantsTypeObject.movieEntityRS,);
  }

}

class ItemPosterSerie extends StatelessWidget{

  final SeriesEntityRS serie;

  ItemPosterSerie({@required this.serie});

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
          _itemImage(context),
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
        serie.voteAverage.toString(),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ serie.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (serie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(serie.id, serie.type, serie.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            serie.name,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: serie, type: serie.type, isUpdated: false, objectType: ConstantsTypeObject.serieEntityRS,);
  }

}

class ItemPosterAnime extends StatelessWidget{

  final AnimeEntityRS anime;

  ItemPosterAnime({@required this.anime});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.only(right: 15.0,),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _itemImageAndRating(context,), flex: 2,),
            _itemTitle(),
            Expanded(child: _iconButton(context,), flex: 1,),
          ],
      ),
    );
  }

  Widget _itemImageAndRating(BuildContext context){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context),
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
        anime.voteAverage.toString(),
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

  Widget _itemImage(BuildContext context,) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ anime.posterPath }');

    
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (anime.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(anime.id, anime.type,  anime.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            anime.name,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){

    return ButtonAddedArrowDown(ouevre: anime, type: anime.type, isUpdated: false, objectType: ConstantsTypeObject.animeEntityRS,);
        
  }

}