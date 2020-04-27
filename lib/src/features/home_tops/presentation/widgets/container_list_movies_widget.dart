import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContainerListMoviesWidget extends StatefulWidget {
  final String title;
  final int typeId;
  
  
  
  ContainerListMoviesWidget({@required this.title, @required this.typeId });

  @override
  _ContainerListMoviesWidgetState createState() => _ContainerListMoviesWidgetState();
}

class _ContainerListMoviesWidgetState extends State<ContainerListMoviesWidget> {

  int page = 1;

  // final _pageController = new PageController(
  //   initialPage: 1,
  //   viewportFraction: 0.3,
  // );


  @override
  void initState() {
    BlocProvider.of<TopsMoviesBloc>(context)
    ..add(GetMoviesTops(widget.typeId, page));
    super.initState();
  }  


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   BlocProvider.of<TopsMoviesBloc>(context)
  //   ..add(GetMoviesTops(widget.typeId, page));
  // }
  

  @override
  Widget build(BuildContext context) {


    return new Container(
      height: MediaQuery.of(context).size.height / 2.6,
      child: Column(
        children: <Widget>[
          titleListTop(widget.title, context),
          Expanded(child: BlocBuilder<TopsMoviesBloc, TopsMoviesState>(
        //bloc: serviceLocator<TopsMoviesBloc>(),
        builder: (context, state) {
          if(state is EmptyMovies){

            return LoadingCustomWidget();

          }else if(state is LoadingMovies){

            return LoadingCustomWidget();

          }else if (state is LoadedMovies){
            
              if(state.movies.isNotEmpty){

               return Container(
      
              child: CarouselSlider.builder(
                enlargeCenterPage: true, 
                aspectRatio: 16 / 9,
                autoPlay: false,
                viewportFraction: 0.35,
                itemCount: state.movies.length,
                itemBuilder: (context, i) => _itemPoster(context, state.movies[i]),
              ),
            );

             }else{
               return EmptyIconWidget();
             }


            
          }else if(state is ErrorMovies){
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
        Navigator.pushNamed(context, '/TopList', arguments: 'movies');
      },
      title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800], fontSize: 16.0 ),),
    );
  }



  Widget _itemPoster(BuildContext context, MovieEntity movieEntity) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImageAndRating(context, movieEntity), flex: 4,),
          _itemTitle(movieEntity),
          Expanded(child: _iconButton(context, movieEntity), flex: 1,),
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

    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ movieEntity.posterPath }');

    //! Agregar el Hero
    final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (movieEntity.posterPath == null) ? placeholder : poster,  //? Image Poster Item,
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
            Navigator.pushNamed(context, '/AllDetails', arguments: getIdAndType(movieEntity.id, movieEntity.type, movieEntity.title));
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
    return ButtonAddedArrowDown(ouevre: movieEntity, type: movieEntity.type, isUpdated: false, objectType: ConstantsTypeObject.movieEntity,);
  }


  





}
  




  

  
  
  // void _dispatchTopId(BuildContext context, int topId, int page){
  //   switch (topId) {
  //     case Constants.topsMoviesPopularId:
  //       return BlocProvider.of<TopsMoviesBloc>(context).add(new GetMoviesTopsPopular(page));
  //       break;

  //     case Constants.topsMoviesRatedId:
  //       return BlocProvider.of<TopsMoviesBloc>(context).add(new GetMoviesTopsRated(page));
  //       break;

  //     case Constants.topsMoviesUpcommingId:
  //       return BlocProvider.of<TopsMoviesBloc>(context).add(new GetMoviesTopsUpcoming(page));
  //       break;  

  //     default: return BlocProvider.of<TopsMoviesBloc>(context).add(new GetMoviesTopsPopular(page));
  //   }
    

    
    
  // }