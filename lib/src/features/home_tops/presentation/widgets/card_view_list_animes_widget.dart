import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardViewListAnimesWidget extends StatefulWidget {
  
  final int typeId;

  CardViewListAnimesWidget({@required this.typeId});

  @override
  _CardViewListAnimesWidgetState createState() => _CardViewListAnimesWidgetState();
}

class _CardViewListAnimesWidgetState extends State<CardViewListAnimesWidget> {
  
  

  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TopsAnimesBloc>(context)
    ..add(GetAnimesTops(widget.typeId));
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<TopsAnimesBloc, TopsAnimesState>(
         //bloc: serviceLocator<TopsAnimesBloc>(),
         builder: (context, state) {
           if(state is Empty){
             
             return loadingPage;

           }else if(state is Loading){

             return loadingPage;

           }else if (state is Loaded){
             
             if(state.animes.isNotEmpty){

                return Container(   
               child: ListView.builder(
                itemCount: state.animes.length,
                itemBuilder: (context , i) => _buildCardItem(state.animes[i]),
              ),
             );

             }else{
               return Center(child: Text('No Anime Found'));
             }
             
           }else if(state is Error){
             return Text(state.message);
           }
           return Center(child: Text('something Error'));
         },
       ),
      
      
      
      
      
      
      
       
    );
  }

  Widget _buildCardItem(AnimeEntity anime) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
       child: Container(
         child: _itemInfo(anime),
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

  Widget _itemInfo(AnimeEntity anime) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _posterItem(anime),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem(anime))
      ],
    );

  }

  Widget _columnCenterItem(AnimeEntity anime){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: _rowInfoItem(anime)),
          //SizedBox(height: 10.0,),
          // _chipGenresItem(),
          Expanded(child: ChipsGenresWidget(genres: anime.genreIds.cast<int>(),), flex: 1,),
          //SizedBox(height: 35.0,),
          Expanded(child: _rowButtons()),
        ],
      ),
    );
  }

  Widget _rowInfoItem(AnimeEntity anime){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Expanded(child: _titleItem(anime), flex: 4, ),
        Spacer(),
        Expanded(child: _yearOfItem(anime), flex: 1,),
        Spacer(),
        Expanded(child: _rateItem(anime), flex: 2, )
        ],
      ),
    );
  }

  Widget _posterItem(AnimeEntity anime) {
    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ anime.posterPath }');

    //! Agregar el Hero
    final _poster = Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(anime.id, anime.type, anime.name) );
          },
          child: _poster 
      ),
    );

  }

  Widget _titleItem(AnimeEntity anime) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0,),
      child: Text(
          anime.name, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),
             overflow: TextOverflow.ellipsis, 
          ),
    );
  }

  Widget _yearOfItem(AnimeEntity anime) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
          DateTime.parse(anime.firstAirDate).year.toString(), 
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700, 
              fontStyle: FontStyle.italic
            ),   
        ),
    );
  }

  Widget _rateItem(AnimeEntity anime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          Text(anime.voteAverage.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.orange[800]),),
          Icon(Icons.star, size: 20, color: Colors.orange[800], ) 
        ],
      ),
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         _buttonActions(Icons.check_circle, Colors.green), 
         _buttonActions(Icons.play_circle_filled, Colors.blue),
         _buttonActions(Icons.pause_circle_filled, Colors.orange),
         _buttonActions(Icons.remove_circle, Colors.red),
         _buttonActions(Icons.add_circle, Colors.purple),
        ],
      ),
    );
  }

  Widget _buttonActions(IconData icon, Color color){
    return IconButton(
      icon: Icon(
        icon, 
        size: 25.0, 
        color: color,
        ),
        onPressed: () {},
    );
  }
}