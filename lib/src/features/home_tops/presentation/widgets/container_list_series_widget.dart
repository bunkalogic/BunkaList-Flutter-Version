import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/bottom_sheet_add_your_list_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class ContainerListSeriesWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListSeriesWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListSeriesWidgetState createState() => _ContainerListSeriesWidgetState();
}

class _ContainerListSeriesWidgetState extends State<ContainerListSeriesWidget> {

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

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
    
    _pageController.addListener( (){

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 15){
         
         BlocProvider.of<TopsSeriesBloc>(context).add(GetSeriesTops(widget.typeId));
      }

      //  if(_pageController.position.pixels >= _pageController.position.minScrollExtent - 10){
      //     if(widget.page != 0) widget.page--;
      // }

    });

    return new Container(
      height: MediaQuery.of(context).size.height / 2.8,
      child: Column(
        children: <Widget>[
          titleListTop(widget.title, context),
          Expanded(child: BlocBuilder<TopsSeriesBloc, TopsSeriesState>(
        //bloc: serviceLocator<TopsSeriesBloc>(),
        builder: (context, state) {
          if(state is Empty){
            
            return loadingPage;

          }else if(state is Loading){

            return loadingPage;

          }else if (state is Loaded){
            
              if(state.series.isNotEmpty){

                return Container(      
              child: PageView.builder(
                pageSnapping: false,
                controller: _pageController,
                itemCount: state.series.length,
                itemBuilder: (context, i) => _itemPoster(context, state.series[i]),
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
              
          
      ),
    ],
  ),
);  

     

//   return BlocProvider<TopsSeriesBloc>(
//     builder: (_) => serviceLocator<TopsSeriesBloc>(),
//     child: new Container(
//       height: MediaQuery.of(context).size.height / 3.2,
//       child: Column(
//         children: <Widget>[
//           titleListTop(widget.title, context),
//           Expanded(child: BlocBuilder<TopsSeriesBloc, TopsSeriesState>(
//         //bloc: serviceLocator<TopsSeriesBloc>(),
//         builder: (context, state) {
//           if(state is Empty){

            
            
//             return loadingPage;

//           }else if(state is Loading){

//             return loadingPage;

//           }else if (state is Loaded){
            
//             return Container(
      
//               child: PageView.builder(
//                 pageSnapping: false,
//                 controller: _pageController,
//                 itemCount: state.series.length,
//                 itemBuilder: (context, i) => _itemPoster(context, state.series[i]),
//               ),
//             );
//           }else if(state is Error){
//             return Text(state.message);
//           }
//           return Center(child: Text('something Error'));
//         },
//       ),
              
          
//       ),
//     ],
//   ),
// ),
// );  

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
              width: MediaQuery.of(context).size.width / 3.8,
              height: MediaQuery.of(context).size.height / 2.8,
            ),
          );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: GestureDetector(
          onTap: (){
            //! PushNamed Al ItemAllDetail
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(seriesEntity.id, seriesEntity.type));
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