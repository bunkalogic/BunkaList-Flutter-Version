import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
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

   final loadingPage = Center(
      child: CircularProgressIndicator(),
    ) ;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<OuevreDetailsBloc>(context)
    ..add(GetDetailsOuevre(widget.id, widget.type));
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
        builder: (context, state) {
          
          if(state is Empty){

            return loadingPage;

          }else if(state is Loading){
            
            return loadingPage;

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
      ),
    );
  }
}

class HeaderInfoMovie  extends StatelessWidget {

  final MovieDetailsEntity movie;

  HeaderInfoMovie({@required this.movie});
  
  @override
  Widget build(BuildContext context) {
    
    return _buildFlexibleSpaceBar(context, movie);
  }

  Widget _buildFlexibleSpaceBar(BuildContext context, MovieDetailsEntity movie) {
    return FlexibleSpaceBar(    
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, movie),
    centerTitle: true,
    titlePadding: EdgeInsets.only(bottom: 60.0),
    title: _titleInfo(movie),
  );
  }

  Widget _titleInfo(MovieDetailsEntity movie){
    return Text(
        (movie.title == null) ? movie.originalTitle : movie.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent[400],
          shadows: [Shadow(blurRadius: 1.0, color: Colors.grey[850], offset: Offset(1.0, 1.0))],
        ),
      );
  }

  

  _stackInfoBackground(BuildContext context,MovieDetailsEntity movie) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _imageBackground(movie),
          //_containerGradient(),
          _columnBackground(context, movie), 
        ],
      ),
    );
  }

  Widget _containerGradient(){
    return SizedBox(
      height: 550.0,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [
                //TODO que sea dependiendo del tema que esta selecionado
                Colors.grey[100].withOpacity(0.0),
                Colors.grey[100].withOpacity(0.5),
                Colors.grey[100].withOpacity(0.9),

              ]
            ),
          ),
      ),
    );
  }

  Widget _imageBackground(MovieDetailsEntity movie) {
     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ movie.backdropPath }');


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

  

  Widget _columnBackground(BuildContext context,MovieDetailsEntity movie) {
    return SafeArea(
        child: Column(
          
          children: <Widget>[
            _infoPoster(context, movie),
            _buttonAddInList(context, movie),
            _durationInfo(movie),
            
          ],
        ),
    ); 
  }

  Widget _buttonAddInList(BuildContext context,MovieDetailsEntity movie){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlineButton(
          child: Text(
            'Add in your List',
            style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
          onPressed: (){
            
            return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: movie,
              type: movie.type,
              objectType: ConstantsTypeObject.movieDetailsEntity
            ).showBottomModal();
          },
      ),
    );
  }

  Widget _infoPoster(BuildContext context, MovieDetailsEntity movie) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ movie.posterPath }');

  // TODO: Agregar el HERO
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Container(
          width: MediaQuery.of(context).size.width / 5.0,
          height: 120.0,
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: (movie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.fill,
            ),
          ),
      ),
    );
  }


  Widget _durationInfo(MovieDetailsEntity movie) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.today,color: Colors.purpleAccent[700], size: 28.0, ),
            SizedBox(width: 2.0,),
            _yearInfo(movie),
            SizedBox(width: 8.0),
            Icon(Icons.timer,color: Colors.purpleAccent[700], size: 28.0, ),
            SizedBox(width: 2.0,),
            Text(
              movie.runtime.toString() + " min." , 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ] 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yearInfo(MovieDetailsEntity movie) {
    return Text(
         DateTime.parse(movie.releaseDate).year.toString(),
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ]
        ),
      );
  }

  


}

class HeaderInfoSerie  extends StatelessWidget {
  
  final SerieDetailsEntity serie;

  HeaderInfoSerie({@required this.serie});
  
  @override
  Widget build(BuildContext context) {
    
    return _buildFlexibleSpaceBar(context, serie);
  }

  Widget _buildFlexibleSpaceBar(BuildContext context, SerieDetailsEntity serie) {
    return FlexibleSpaceBar(    
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, serie),
    centerTitle: true,
    titlePadding: EdgeInsets.only(bottom: 60.0),
    title: _titleInfo(serie),
  );
  }

  Widget _titleInfo(SerieDetailsEntity serie){
    return Text(
        (serie.name == null) ? serie.originalName : serie.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color:  Colors.deepOrangeAccent[400],
          shadows: [Shadow(blurRadius: 1.0, color: Colors.grey[850], offset: Offset(1.0, 1.0))],
        ),
      );
  }

  

  _stackInfoBackground(BuildContext context, SerieDetailsEntity serie) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _imageBackground(serie),
          //_containerGradient(),
          _columnBackground(context, serie),
          //TODO: agregar los botones y el icono de la productora 
        ],
      ),
    );
  }

  Widget _containerGradient(){
    return SizedBox(
      height: 550.0,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [
                //TODO que sea dependiendo del tema que esta selecionado
                Colors.grey[100].withOpacity(0.0),
                Colors.grey[100].withOpacity(0.5),
                Colors.grey[100].withOpacity(0.9),

              ]
            ),
          ),
      ),
    );
  }

  Widget _imageBackground(SerieDetailsEntity serie) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ serie.backdropPath }');

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

  

  Widget _columnBackground(BuildContext context, SerieDetailsEntity serie) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            _infoPoster(context, serie),
            _buttonAddInList(context, serie),
            _durationInfo(serie),
            
          ],
        ),
    ); 
  }

  Widget _buttonAddInList(BuildContext context, SerieDetailsEntity serie){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlineButton(
          child: Text(
            'Add in your List',
            style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
          onPressed: (){
             return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: serie,
              type: serie.type,
              objectType: ConstantsTypeObject.serieDetailsEntity
            ).showBottomModal();
          },
      ),
    );
  }

  Widget _infoPoster(BuildContext context, SerieDetailsEntity serie) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ serie.posterPath }');
  //TODO agregar el HERO
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Container(
          width: MediaQuery.of(context).size.width / 5.0,
          height: 120.0,
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
          image: (serie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
    );
  }


  Widget _durationInfo(SerieDetailsEntity serie) {
    final time = 
    (serie.episodeRunTime == null && serie.episodeRunTime.isEmpty) ? 'no info' : serie.episodeRunTime[0].toString();

    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.today,color: Colors.purpleAccent[700], size: 28.0, ),
            SizedBox(width: 2.0,),
            _yearInfo(serie),
            SizedBox(width: 8.0),
            Icon(Icons.timer,color: Colors.purpleAccent[700], size: 28.0, ),
            SizedBox(width: 2.0,),
            Text(
               (time == null && time.isEmpty) ? 'no info' : time + 'min.', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ] 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yearInfo(SerieDetailsEntity serie) {
    return Text(
        DateTime.parse(serie.firstAirDate).year.toString(), 
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ]
        ),
      );
  }

  


}

class HeaderInfoAnime extends StatelessWidget {
  
  final AnimeDetailsEntity anime;

  HeaderInfoAnime({@required this.anime});
  
  
  @override
  Widget build(BuildContext context) {
    
    return _buildFlexibleSpaceBar(context, anime);
  }

  Widget _buildFlexibleSpaceBar(BuildContext context, AnimeDetailsEntity anime) {
    return FlexibleSpaceBar(    
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, anime),
    centerTitle: true,
    titlePadding: EdgeInsets.only(bottom: 60.0),
    title: _titleInfo(anime),
  );
  }

  Widget _titleInfo(AnimeDetailsEntity anime){
    return Text(
        (anime.name == null) ? anime.originalName : anime.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent[400],
          shadows: [Shadow(blurRadius: 1.0, color: Colors.grey[850], offset: Offset(1.0, 1.0))],
        ),
      );
  }

  

  _stackInfoBackground(BuildContext context, AnimeDetailsEntity anime) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _imageBackground(anime),
          //_containerGradient(),
          _columnBackground(context, anime),
          //TODO: agregar los botones y el icono de la productora 
        ],
      ),
    );
  }

  Widget _containerGradient(){
    return SizedBox(
      height: 550.0,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [
                //TODO que sea dependiendo del tema que esta selecionado
                Colors.grey[100].withOpacity(0.0),
                Colors.grey[100].withOpacity(0.5),
                Colors.grey[100].withOpacity(0.9),

              ]
            ),
          ),
      ),
    );
  }

  Widget _imageBackground(AnimeDetailsEntity anime) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original${ anime.backdropPath }');

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

  

  Widget _columnBackground(BuildContext context, AnimeDetailsEntity anime) {
    return SafeArea(
        child: Column(
          children: <Widget>[
            _infoPoster(context,anime),
            _buttonAddInList(context, anime),
            _durationInfo(anime),
            
          ],
        ),
    ); 
  }

  Widget _buttonAddInList(BuildContext context, AnimeDetailsEntity anime){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlineButton(
          child: Text(
            'Add in your List',
            style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          borderSide: BorderSide(width: 2.0, color: Colors.deepOrange),
          onPressed: (){
             return ButtonClikedAdded(
              context: context,
              isUpdated: false,
              ouevre: anime,
              type: anime.type,
              objectType: ConstantsTypeObject.animeDetailsEntity
            ).showBottomModal();
          },
      ),
    );
  }

  Widget _infoPoster(BuildContext context, AnimeDetailsEntity anime) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/original${ anime.posterPath }');
  //TODO agregar el HERO
    return Container(
      margin: const EdgeInsets.all(2.0),
      child: Container(
          width: MediaQuery.of(context).size.width / 5.0,
          height: 120.0,
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
          image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
    );
  }


  Widget _durationInfo(AnimeDetailsEntity anime) {

    final time = 
    (anime.episodeRunTime == null && anime.episodeRunTime.isEmpty) ? 'no info' : anime.episodeRunTime[0].toString();

    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.today,color: Colors.purpleAccent[700], size: 28.0, ),
            SizedBox(width: 2.0,),
            _yearInfo(anime),
            SizedBox(width: 8.0),
            Icon(Icons.timer,color: Colors.purpleAccent[700], size: 28.0, ),
            SizedBox(width: 2.0,),
            Text(
              (time == null && time.isEmpty ) ? 'no info' : time + 'min.', 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ] 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yearInfo(AnimeDetailsEntity anime) {
    return Text(
        DateTime.parse(anime.firstAirDate).year.toString(), 
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 1.0, offset: Offset(0.5, 0.5) ) ]
        ),
      );
  }
  


}