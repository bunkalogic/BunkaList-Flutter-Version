import 'package:bunkalist/src/core/reusable_widgets/bottom_sheet_add_your_list_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class GridViewListSeriesWidget extends StatefulWidget {
  final int typeId;

  GridViewListSeriesWidget({@required this.typeId});

  @override
  _GridViewListSeriesWidgetState createState() => _GridViewListSeriesWidgetState();
}

class _GridViewListSeriesWidgetState extends State<GridViewListSeriesWidget> {


  final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TopsSeriesBloc>(context)
    ..add(GetSeriesTops(widget.typeId));
  }



  @override
  Widget build(BuildContext context) {

    //final double _aspectRatioOriginal = 5.4 / 7.8;
    final double _aspectRatio =  2.8 / 4.1;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<TopsSeriesBloc, TopsSeriesState>(
        //bloc: serviceLocator<TopsSeriesBloc>(),
        builder: (context, state) {
          if(state is Empty){

            
            
            return loadingPage;

          }else if(state is Loading){

            return loadingPage;

          }else if (state is Loaded){
            
              if(state.series.isNotEmpty){

                return Container(      
                  child: GridView.builder(
                  itemBuilder: (context, i) => _itemPoster(context, state.series[i]),  //itemPoster(context),
                  itemCount: state.series.length ,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: _aspectRatio
                    ),
                  ),
            );

             }else{
               return Center(child: Text('No Series TV Found'));
             }


            
          }else if(state is Error){
            return Text(state.message);
          }
          return Center(child: Text('something Error'));
        },
      ), 
    );
  }

  Widget _itemPoster(BuildContext context, SeriesEntity seriesEntity) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, seriesEntity), flex: 4,),
          _itemTitle(seriesEntity),
          Expanded(child: _iconButton(context), flex: 1,),
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
              width: MediaQuery.of(context).size.width / 4.0,
              height: MediaQuery.of(context).size.height / 3.0,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: 1);
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