import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AllDetailsInfoTab extends StatefulWidget {
  
  final int id;
  final String type;

  AllDetailsInfoTab({@required this.id, @required this.type});

  @override
  _AllDetailsInfoTabState createState() => _AllDetailsInfoTabState();
}

class _AllDetailsInfoTabState extends State<AllDetailsInfoTab> {

  


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

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is LoadedMovie){

            return AllDetailsInfoTabMovie(movie: state.movie,);

          }else if(state is LoadedSerie){

            return AllDetailsInfoTabSerie(serie: state.serie,);

          }else if(state is LoadedAnime){

            return AllDetailsInfoTabAnime(anime: state.anime,);

          }else if(state is Error){
            
            return EmptyIconWidget();

          }

          return EmptyIconWidget();

        },
      ),
    );
  }

  
}



class AllDetailsInfoTabMovie extends StatelessWidget {
  
  final MovieDetailsEntity movie;
  
  AllDetailsInfoTabMovie({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: <Widget>[
        _boxInfo(child: _rowRatingAndNetwork()),
        _boxInfo(child: _columnInfo()),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
        _boxInfo(child: _columnExtrasInfo(context)),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
        
      ],
    );
  }

  Widget _boxInfo({Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      elevation: 5.0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: child,
    );
  }

  Widget _columnInfo() {

    final List<GenreMovie> genres =  movie.genres;
    List<int> genreIds = new List();
    // for(var item in genres){
    //     genreIds.add(item.id);
    // }
    genres.forEach((item){
      int id = item.id;
      genreIds.add(id);
    });


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _overviewInfo(),
          ChipsGenresWidget(genres: genreIds,)
          //_chipGenresItem()
        ],
      ),
    );
  }

  Widget _rowRatingAndNetwork() {
    final _ratingStyle = new TextStyle(
      color: Colors.deepOrange,
      fontSize: 20.0,
      fontWeight: FontWeight.w700
    );

    final _voteCountStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
                Text(movie.voteCount.toString(), style: _voteCountStyle,),
              ],
            ),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BigCircularChartRating(movie.voteAverage),
          ),
          //Spacer(),
          // Spacer(),
          // Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
          // Image.network('https://image.tmdb.org/t/p/h50_filter(negate,000,666)/tuomPhY2UtuPTqqFnKMVHvSb724.png', height: 15.0,)
        ],
      ),
    );
  }

  Widget _overviewInfo() {
    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text( (movie.overview == null) ?  'info not yet available' : movie.overview ,
        style: _overviewStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _chipGenresItem() {
    
    // final List<int> genres = movie.genres.cast<int>();
    // return ChipsGenresWidget(genres: genres,);
    //! FIXME: cambiar MovieDetailsEntity para genres List<dynamic> sea una Clase aparte  

    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _fakeChip('Drama', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('Action', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('War & Politics', Colors.grey[500].withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _fakeChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0 ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0)
      ), 
      child: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
    );
  }

  Widget _columnExtrasInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(
            AppLocalizations.of(context).translate('details_more_info'), 
            22.0, 
            FontWeight.w600),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_original_title'),
            AppLocalizations.of(context).translate('details_status')
            ),
          _rowDataExtraInfo(
             movie.originalTitle, 
             movie.status
            ),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_release_date'), 
            AppLocalizations.of(context).translate('details_orginal_language')
            ),
          _rowDataExtraInfo(
             formatterDate(movie.releaseDate), 
             movie.originalLanguage
            ),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_budget'), 
            AppLocalizations.of(context).translate('details_revenue')
            ),
          _rowDataExtraInfo(
            '\$${movie.budget}' , 
            '\$${movie.revenue}'
            ),
          SizedBox(height: 10.0,),
          _rowTaglineExtraInfo(
            AppLocalizations.of(context).translate('details_tagline'), 
            movie.tagline
          ),
          _rowWebExtraInfo(
            AppLocalizations.of(context).translate('details_web'), 
            movie.homepage
          ),

        ],
      ),
    );
  }

  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(1.0),
        child: Text( (text == null) ? 'info not yet available' : text,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ); 
  }

  Widget _rowLabelExtraInfo(String label1, String label2){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(label1, 14.0, FontWeight.w600, color: Colors.grey),
          _labelExtraInfo(label2, 14.0, FontWeight.w600, color: Colors.grey)
        ],
      ),
    );
  }

  Widget _rowDataExtraInfo(String label1, String label2){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(label1, 16.0, FontWeight.w500,),
          Spacer(),
          _labelExtraInfo(label2, 16.0, FontWeight.w500, ), 
        ],
      ),
    );
  }

  Widget _rowTaglineExtraInfo(String label, String data,){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _labelExtraInfo(label, 14.0, FontWeight.w800),
          Expanded(
            child: Text(
              (data == null ) ? 'info not yet available' : data,
              overflow: TextOverflow.ellipsis ,
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _rowWebExtraInfo(String label, String data,){
    return GestureDetector(
      onTap: () => launch(data),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _labelExtraInfo(label, 14.0, FontWeight.w800),
            Expanded(
              child: Text(
                (data == null ) ? 'info not yet available' : data,
                overflow: TextOverflow.ellipsis ,
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class AllDetailsInfoTabSerie extends StatelessWidget {
  
  final SerieDetailsEntity serie;
  
  AllDetailsInfoTabSerie({@required this.serie});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: <Widget>[
        _boxInfo(child: _rowRatingAndNetwork()),
        _boxInfo(child: _columnInfo()),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
        _boxInfo(child: _columnExtrasInfo(context)),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
      ],
    );
  }

  Widget _boxInfo({Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      elevation: 5.0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: child,
    );
  }

  Widget _columnInfo() {

    final List<GenreSerie> genres =  serie.genres;
    List<int> genreIds = new List();

    genres.forEach((item){
      int id = item.id;
      genreIds.add(id);
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //_rowRatingAndNetwork(),
          _overviewInfo(),
          //_chipGenresItem(),
          ChipsGenresWidget(genres: genreIds,)
        ],
      ),
    );
  }

  Widget _rowRatingAndNetwork() {
    final _ratingStyle = new TextStyle(
      color: Colors.deepOrange,
      fontSize: 20.0,
      fontWeight: FontWeight.w700
    );

    final _voteCountStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    final serieNetwork = serie.networks;

    final List<NetworkSerie> listSerieNetwork = new List<NetworkSerie>.from(serieNetwork);

    final logo = listSerieNetwork[0].logoPath;  
    
    

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
                Text(serie.voteCount.toString(), style: _voteCountStyle,),
              ],
            ),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BigCircularChartRating(serie.voteAverage),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
                _imageNetworkLogo(logo),
              ],
            ),
          ),
          //Image.network('https://image.tmdb.org/t/p/orginal/' + logo, height: 15.0,)

        ],
      ),
    );
  }

  Widget _imageNetworkLogo(String logoPath) {
     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w92/$logoPath');



    return FadeInImage(
          image: (logoPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
          // height: MediaQuery.of(context).size.height / 30.0,
          height: 18.0,
    );

  }

  Widget _overviewInfo() {
    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text( (serie.overview == null) ?  'info not yet available' : serie.overview,
        style: _overviewStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _chipGenresItem() {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _fakeChip('Drama', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('Action', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('War & Politics', Colors.grey[500].withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _fakeChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0 ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0)
      ), 
      child: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
    );
  }

  Widget _columnExtrasInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
         _labelExtraInfo(
            AppLocalizations.of(context).translate('details_more_info'), 
            22.0, 
            FontWeight.w600),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_original_title'), 
            AppLocalizations.of(context).translate('details_orginal_language') 
          ),
          _rowDataExtraInfo(
             serie.originalName, 
             serie.originalLanguage
            ),
          SizedBox(height: 10.0,),
           _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_release_date'), 
            AppLocalizations.of(context).translate('details_last_episode') 
          ),
          _rowDataExtraInfo(
             formatterDate(serie.firstAirDate), 
             formatterDate(serie.lastAirDate)
            ),
          SizedBox(height: 10.0,),
           _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_number_season'), 
            AppLocalizations.of(context).translate('details_number_episode'), 
          ),
          _rowDataExtraInfo(
             serie.numberOfSeasons.toString(), 
             serie.numberOfEpisodes.toString()
            ),
          SizedBox(height: 10.0,),
           _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_origin_country'), 
            AppLocalizations.of(context).translate('details_status'), 
          ),
          _rowDataExtraInfo(
             serie.originCountry.first, 
             serie.status
            ),
          _rowWebExtraInfo(
            AppLocalizations.of(context).translate('details_web'), 
            serie.homepage
          )

        ],
      ),
    );
  }

  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Text( (text == null) ? 'info not yet available' : text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.justify,
      ),
    ); 
  }

  Widget _rowLabelExtraInfo(String label1, String label2){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(label1, 14.0, FontWeight.w600, color: Colors.grey),
          _labelExtraInfo(label2, 14.0, FontWeight.w600, color: Colors.grey)
        ],
      ),
    );
  }

  Widget _rowDataExtraInfo(String label1, String label2){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(label1, 16.0, FontWeight.w500,),
          Spacer(),
          _labelExtraInfo(label2, 16.0, FontWeight.w500, ), 
        ],
      ),
    );
  }

  Widget _rowWebExtraInfo(String label, String data,){
    return GestureDetector(
      onTap: () => launch(data),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _labelExtraInfo(label, 14.0, FontWeight.w800),
            Expanded(
              child: Text(
                (data == null ) ? 'info not yet available' : data,
                overflow: TextOverflow.ellipsis ,
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class AllDetailsInfoTabAnime extends StatelessWidget {
  
  final AnimeDetailsEntity anime;
  
  AllDetailsInfoTabAnime({@required this.anime});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: <Widget>[
        _boxInfo(child: _rowRatingAndNetwork()),
        _boxInfo(child: _columnInfo()),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
        _boxInfo(child: _columnExtrasInfo(context)),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
      ],
    );
  }

  Widget _boxInfo({Widget child}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      elevation: 5.0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: child,
    );
  }

  Widget _columnInfo() {

    final List<GenreAnime> genres =  anime.genres;
    List<int> genreIds = new List();
    
    genres.forEach((item){
      int id = item.id;
      genreIds.add(id);
    });


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          
          _overviewInfo(),
          ChipsGenresWidget(genres: genreIds,)
          //_chipGenresItem()
        ],
      ),
    );
  }
  Widget _rowRatingAndNetwork() {
    final _ratingStyle = new TextStyle(
      color: Colors.deepOrange,
      fontSize: 20.0,
      fontWeight: FontWeight.w700
    );

    final _voteCountStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    final animeNetwork = anime.networks;

    final List<NetworkAnime> listAnimeNetwork = new List<NetworkAnime>.from(animeNetwork);

    final logo = listAnimeNetwork[0].logoPath;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
                Text(anime.voteCount.toString(), style: _voteCountStyle,),
              ],
            ),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BigCircularChartRating(anime.voteAverage),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
                _imageNetworkLogo(logo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageNetworkLogo(String logoPath) {
     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w92/$logoPath');



    return FadeInImage(
          image: (logoPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
          // height: MediaQuery.of(context).size.height / 30.0,
          height: 18.0,
    );

  }

  Widget _overviewInfo() {
    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text( (anime.overview == null) ?  'info not yet available' : anime.overview,
        style: _overviewStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _chipGenresItem() {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _fakeChip('Drama', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('Action', Colors.grey[500].withOpacity(0.2)),
          _fakeChip('War & Politics', Colors.grey[500].withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _fakeChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0 ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0)
      ), 
      child: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
    );
  }

  Widget _columnExtrasInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
         _labelExtraInfo(
            AppLocalizations.of(context).translate('details_more_info'), 
            22.0, 
            FontWeight.w600),
          SizedBox(height: 10.0,),
          _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_original_title'), 
            AppLocalizations.of(context).translate('details_orginal_language') 
          ),
          _rowDataExtraInfo(
             anime.originalName, 
             anime.originalLanguage
            ),
          SizedBox(height: 10.0,),
           _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_release_date'), 
            AppLocalizations.of(context).translate('details_last_episode') 
          ),
          _rowDataExtraInfo(
             formatterDate(anime.firstAirDate), 
             formatterDate(anime.lastAirDate)
            ),
          SizedBox(height: 10.0,),
           _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_number_season'), 
            AppLocalizations.of(context).translate('details_number_episode'), 
          ),
          _rowDataExtraInfo(
             anime.numberOfSeasons.toString(), 
             anime.numberOfEpisodes.toString()
            ),
          SizedBox(height: 10.0,),
           _rowLabelExtraInfo(
            AppLocalizations.of(context).translate('details_origin_country'), 
            AppLocalizations.of(context).translate('details_status'), 
          ),
          _rowDataExtraInfo(
             anime.originCountry.first, 
             anime.status
            ),
          _rowWebExtraInfo(
            AppLocalizations.of(context).translate('details_web'), 
            anime.homepage
          )

        ],
      ),
    );
  }

  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
    return Padding(
      padding: EdgeInsets.all(1.0),
      child: Text( (text == null) ? 'info not yet available' : text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.justify,
      ),
    ); 
  }

  Widget _rowLabelExtraInfo(String label1, String label2){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(label1, 14.0, FontWeight.w600, color: Colors.grey),
          _labelExtraInfo(label2, 14.0, FontWeight.w600, color: Colors.grey)
        ],
      ),
    );
  }

  Widget _rowDataExtraInfo(String label1, String label2){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _labelExtraInfo(label1, 16.0, FontWeight.w500,),
          Spacer(),
          _labelExtraInfo(label2, 16.0, FontWeight.w500, ), 
        ],
      ),
    );
  }

 Widget _rowWebExtraInfo(String label, String data,){
    return GestureDetector(
      onTap: () => launch(data),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _labelExtraInfo(label, 14.0, FontWeight.w800),
            Expanded(
              child: Text(
                (data == null ) ? 'info not yet available' : data,
                overflow: TextOverflow.ellipsis ,
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }


}
