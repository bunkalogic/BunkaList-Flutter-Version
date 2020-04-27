import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
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

  // final _pageController = new PageController(
  //   initialPage: 1,
  //   viewportFraction: 0.35,
  // );

  


  // _addListener(){
  //   _pageController.addListener( (){

  //     if(_pageController.offset >= _pageController.position.maxScrollExtent 
  //     && !_pageController.position.outOfRange){
         
  //        BlocProvider.of<TopsAnimesBloc>(context)
  //       ..add(GetAnimesTops(widget.typeId, page++));
         
  //     }

  //      if(_pageController.offset <= _pageController.position.minScrollExtent 
  //     && !_pageController.position.outOfRange ){
  //         page = (page-- == 0 ) ? 1 : page--;
          
  //         BlocProvider.of<TopsAnimesBloc>(context)
  //         ..add(GetAnimesTops(widget.typeId, page));
  //     }

  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController.addListener(_addListener);
  // }  

  @override
  void initState() {
    BlocProvider.of<TopsAnimesBloc>(context)
    ..add(GetAnimesTops(widget.typeId, page));
    super.initState();
  }


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   BlocProvider.of<TopsAnimesBloc>(context)
  //   ..add(GetAnimesTops(widget.typeId, page));
  // }


  @override
  Widget build(BuildContext context) {

     return new Container(
       height: MediaQuery.of(context).size.height / 2.6,
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
                 enlargeCenterPage: true, 
                 aspectRatio: 16 / 9,
                 autoPlay: false,
                 viewportFraction: 0.35,
                 itemCount: state.animes.length,
                 itemBuilder: (context, i) => _itemPoster(context, state.animes[i]),
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
      title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800], fontSize: 16.0 ),),
    );
  }



  Widget _itemPoster(BuildContext context, AnimeEntity animeEntity) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, animeEntity), flex: 4,),
          _itemTitle(animeEntity),
          Expanded(child: _iconButton(context, animeEntity), flex: 1,),
        ],
    );
  }

  Widget _itemImageAndRating(BuildContext context, AnimeEntity animeEntity){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context, animeEntity),
          _itemRating(animeEntity)
        ],
      ),
    );
  }

  Widget _itemRating(AnimeEntity animeEntity){
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

  Widget _itemImage(BuildContext context, AnimeEntity animeEntity) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ animeEntity.posterPath }');

    //! Agregar el Hero
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

  Widget _itemTitle(AnimeEntity animeEntity) {
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

  Widget _iconButton(BuildContext context, AnimeEntity animeEntity){

    return ButtonAddedArrowDown(ouevre: animeEntity, type: animeEntity.type, isUpdated: false, objectType: ConstantsTypeObject.animeEntity,);
        
  }


  





}