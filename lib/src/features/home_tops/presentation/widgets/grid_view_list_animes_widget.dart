import 'package:bunkalist/src/core/reusable_widgets/bottom_sheet_add_your_list_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/poster_column_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class GridViewListAnimesWidget extends StatefulWidget {
  final int typeId;

  GridViewListAnimesWidget({ @required this.typeId});

  @override
  _GridViewListAnimesWidgetState createState() => _GridViewListAnimesWidgetState();
}

class _GridViewListAnimesWidgetState extends State<GridViewListAnimesWidget> {


  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;

  bool loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TopsAnimesBloc>(context)
    ..add(GetAnimesTops(widget.typeId));
  }



  @override
  Widget build(BuildContext context) {

    //final double _aspectRatioOriginal = 5.4 / 7.8;
    final double _aspectRatio = 2.8 / 4.1;

    return Padding(
      padding: const EdgeInsets.all(10.0),
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
               child: GridView.builder(
                  itemBuilder: (context, i) => _itemPoster(context, state.animes[i]),  //itemPoster(context),
                  itemCount: state.animes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: _aspectRatio
                  ),
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

  void nextPage(BuildContext context, typeId){
    return BlocProvider.of<TopsAnimesBloc>(context).add(GetAnimesTops(typeId));
  }

  Widget _itemPoster(BuildContext context, AnimeEntity animeEntity) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, animeEntity), flex: 4,),
          _itemTitle(animeEntity),
          Expanded(child: _iconButton(context), flex: 1,),
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
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ animeEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (animeEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 4.0,
              height: MediaQuery.of(context).size.height / 3.0,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(animeEntity.id, animeEntity.type, animeEntity.name));
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

  Widget _iconButton(BuildContext context){
    return PlatformIconButton(
          iosIcon: Icon(CupertinoIcons.down_arrow, size: 25.0,),
          androidIcon: Icon(Icons.keyboard_arrow_down, size: 25.0,),
          onPressed: (){
            BottomSheetAddInList().showButtomModalMaterial(context);
          },
        );
  }
}