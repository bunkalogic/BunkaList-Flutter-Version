
import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series_air_month/seriesair_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselSeriesInMonthWidget extends StatefulWidget {

  @override
  _CarouselSeriesInMonthWidgetState createState() => _CarouselSeriesInMonthWidgetState();
}

class _CarouselSeriesInMonthWidgetState extends State<CarouselSeriesInMonthWidget> {

  
  @override
  void initState() {
     BlocProvider.of<SeriesAirBloc>(context)
    ..add(GetSeriesAirInMonth(Constants.topsSeriesMonthId, 1));
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.8,
      child: BlocBuilder<SeriesAirBloc, SeriesAirState>(
        builder: (context, state) {
          if(state is SeriesAirInitial){
              
              return LoadingCustomWidget();

            }else if(state is LoadingSeries){

              return LoadingCustomWidget();

            }else if (state is LoadedSeries){
              
                if(state.series.isNotEmpty){

                  return Container(      
                  child: CarouselSlider.builder(
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                    autoPlay: false,
                    itemCount: state.series.length,
                    itemBuilder: (context, i) => _cardItemBuilder(context, state.series[i]),
                  ),
              );

               }else{
                 return EmptyIconWidget();
               }


              
            }else if(state is ErrorSeries){
              return EmptyIconWidget();
            }
            return EmptyIconWidget();
        },
      ),
    );
  }

  Widget _cardItemBuilder(BuildContext context, SeriesEntity serie) {
    return Card(
      elevation: 15.0,
      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 20.0
      ),
      color: Colors.transparent,
      child: Container(
        child: _stackTextAndIcon(context, serie),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        ) 
      ),

    );
  }

  Widget _stackTextAndIcon(BuildContext context, SeriesEntity serie) {
    return Stack(
      children: <Widget>[
        _imageBackground(context, serie),
        _itemRating(serie),
        _nameItem(serie),
        _buttonItem(context, serie)
      ],
    );
  }

  Widget _itemRating(SeriesEntity serie){
    return Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        serie.voteAverage.toString(),
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

  Widget _imageBackground(BuildContext context, SeriesEntity serie) {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ serie.backdropPath }');

    //! Agregar el Hero
    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(serie.id, serie.type, serie.name));
      },
      child: Container(
        width: double.infinity,
        child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: (serie.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
                  placeholder: placeholder, //? PlaceHolder Item,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );



  }


  Widget _nameItem(SeriesEntity serie){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
              serie.name,//? Title of Item
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

  Widget _buttonItem(BuildContext context, SeriesEntity serie){
    return Align(
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: (){
          return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: serie,
              type: serie.type,
              objectType: ConstantsTypeObject.serieEntity
            ).showBottomModal();
        },
        heroTag: null,
        elevation: 10.0,
        mini: true,
        child: Icon(Icons.add, color: Colors.deepOrangeAccent[400], size: 20.0,),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: Colors.deepOrangeAccent[400],
            width: 2.0
          ),
        ),
      ),
    );
  }
}