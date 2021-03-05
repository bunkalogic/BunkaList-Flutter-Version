import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_animes/selectionanimes_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContainerListAnimeWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListAnimeWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListAnimeWidgetState createState() => _ContainerListAnimeWidgetState();
}

class _ContainerListAnimeWidgetState extends State<ContainerListAnimeWidget> {

  int page = 1;

  @override
  void initState() {
    BlocProvider.of<TopsAnimesBloc>(context)
    ..add(GetAnimesTops(widget.typeId, page));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

     return new Container(
       height: MediaQuery.of(context).size.height / 2.5,
       child: Column(
         children: <Widget>[
           titleListTop(widget.title, context),
           Expanded(child: BlocBuilder<TopsAnimesBloc, TopsAnimesState>(
         builder: (context, state) {
           if(state is EmptyAnimes){

             return LoadingCustomWidget();

           }else if(state is LoadingAnimes){

             return LoadingCustomWidget();

           }else if (state is LoadedAnimes){
             
             if(state.animes.isNotEmpty){

                return Container(   
               child: CarouselSlider.builder(
                 options: CarouselOptions(
                  enlargeCenterPage: true, 
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  viewportFraction: 0.35,
                 ),
                 itemCount: state.animes.length,
                 itemBuilder: (context, i, h) => ItemPosterAnimes(state.animes[i])
               ),
             );

             }else{
               return EmptyIconWidget();
             }
             
           }else if(state is ErrorAnimes){
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
        Navigator.pushNamed(context, '/TopList', arguments: 'animes');
      },
      title: Text(title, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }



}


class ContainerListSelectionAnimeWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListSelectionAnimeWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListSelectionAnimeWidgetState createState() => _ContainerListSelectionAnimeWidgetState();
}

class _ContainerListSelectionAnimeWidgetState extends State<ContainerListSelectionAnimeWidget> {

  int page = 1;

  @override
  void initState() {
    BlocProvider.of<SelectionanimesBloc>(context)
    ..add(GetSelectionAnime(widget.typeId, page));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

     return new Container(
       height: MediaQuery.of(context).size.height / 2.5,
       child: Column(
         children: <Widget>[
           titleListTop(widget.title, context),
           Expanded(child: BlocBuilder<SelectionanimesBloc, SelectionanimesState>(
         builder: (context, state) {
           if(state is SelectionanimesInitial){

             return LoadingCustomWidget();

           }else if(state is LoadingSelectionanimesBlocAnimes){

             return LoadingCustomWidget();

           }else if (state is LoadedSelectionanimesBlocAnimes){
             
             if(state.animes.isNotEmpty){

                return Container(   
               child: CarouselSlider.builder(
                 options: CarouselOptions(
                  enlargeCenterPage: true, 
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  viewportFraction: 0.35,
                 ),
                 itemCount: state.animes.length,
                 itemBuilder: (context, i, h) => ItemPosterAnimes(state.animes[i])
               ),
             );

             }else{
               return EmptyIconWidget();
             }
             
           }else if(state is ErrorSelectionanimesBlocAnimes){
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
        Navigator.pushNamed(context, '/TopList', arguments: 'animes');
      },
      title: Text(title, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }



}



class ItemPosterAnimes extends StatelessWidget {
  final AnimeEntity animeEntity;

  const ItemPosterAnimes(this.animeEntity);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context,), flex: 4,),
          _itemTitle(),
          Expanded(child: _iconButton(context,), flex: 1,),
        ],
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
        animeEntity.voteAverage.toString(),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ animeEntity.posterPath }');

    
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (animeEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 3.8,
              height: MediaQuery.of(context).size.height / 2.8,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(animeEntity.id, animeEntity.type,  animeEntity.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            animeEntity.name,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context){

    return ButtonAddedArrowDown(ouevre: animeEntity, type: animeEntity.type, isUpdated: false, objectType: ConstantsTypeObject.animeEntity,);
        
  }

}