import 'dart:core';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';





class TopsScrollViewHorizontal extends StatefulWidget {  

  final List<Object> items;
  final VoidCallback page;
  final String type;

  TopsScrollViewHorizontal({@required this.items, @required this.page, @required this.type});

  @override
  _TopsScrollViewHorizontalState createState() => _TopsScrollViewHorizontalState();
}

class _TopsScrollViewHorizontalState extends State<TopsScrollViewHorizontal> {
  
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final movies  = widget.items.cast<MovieEntity>();


    _pageController.addListener( (){

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 15){
         widget.page();
      }

      //  if(_pageController.position.pixels >= _pageController.position.minScrollExtent - 10){
      //     if(widget.page != 0) widget.page--;
      // }

    });
    

    return Container(
      
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) => _itemPoster(context, movies[i]),
      ),
    );

  
  }

  Widget _itemPoster(BuildContext context, MovieEntity movieEntity) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, movieEntity), flex: 4,),
          _itemTitle(movieEntity),
          //Expanded(child: _iconButton(context, movieEntity), flex: 1,),
        ],
    );
  }

  Widget _itemImageAndRating(BuildContext context, MovieEntity movieEntity){
    return Container(
      child: Stack(
        children: <Widget>[
          _itemImage(context, movieEntity),
          _itemRating(movieEntity)
        ],
      ),
    );
  }

  Widget _itemRating(MovieEntity movieEntity){
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[400].withOpacity(0.3)
      ),
      child: Text(
        movieEntity.voteAverage.toString(),
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

  Widget _itemImage(BuildContext context, MovieEntity movieEntity) {

    final placeholder = NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc');
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ movieEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              image: (movieEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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

  Widget _itemTitle(MovieEntity movieEntity) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
            movieEntity.title,//? Title of Item
            style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
    );
      
  }

  Widget _iconButton(BuildContext context, MovieEntity movieEntity){
    //return ButtonAddedArrowDown(ouevre: movieEntity, type: movieEntity.type, isUpdated: false,);
  }
}  

// class TopsScrollViewHorizontal extends StatelessWidget {  

//   final int topId;
//   //final VoidCallback nextPage;

//   TopsScrollViewHorizontal({@required this.topId});

   

//   final _pageController = new PageController(
//     initialPage: 1,
//     viewportFraction: 0.3,
//   );

//   //TODO: refactorizar para que compruebe que tipo de lista es
  

//   @override
//   Widget build(BuildContext context) {

//     final loadingPage = Center(
//       child: CircularProgressIndicator(),
//     ) ;


//     _pageController.addListener( (){

//       if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 15){
//           _dispatchTopId(context, topId);
//       }

//     });

//     return Container(
//       child: BlocProvider(
//         create: (_) => serviceLocator<TopsMoviesBloc>(),
//         child: buildBlocBuilder(loadingPage),
//       ),
//     );
//   }

//   BlocBuilder<TopsMoviesBloc, TopsMoviesState> buildBlocBuilder(Center loadingPage) {
//     return BlocBuilder<TopsMoviesBloc, TopsMoviesState>(
//         builder: (context, state) {
//           if(state is Empty){
//             _dispatchTopId(context, topId);
//             return loadingPage;
//           }else if(state is Loading){
//             return loadingPage;
//           }else if (state is Loaded){
//             //! cambiar por el TopsScrollViewHorizontal
//             return Container(
//               child: PageView.builder(
//               pageSnapping: true,
//               controller: _pageController,
//               itemCount: state.movies.length,
//               itemBuilder: (context, i) => _itemPoster(context, state.movies[i]),
//               ),
//           );
//           }else if(state is Error){
//             return Text(state.message);
//           }
//           return Center(child: Text('something Error'));
//         },
//       );
//   }

//   void _dispatchTopId(BuildContext context, int topId){
//     //BlocProvider.of<TopsMoviesBloc>(context).dispatch(new GetMoviesTops(topId));
//     BlocProvider.of<TopsMoviesBloc>(context).add(new GetMoviesTops(topId));

    
    
//   }


//   //! Item Poster

//   Widget _itemPoster(BuildContext context, MovieEntity movieEntity) {
//     return Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Expanded(child: _itemImageAndRating(context, movieEntity), flex: 4,),
//           _itemTitle(movieEntity),
//           Expanded(child: _iconButton(context), flex: 1,),
//         ],
//     );
//   }

//   Widget _itemImageAndRating(BuildContext context, MovieEntity movieEntity){
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           _itemImage(context, movieEntity),
//           _itemRating(movieEntity)
//         ],
//       ),
//     );
//   }

//   Widget _itemRating(MovieEntity movieEntity){
//     return Container(
//       margin: EdgeInsets.all(6.0),
//       padding: EdgeInsets.all(2.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.0),
//         color: Colors.grey[400].withOpacity(0.3)
//       ),
//       child: Text(
//         movieEntity.voteAverage.toString(),
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16.0,
//           fontWeight: FontWeight.w800,
//           shadows: [
//            Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
//           ]
//           ),
//       ),
//     );
//   }

  
//   Widget _itemImage(BuildContext context, MovieEntity movieEntity) {

//     final placeholder = NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshqcXT2iUjDuVOWCIyEnY_yrAjXPCE0LpuBOjlhADKLBTdTFc');
//     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ movieEntity.posterPath }');


//     //! Agregar el Hero
//     final _poster = ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             child: FadeInImage(
//               image: (movieEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
//               placeholder: placeholder, //? PlaceHolder Item,
//               fit: BoxFit.cover,
//               width: MediaQuery.of(context).size.width / 4.0,
//               height: MediaQuery.of(context).size.height / 3.0,
//             ),
//           );

//     return Container(
//       //margin: EdgeInsets.only(right: 25.0),
//       child: GestureDetector(
//           onTap: (){
//             //! PushNamed Al ItemAllDetail
//             Navigator.pushNamed(context, '/AllDetails', arguments: 1);
//           },
//           child: _poster 
//       ),
//     );
//   }

//   Widget _itemTitle(MovieEntity movieEntity) {
//     return Text(
//           movieEntity.title,//? Title of Item
//           style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
//           textAlign: TextAlign.center,
//           overflow: TextOverflow.ellipsis,
//         );
      
//   }

//   Widget _iconButton(BuildContext context){
//     return PlatformIconButton(
//           iosIcon: Icon(CupertinoIcons.down_arrow, size: 25.0,),
//           androidIcon: Icon(Icons.keyboard_arrow_down, size: 25.0,),
//           onPressed: (){
//             BottomSheetAddInList().showButtomModalMaterial(context);
//           },
//         );
//   }


  

// }  