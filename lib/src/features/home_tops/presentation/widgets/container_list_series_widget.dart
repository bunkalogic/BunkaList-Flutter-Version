
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/bottom_loader_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/title_tops_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_series/selectionseries_bloc.dart';
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

  ScrollController _scrollController;
  bool isLoading = true;


  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }  

  


  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 300,
      child: Column(
        children: <Widget>[
          // titleListTop(widget.title, context),
          TitleTopsWidget(
            titleLabel: widget.title, 
            typeLabel:AppLocalizations.of(context).translate('series'),
            onTap: (){
              Navigator.pushNamed(context, '/TopList', arguments: 'tv');
            },
          ),
          SizedBox(height: 10.0,),
          Expanded(child: BlocBuilder<TopsSeriesBloc, TopsSeriesState>(
        //bloc: serviceLocator<TopsSeriesBloc>(),
        builder: (context, state) {
          if(state is EmptySeries){
            
            if(page == 1){

              BlocProvider.of<TopsSeriesBloc>(context)
              ..add(GetSeriesTops(widget.typeId, page));

            }

          }else if(state is LoadingSeries){

            return LoadingCustomWidget();

          }else if (state is LoadedSeries){
            
            isLoading = false;

            if(state.series.isNotEmpty){

            //     return Container(      
            //   child: CarouselSlider.builder(
            //     options: CarouselOptions(
            //       enlargeCenterPage: true, 
            //       aspectRatio: 16 / 9,
            //       autoPlay: false,
            //       viewportFraction: 0.35,
            //     ),
                
            //     itemCount: state.series.length,
            //     itemBuilder: (context, i, h) => ItemPosterSeries(state.series[i]),
            //   ),
            // );


            return NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification, 
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return i >= state.series.length
                      ? BottomLoader()
                      : ItemPosterSeries(state.series[i]);
                  } ,
                  itemCount: state.hasReachedMax
                        ? state.series.length
                        : state.series.length + 1,
                  itemExtent: 130,
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


  bool _handleScrollNotification(ScrollNotification notification){

    final offsetVisibleThreshold = 50;

    if(notification is ScrollEndNotification && 
      _scrollController.offset + offsetVisibleThreshold >=
      _scrollController.position.maxScrollExtent){

      isLoading = true;
      print('series page initial: $page');

      (!isLoading) ? page : page++;

      print('series page++: $page');

      BlocProvider.of<TopsSeriesBloc>(context)
      ..add(GetSeriesTops(widget.typeId, page));  

    }

    isLoading = false;
    return isLoading;

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }  



}


class ContainerListSelectionSeriesWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListSelectionSeriesWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListSelectionSeriesWidgetState createState() => _ContainerListSelectionSeriesWidgetState();
}

class _ContainerListSelectionSeriesWidgetState extends State<ContainerListSelectionSeriesWidget> {

  int page = 1;


  @override
  void initState() {
    BlocProvider.of<SelectionseriesBloc>(context)
    ..add(GetSelectionSeriesMonth(widget.typeId, page));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return new Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        children: <Widget>[
          TitleTopsWidget(
            titleLabel: widget.title, 
            typeLabel:AppLocalizations.of(context).translate('series'),
            onTap: (){
              Navigator.pushNamed(context, '/TopList', arguments: 'tv');
            },
          ),
          //titleListTop(widget.title, context),
          Expanded(child: BlocBuilder<SelectionseriesBloc, SelectionseriesState>(
        builder: (context, state) {
          if(state is SelectionseriesInitial){
            
            return LoadingCustomWidget();

          }else if(state is LoadingSelectionSeries){

            return LoadingCustomWidget();

          }else if (state is LoadedSelectionSeries){
            
              if(state.series.isNotEmpty){

                return Container(      
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  enlargeCenterPage: true, 
                 aspectRatio: 16 / 9,
                 autoPlay: false,
                 viewportFraction: 0.35,
                ),
                itemCount: state.series.length,
                itemBuilder: (context, i, h) => ItemPosterSeries(state.series[i]),
              ),
            );

             }else{
               return EmptyIconWidget();
             }


            
          }else if(state is ErrorSelectionSeries){
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
      title: Text(title, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }

}


class ItemPosterSeries extends StatelessWidget {
  final SeriesEntity seriesEntity;

  const ItemPosterSeries(this.seriesEntity);

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

  Widget _itemImage(BuildContext context) {

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ seriesEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (seriesEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(seriesEntity.id, seriesEntity.type, seriesEntity.name));
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle() {
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

  Widget _iconButton(BuildContext context){
    return ButtonAddedArrowDown(ouevre: seriesEntity, type: seriesEntity.type, isUpdated: false, objectType: ConstantsTypeObject.serieEntity,);
  }
}