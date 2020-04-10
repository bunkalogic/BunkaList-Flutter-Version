
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContainerListSeriesWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListSeriesWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListSeriesWidgetState createState() => _ContainerListSeriesWidgetState();
}

class _ContainerListSeriesWidgetState extends State<ContainerListSeriesWidget> {

  int page = 1;

  // final _pageController = new PageController(
  //   initialPage: 1,
  //   viewportFraction: 0.3,
  // );


  @override
  void initState() {
    BlocProvider.of<TopsSeriesBloc>(context)
    ..add(GetSeriesTops(widget.typeId, page));
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   BlocProvider.of<TopsSeriesBloc>(context)
  //   ..add(GetSeriesTops(widget.typeId, page));
  // }

  @override
  Widget build(BuildContext context) {
    
    // _pageController.addListener( (){

    //   if(_pageController.offset >= _pageController.position.maxScrollExtent 
    //   && !_pageController.position.outOfRange){
    //      BlocProvider.of<TopsSeriesBloc>(context)
    //     ..add(GetSeriesTops(widget.typeId, page + 1));
         
    //   }

    //    if(_pageController.offset <= _pageController.position.minScrollExtent 
    //   && !_pageController.position.outOfRange ){
    //       page = (page - 1 == 0 ) ? 1 : page - 1;

    //       BlocProvider.of<TopsSeriesBloc>(context)
    //       ..add(GetSeriesTops(widget.typeId, page));
    //   }

    // });

    return new Container(
      height: MediaQuery.of(context).size.height / 2.6,
      child: Column(
        children: <Widget>[
          titleListTop(widget.title, context),
          Expanded(child: BlocBuilder<TopsSeriesBloc, TopsSeriesState>(
        //bloc: serviceLocator<TopsSeriesBloc>(),
        builder: (context, state) {
          if(state is EmptySeries){
            
            return LoadingCustomWidget();

          }else if(state is LoadingSeries){

            return LoadingCustomWidget();

          }else if (state is LoadedSeries){
            
              if(state.series.isNotEmpty){

                return Container(      
              child: CarouselSlider.builder(
                 enlargeCenterPage: true, 
                 aspectRatio: 16 / 9,
                 autoPlay: false,
                 viewportFraction: 0.35,
                itemCount: state.series.length,
                itemBuilder: (context, i) => _itemPoster(context, state.series[i]),
              ),
            );

             }else{
               return EmptyIconWidget();
             }


            
          }else if(state is ErrorSeries){
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
        Navigator.pushNamed(context, '/TopList', arguments: 'tv');
      },
      title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800], fontSize: 16.0 ),),
    );
  }



  Widget _itemPoster(BuildContext context, SeriesEntity seriesEntity) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, seriesEntity), flex: 4,),
          _itemTitle(seriesEntity),
          Expanded(child: _iconButton(context, seriesEntity), flex: 1,),
        ],
    );
  }

  Widget _itemImageAndRating(BuildContext context, SeriesEntity seriesEntity){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context, seriesEntity),
          _itemRating(seriesEntity)
        ],
      ),
    );
  }

  Widget _itemRating(SeriesEntity seriesEntity){
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        seriesEntity.voteAverage.toString(),
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

  Widget _itemImage(BuildContext context, SeriesEntity seriesEntity) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ seriesEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (seriesEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(seriesEntity.id, seriesEntity.type, seriesEntity.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle(SeriesEntity seriesEntity) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            seriesEntity.name,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context, SeriesEntity seriesEntity){
    return ButtonAddedArrowDown(ouevre: seriesEntity, type: seriesEntity.type, isUpdated: false, objectType: ConstantsTypeObject.serieEntity,);
  }


  





}