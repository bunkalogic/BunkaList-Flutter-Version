import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/login/data/datasources/get_guest_sesion_id_data_remote_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/build_bottom_watch_provider_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/images_background_silder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsHeaderInfo extends StatefulWidget  {
  
  final int id;
  final String type;

  AllDetailsHeaderInfo({@required this.id, @required this.type});

  @override
  _AllDetailsHeaderInfoState createState() => _AllDetailsHeaderInfoState();
}

class _AllDetailsHeaderInfoState extends State<AllDetailsHeaderInfo> {


  @override
  void initState() {
    BlocProvider.of<OuevreDetailsBloc>(context)
    ..add(GetDetailsOuevre(widget.id, widget.type));
    super.initState();
  } 


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
      builder: (context, state) {
        
        if(state is Empty){

          return LoadingCustomWidget();

        }else if(state is Loading){
          
          return LoadingCustomWidget();

        }else if(state is LoadedMovie){

          return HeaderInfoMovie(movie: state.movie,);

        }else if(state is LoadedSerie){

          return HeaderInfoSerie(serie: state.serie,);

        }else if(state is LoadedAnime){

          return HeaderInfoAnime(anime: state.anime,);

        }else if(state is Error){
          
          return Center(
            child: Text(state.message),
          );

        }

        return Center(
            child: Text('something Error'),
          );

      },
    );
  }
}

class HeaderInfoMovie  extends StatelessWidget {

  final MovieDetailsEntity movie;

  HeaderInfoMovie({@required this.movie});

  final Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    
    return FlexibleSpaceBar(
    stretchModes: <StretchMode>[
      StretchMode.zoomBackground,
      // StretchMode.blurBackground,
      // StretchMode.fadeTitle
    ],       
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, movie),
    centerTitle: true,
    titlePadding: const EdgeInsets.only(bottom: 12.0),
    title: _titleInfo(context ,movie),
  );
  }

  

  Widget _titleInfo(BuildContext context, MovieDetailsEntity movie){

    final mediaQuery = MediaQuery.of(context);

    final availableWidth = mediaQuery.size.width - 120;

    List<Shadow> shadowBlack = [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))];
    List<Shadow> shadowWhite = [Shadow(blurRadius: 1.0, color:  Colors.white, offset: Offset(0.3, 0.3))];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: availableWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Text(
            (movie.title == null) ? movie.originalTitle : movie.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadowBlack //prefs.whatModeIs ? shadowBlack : shadowWhite,
            ),
          ),
      ),
    );
  }


   Widget _subtitleInfo(){
    final String duration = (movie.runtime == null) ? "00 min." : movie.runtime.toString() + " min.";

    final String realeaseDate = (movie.releaseDate == null || movie.releaseDate == '' ) ? "No date" : DateTime.parse(movie.releaseDate).year.toString();  

    final String status = movie.status;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Text(
          ' $realeaseDate  -  $status  -  $duration ',
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 16.0,
            shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))],
            fontWeight: FontWeight.w600 
          ),
        ),
      ),
    );

  }

  

  _stackInfoBackground(BuildContext context,MovieDetailsEntity movie) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          // _imageBackground(movie),
          BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: ImagesBackgroundSlider(id: movie.id, type: movie.type),
          ),
        
          // _containerGradient(),
          // _columnBackground(context, movie), 
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: ButtonStreamingVideo(id: movie.id, type: movie.type),
            ),
          ),
          _subtitleInfo(),
          _containerRounded()
        ],
      ),
    );
  }

  Widget _imageBackground(MovieDetailsEntity movie) {
     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ movie.backdropPath }');


    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FadeInImage(
          image: (movie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
    );

  }

  Widget _containerRounded(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: getBackgroundColorTheme(),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25)
          )
        ),
        
        height: 50.0,
      ),
    );
  }

  // Widget _containerGradient(){

  //   List<Color> colorsThemeDark = [
  //     Colors.blueGrey[800].withOpacity(0.1),
  //     Colors.blueGrey[800].withOpacity(0.3),
  //     Colors.blueGrey[800].withOpacity(0.5),
  //     Colors.blueGrey[800].withOpacity(0.5),
  //     Colors.blueGrey[800].withOpacity(0.7),
  //     Colors.blueGrey[900].withOpacity(0.9),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //   ]; 

  //   List<Color> colorsThemeDarker = [
  //     Colors.grey[850].withOpacity(0.1),
  //     Colors.grey[850].withOpacity(0.3),
  //     Colors.grey[850].withOpacity(0.5),
  //     Colors.grey[850].withOpacity(0.5),
  //     Colors.grey[850].withOpacity(0.7),
  //     Colors.grey[900].withOpacity(0.9),
  //     Colors.grey[900].withOpacity(1.0),
  //     Colors.grey[900].withOpacity(1.0),
  //     Colors.black87.withOpacity(1.0),
  //   ]; 

  //   List<Color> colorsThemeDay = [
  //     Colors.grey[100].withOpacity(0.3),
  //     Colors.grey[100].withOpacity(0.3),
  //     Colors.grey[100].withOpacity(0.5),
  //     Colors.grey[100].withOpacity(0.5),
  //     Colors.grey[100].withOpacity(0.7),
  //     Colors.grey[50].withOpacity(0.9),
  //     Colors.grey[50].withOpacity(1.0),
  //     Colors.grey[50].withOpacity(1.0),
  //     Colors.white70.withOpacity(1.0),
  //   ]; 

  //   return SizedBox(
  //     height: 600.0,
  //     child: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             tileMode: TileMode.clamp,
  //             begin: Alignment.center,
  //             end: Alignment.bottomCenter,
  //             colors: prefs.whatModeIs ? prefs.whatDarkIs ? colorsThemeDarker : colorsThemeDark : colorsThemeDay,
  //           ),
  //         ),
  //     ),
  //   );
  // }

  

  

  // Widget _columnBackground(BuildContext context,MovieDetailsEntity movie) {
  //   return SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 10.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             // _infoPoster(context, movie),
  //             // _durationInfo(movie),
  //             // _buttonAddInList(context, movie),
  //               SizedBox(width: 5.0,),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   _durationInfo(movie),
  //                   // _buttonAddInList(context, movie),
  //                 ],
  //               ),
  //           ],
  //         ),
  //       ),
  //   ); 
  // }

  // Widget _buttonAddInList(BuildContext context,MovieDetailsEntity movie){
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: OutlineButton(
  //         child: Text(
  //           AppLocalizations.of(context).translate("add_in_list"),
  //           style: TextStyle(
  //             color: Colors.white,
  //             shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
  //           ),
  //         ),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  //         borderSide: BorderSide(width: 2.5, color: Colors.pink),
  //         onPressed: (){
            
  //           return ButtonClikedAdded(
  //             context: context,
  //             isUpdated: false,
  //             ouevre: movie,
  //             type: movie.type,
  //             objectType: ConstantsTypeObject.movieDetailsEntity
  //           ).showBottomModal();
  //         },
  //     ),
  //   );
  // }

  // Widget _infoPoster(BuildContext context, MovieDetailsEntity movie) {

  //   final placeholder = AssetImage('assets/poster_placeholder.png'); 
  //    final poster = NetworkImage('https://image.tmdb.org/t/p/w185${ movie.posterPath }');

  
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 28.0),
  //     child: Container(
  //         width: MediaQuery.of(context).size.width / 4.5,
  //         height: 140.0,
  //         alignment: Alignment.center,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(8.0),
  //           child: FadeInImage(
  //             image: (movie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
  //             placeholder: placeholder, //? PlaceHolder Item,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //     ),
  //   );
  // }


  // Widget _durationInfo(MovieDetailsEntity movie) {
    
  //   String runtime = (movie.runtime == null) ? "00 min." : movie.runtime.toString() + " min.";


  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 2.0),
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(Icons.today,color: Colors.deepPurpleAccent[400], size: 28.0, ),
  //           SizedBox(width: 3.0,),
  //           _yearInfo(movie),
  //           SizedBox(width: 8.0),
  //           Icon(Icons.timer,color: Colors.deepPurpleAccent[400], size: 28.0, ),
  //           SizedBox(width: 3.0,),
  //           Text(
  //              runtime, 
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16.0,
  //               shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ] 
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _yearInfo(MovieDetailsEntity movie) {

  //   String realeaseDate = (movie.releaseDate == null) ? "No date" : DateTime.parse(movie.releaseDate).year.toString();

  //   return Text(
  //        realeaseDate,
  //       style: TextStyle(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.w600,
  //         fontStyle: FontStyle.italic,
  //         color: Colors.white,
  //         shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ]
  //       ),
  //     );
  // }

  


}

class HeaderInfoSerie  extends StatelessWidget {
  
  final SerieDetailsEntity serie;

  HeaderInfoSerie({@required this.serie});

  final Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    
    return _buildFlexibleSpaceBar(context, serie);
  }

  Widget _buildFlexibleSpaceBar(BuildContext context, SerieDetailsEntity serie) {
    return FlexibleSpaceBar(
    stretchModes: <StretchMode>[
      StretchMode.zoomBackground,
      // StretchMode.blurBackground,
      // StretchMode.fadeTitle
    ],      
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, serie),
    centerTitle: true,
    titlePadding: const EdgeInsets.only(bottom: 12.0),
    title: _titleInfo(context, serie),
  );
  }

  Widget _titleInfo(BuildContext context, SerieDetailsEntity serie){
    final mediaQuery = MediaQuery.of(context);

    final availableWidth = mediaQuery.size.width - 120;

    List<Shadow> shadowBlack = [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))];
    List<Shadow> shadowWhite = [Shadow(blurRadius: 1.0, color:  Colors.white, offset: Offset(0.3, 0.3))];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: availableWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Text(
            (serie.name == null) ? serie.originalName : serie.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadowBlack  //prefs.whatModeIs ? shadowBlack : shadowWhite,
            ),
          ),
      ),
    );
  }

   Widget _subtitleInfo(){
    final String duration = (serie.episodeRunTime.isEmpty || serie.firstAirDate == '' ) ? 'no info' : '${serie.episodeRunTime[0].toString()} min.';

    final String realeaseDate = (serie.firstAirDate == null) ? "No date" : DateTime.parse(serie.firstAirDate).year.toString();  

    final String status = serie.status;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Text(
          ' $realeaseDate  -  $status  -  $duration ',
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 16.0,
            shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))],
            fontWeight: FontWeight.w600 
          ),
        ),
      ),
    );

  }

  

  _stackInfoBackground(BuildContext context, SerieDetailsEntity serie) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: ImagesBackgroundSlider(id: serie.id, type: serie.type),
          ),
          // _imageBackground(serie),
          //_containerGradient(),
          // _columnBackground(context, serie),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: ButtonStreamingVideo(id: serie.id, type: serie.type),
            ),
          ),
          _subtitleInfo(),
          _containerRounded() 
        ],
      ),
    );
  }

  Widget _imageBackground(SerieDetailsEntity serie) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ serie.backdropPath }');

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child:FadeInImage(
          image: (serie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
    );

  }

  Widget _containerRounded(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: getBackgroundColorTheme(),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25)
          )
        ),
        
        height: 50.0,
      ),
    );
  }

  // Widget _containerGradient(){

  //   List<Color> colorsThemeDark = [
  //     Colors.blueGrey[800].withOpacity(0.1),
  //     Colors.blueGrey[800].withOpacity(0.3),
  //     Colors.blueGrey[800].withOpacity(0.5),
  //     Colors.blueGrey[800].withOpacity(0.5),
  //     Colors.blueGrey[800].withOpacity(0.7),
  //     Colors.blueGrey[900].withOpacity(0.9),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //   ]; 

  //   List<Color> colorsThemeDarker = [
  //     Colors.grey[850].withOpacity(0.1),
  //     Colors.grey[850].withOpacity(0.3),
  //     Colors.grey[850].withOpacity(0.5),
  //     Colors.grey[850].withOpacity(0.5),
  //     Colors.grey[850].withOpacity(0.7),
  //     Colors.grey[900].withOpacity(0.9),
  //     Colors.grey[900].withOpacity(1.0),
  //     Colors.grey[900].withOpacity(1.0),
  //     Colors.black87.withOpacity(1.0),
  //   ]; 

  //   List<Color> colorsThemeDay = [
  //     Colors.grey[100].withOpacity(0.3),
  //     Colors.grey[100].withOpacity(0.3),
  //     Colors.grey[100].withOpacity(0.5),
  //     Colors.grey[100].withOpacity(0.5),
  //     Colors.grey[100].withOpacity(0.7),
  //     Colors.grey[50].withOpacity(0.9),
  //     Colors.grey[50].withOpacity(1.0),
  //     Colors.grey[50].withOpacity(1.0),
  //     Colors.white70.withOpacity(1.0),
  //   ]; 

  //   return SizedBox(
  //     height: 600.0,
  //     child: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             tileMode: TileMode.clamp,
  //             begin: Alignment.center,
  //             end: Alignment.bottomCenter,
  //             colors: prefs.whatModeIs ? prefs.whatDarkIs ? colorsThemeDarker : colorsThemeDark : colorsThemeDay,
  //           ),
  //         ),
  //     ),
  //   );
  // }

  

  

  // Widget _columnBackground(BuildContext context, SerieDetailsEntity serie) {
  //  return SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 10.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             _infoPoster(context, serie),
  //             // _durationInfo(movie),
  //             // _buttonAddInList(context, movie),
  //               SizedBox(width: 5.0,),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   _durationInfo(serie),
  //                   // _buttonAddInList(context, serie),
  //                 ],
  //               ),
  //           ],
  //         ),
  //       ),
  //   ); 
  // }

  // Widget _buttonAddInList(BuildContext context, SerieDetailsEntity serie){
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: OutlineButton(
  //         child: Text(
  //           AppLocalizations.of(context).translate("add_in_list"),
  //           style: TextStyle(
  //             color: Colors.white,
  //             shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
  //           ),
  //         ),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  //         borderSide: BorderSide(width: 2.5, color: Colors.pink),
  //         onPressed: (){
  //            return ButtonClikedAdded(
  //             context: context,
  //             isUpdated: false,
  //             ouevre: serie,
  //             type: serie.type,
  //             objectType: ConstantsTypeObject.serieDetailsEntity
  //           ).showBottomModal();
  //         },
  //     ),
  //   );
  // }

  // Widget _infoPoster(BuildContext context, SerieDetailsEntity serie) {

  //   final placeholder = AssetImage('assets/poster_placeholder.png'); 
  //   final poster = NetworkImage('https://image.tmdb.org/t/p/w185${ serie.posterPath }');
  
  //   return Container(
  //     margin: const EdgeInsets.all(4.0),
  //     child: Container(
  //         width: MediaQuery.of(context).size.width / 4.5,
  //         height: 140.0,
  //         alignment: Alignment.bottomCenter,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(8.0),
  //           child: FadeInImage(
  //         image: (serie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
  //         placeholder: placeholder, //? PlaceHolder Item,
  //         fit: BoxFit.fill,
  //       ),
  //         ),
  //     ),
  //   );
  // }


  // Widget _durationInfo(SerieDetailsEntity serie) {
  //   final time = 
  //   (serie.episodeRunTime.isEmpty) ? 'no info' : serie.episodeRunTime[0].toString();

  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 2.0),
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(Icons.today,color: Colors.deepPurpleAccent[400], size: 28.0, ),
  //           SizedBox(width: 3.0,),
  //           _yearInfo(serie),
  //           SizedBox(width: 8.0),
  //           Icon(Icons.timer,color: Colors.deepPurpleAccent[400], size: 28.0, ),
  //           SizedBox(width: 3.0,),
  //           Text(
  //             time + ' min.', 
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16.0,
  //               shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ] 
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _yearInfo(SerieDetailsEntity serie) {

  //   String realeaseDate = (serie.firstAirDate == null) ? "No date" : DateTime.parse(serie.firstAirDate).year.toString();

  //   return Text(
  //      realeaseDate, 
  //       style: TextStyle(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.w600,
  //         fontStyle: FontStyle.italic,
  //         color: Colors.white,
  //         shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ]
  //       ),
  //     );
  // }

  


}

class HeaderInfoAnime extends StatelessWidget {
  
  final AnimeDetailsEntity anime;

  HeaderInfoAnime({@required this.anime});
  

  final Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    
    return _buildFlexibleSpaceBar(context, anime);
  }

  Widget _buildFlexibleSpaceBar(BuildContext context, AnimeDetailsEntity anime) {
    return FlexibleSpaceBar(
    stretchModes: <StretchMode>[
      StretchMode.zoomBackground,
      // StretchMode.blurBackground,
      // StretchMode.fadeTitle
    ],          
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, anime),
    centerTitle: true,
    titlePadding: const EdgeInsets.only(bottom: 12.0),
    title: _titleInfo(context ,anime),
  );
  }

  Widget _titleInfo(BuildContext context, AnimeDetailsEntity anime){
   final mediaQuery = MediaQuery.of(context);

    final availableWidth = mediaQuery.size.width - 120;

    List<Shadow> shadowBlack = [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))];
    List<Shadow> shadowWhite = [Shadow(blurRadius: 1.0, color:  Colors.white, offset: Offset(0.3, 0.3))];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: availableWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Text(
            (anime.name == null) ? anime.originalName : anime.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadowBlack //prefs.whatModeIs ? shadowBlack : shadowWhite,
            ),
          ),
      ),
    );
  }


  Widget _subtitleInfo(){
    final String duration = (anime.episodeRunTime.isEmpty) ? 'no info' : '${anime.episodeRunTime[0].toString()} min.';

    final String realeaseDate = (anime.firstAirDate == null || anime.firstAirDate == '' ) ? "No date" : DateTime.parse(anime.firstAirDate).year.toString();  

    final String status = anime.status;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Text(
          ' $realeaseDate  -  $status  -  $duration ',
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 16.0,
            shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))],
            fontWeight: FontWeight.w600 
          ),
        ),
      ),
    );

  }

  

  _stackInfoBackground(BuildContext context, AnimeDetailsEntity anime) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: ImagesBackgroundSlider(id: anime.id, type: anime.type),
          ),
          //_imageBackground(anime),
          // _containerGradient(),
          // _columnBackground(context, anime),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: ButtonStreamingVideo(id: anime.id, type: anime.type),
            ),
          ),
          _subtitleInfo(),
          _containerRounded()
        ],
      ),
    );
  }

  Widget _containerRounded(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: getBackgroundColorTheme(),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25)
          )
        ),
        
        height: 50.0,
      ),
    );
  }

  Widget _imageBackground(AnimeDetailsEntity anime) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ anime.backdropPath }');

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child:FadeInImage(
          image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
    );

  }

  // Widget _containerGradient(){

  //   List<Color> colorsThemeDark = [
  //     Colors.blueGrey[800].withOpacity(0.1),
  //     Colors.blueGrey[800].withOpacity(0.3),
  //     Colors.blueGrey[800].withOpacity(0.5),
  //     Colors.blueGrey[800].withOpacity(0.5),
  //     Colors.blueGrey[800].withOpacity(0.7),
  //     Colors.blueGrey[900].withOpacity(0.9),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //     Colors.blueGrey[900].withOpacity(1.0),
  //   ]; 

  //   List<Color> colorsThemeDarker = [
  //     Colors.grey[850].withOpacity(0.1),
  //     Colors.grey[850].withOpacity(0.3),
  //     Colors.grey[850].withOpacity(0.5),
  //     Colors.grey[850].withOpacity(0.5),
  //     Colors.grey[850].withOpacity(0.7),
  //     Colors.grey[900].withOpacity(0.9),
  //     Colors.grey[900].withOpacity(1.0),
  //     Colors.grey[900].withOpacity(1.0),
  //     Colors.black87.withOpacity(1.0),
  //   ]; 

  //   List<Color> colorsThemeDay = [
  //     Colors.grey[100].withOpacity(0.3),
  //     Colors.grey[100].withOpacity(0.3),
  //     Colors.grey[100].withOpacity(0.5),
  //     Colors.grey[100].withOpacity(0.5),
  //     Colors.grey[100].withOpacity(0.7),
  //     Colors.grey[50].withOpacity(0.9),
  //     Colors.grey[50].withOpacity(1.0),
  //     Colors.grey[50].withOpacity(1.0),
  //     Colors.white70.withOpacity(1.0),
  //   ]; 

  //   return SizedBox(
  //     height: 600.0,
  //     child: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             tileMode: TileMode.clamp,
  //             begin: Alignment.center,
  //             end: Alignment.bottomCenter,
  //             colors: prefs.whatModeIs ? prefs.whatDarkIs ? colorsThemeDarker : colorsThemeDark : colorsThemeDay,
  //           ),
  //         ),
  //     ),
  //   );
  // }

  

  

  // Widget _columnBackground(BuildContext context, AnimeDetailsEntity anime) {
  //   return SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 10.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             _infoPoster(context, anime),
  //             // _durationInfo(anime),
  //             // _buttonAddInList(context, anime),
  //               SizedBox(width: 5.0,),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   _durationInfo(anime),
  //                   //_buttonAddInList(context, anime),
  //                 ],
  //               ),
  //           ],
  //         ),
  //       ),
  //   ); 
  // }

  // Widget _buttonAddInList(BuildContext context, AnimeDetailsEntity anime){
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: OutlineButton(
  //         child: Text(
  //           AppLocalizations.of(context).translate("add_in_list"),
  //           style: TextStyle(
  //             color: Colors.white,
  //             shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
  //           ),
  //         ),
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  //         borderSide: BorderSide(width: 2.5, color: Colors.pink),
  //         onPressed: (){
  //            return ButtonClikedAdded(
  //             context: context,
  //             isUpdated: false,
  //             ouevre: anime,
  //             type: anime.type,
  //             objectType: ConstantsTypeObject.animeDetailsEntity
  //           ).showBottomModal();
  //         },
  //     ),
  //   );
  // }

  // Widget _infoPoster(BuildContext context, AnimeDetailsEntity anime) {

  //   final placeholder = AssetImage('assets/poster_placeholder.png'); 
  //   final poster = NetworkImage('https://image.tmdb.org/t/p/w185${ anime.posterPath }');
  
  //   return Container(
  //     margin: const EdgeInsets.all(2.0),
  //     child: Container(
  //         width: MediaQuery.of(context).size.width / 4.5,
  //         height: 140.0,
  //         alignment: Alignment.bottomCenter,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(8.0),
  //           child: FadeInImage(
  //         image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
  //         placeholder: placeholder, //? PlaceHolder Item,
  //         fit: BoxFit.fill,
  //       ),
  //         ),
  //     ),
  //   );
  // }


  // Widget _durationInfo(AnimeDetailsEntity anime) {

  //   final time = 
  //   (anime.episodeRunTime.isEmpty) ? 'no info' : anime.episodeRunTime[0].toString();

  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 2.0),
  //     child: Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(Icons.today,color: Colors.deepPurpleAccent[400], size: 28.0, ),
  //           SizedBox(width: 3.0,),
  //           _yearInfo(anime),
  //           SizedBox(width: 8.0),
  //           Icon(Icons.timer,color: Colors.deepPurpleAccent[400], size: 28.0, ),
  //           SizedBox(width: 3.0,),
  //           Text(
  //             time + ' min.', 
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16.0,
  //               shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ] 
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _yearInfo(AnimeDetailsEntity anime) {

  //   String realeaseDate = (anime.firstAirDate == null) ? "No date" : DateTime.parse(anime.firstAirDate).year.toString();

  //   return Text(
  //       realeaseDate, 
  //       style: TextStyle(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.w600,
  //         fontStyle: FontStyle.italic,
  //         color: Colors.white,
  //         shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ]
  //       ),
  //     );
  // }
  


}


class ButtonStreamingVideo extends StatefulWidget {
  
  final int id;
  final String type;

  ButtonStreamingVideo({@required this.id, @required this.type});

  @override
  _ButtonStreamingVideoState createState() => _ButtonStreamingVideoState();
}

class _ButtonStreamingVideoState extends State<ButtonStreamingVideo> {
  
  Preferences prefs = Preferences();

  @override
  Widget build(BuildContext context) {

    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      side: BorderSide(
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        width: 2.5
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(6.0)
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 8.0
      ),
      child: OutlinedButton(
        onPressed: (){
          
          
          showModalBottomSheet(
              isScrollControlled: true,
              elevation: 10.0,
              isDismissible: false,
              barrierColor: Colors.blueGrey.withOpacity(0.3),
              backgroundColor: getBackgroundColorTheme(), 
              context: context,
              builder: (_) =>  BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: BuildBottomWatchProviderWidget(id: widget.id, type: widget.type),
          ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30)
                )
              )
            );
          
        },
        style: outlineButtonStyle,
        child: Text(
          AppLocalizations.of(context).translate("label_btn_streaming"),
          style: TextStyle(
            color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 0.5, offset: Offset(0.3, 0.3) )
            ]
          ),
          ),
      ),
    );
  }

  

}