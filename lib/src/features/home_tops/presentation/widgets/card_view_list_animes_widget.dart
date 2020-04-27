import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardViewListAnimesWidget extends StatefulWidget {
  
  final AnimeEntity anime;

  CardViewListAnimesWidget({@required this.anime});

  @override
  _CardViewListAnimesWidgetState createState() => _CardViewListAnimesWidgetState();
}

class _CardViewListAnimesWidgetState extends State<CardViewListAnimesWidget> {
  

  
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
       child: Container(
         child: _itemInfo(),
         height: 160.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                Colors.grey[400].withOpacity(0.1),
                Colors.grey[500].withOpacity(0.1),
                Colors.grey[600].withOpacity(0.1),
              ]
            ) 
          ),
       ),
     ); 
  }

 

  Widget _itemInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem())
      ],
    );

  }

  Widget _columnCenterItem(){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: _rowInfoItem()),
          //SizedBox(height: 10.0,),
          // _chipGenresItem(),
          Expanded(child: ChipsGenresWidget(genres: widget.anime.genreIds.cast<int>(),), flex: 1,),
          //SizedBox(height: 35.0,),
          Expanded(child: _rowButtons()),
        ],
      ),
    );
  }

  Widget _rowInfoItem(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
        Expanded(child: _titleItem(), flex: 5, ),
        //Spacer(),
        Expanded(child: _yearOfItem(), flex: 2,),
        //Spacer(),
        Expanded(child: _rateItem(), flex: 3, )
        ],
      ),
    );
  }

  Widget _posterItem() {
    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.anime.posterPath }');

    //! Agregar el Hero
    final _poster = Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (widget.anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );

    

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(widget.anime.id, widget.anime.type, widget.anime.name) );
          },
          child: _poster 
      ),
    );

  }

  Widget _titleItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0,),
      child: Text(
          widget.anime.name, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),
             overflow: TextOverflow.ellipsis, 
          ),
    );
  }

  Widget _yearOfItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Text(
          DateTime.parse(widget.anime.firstAirDate).year.toString(), 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 1.5),
      child: MiniCircularChartRating(widget.anime.voteAverage),
    );
  }

  // Widget _chipGenresItem() {
  //   return SizedBox(
  //     height: 70.0,
  //     width: double.maxFinite,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _fakeChip('drama', Colors.grey[500].withOpacity(0.1)),
  //         _fakeChip('crime', Colors.grey[500].withOpacity(0.1)),
  //         _fakeChip('action', Colors.grey[500].withOpacity(0.1)),
  //       ],
  //     ),
  //   );
  // }

  // Widget _fakeChip(String text, Color color) {
  //   return Container(
  //     height: 25.0,
  //     width: 55.0,
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(10.0)
  //     ), 
  //     child: Text(
  //       text, 
  //       textAlign: TextAlign.center, 
  //       style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
  //   );
  // }

  Widget _rowButtons() {
    return BlocProvider<AddOuevreBloc>(
          builder: (_) => serviceLocator<AddOuevreBloc>(),
          child: MultiButtonsAdded(ouevre: widget.anime, type: widget.anime.type, objectType: ConstantsTypeObject.animeEntity,),
        );
  
  }

 
}