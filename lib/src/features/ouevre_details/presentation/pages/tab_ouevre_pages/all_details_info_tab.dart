import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/chips_genres_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:bunkalist/src/core/utils/get_random_number.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_credits/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_recommendations/recommendations_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_similar/similar_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_video_youtube/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_casting_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_recomendation_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_season_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_similar_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_trailers_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_ouevre_pages/all_details_video_review_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/build_keywords_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/list_companies_and_network_widgets.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/row_images_widget.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/banner_premium_widget.dart';
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
          
          if(state is EmptyDetails){

            return LoadingCustomWidget();

          }else if(state is LoadingDetails){
            
            return LoadingCustomWidget();

          }else if(state is LoadedMovie){

            return AllDetailsInfoTabBarMovie(movie: state.movie,);

          }else if(state is LoadedSerie){

            return AllDetailsInfoTabBarSerie(serie: state.serie,);

          }else if(state is LoadedAnime){

            return AllDetailsInfoTabBarAnime(anime: state.anime,);
            // return AllDetailsInfoTabAnime(anime: state.anime,);

          }else if(state is ErrorDetails){
            
            return EmptyIconWidget();

          }

          return EmptyIconWidget();

        },
      ),
    );
  }

  
}



class AllDetailsInfoTabBarMovie extends StatelessWidget {

  final MovieDetailsEntity movie;

  const AllDetailsInfoTabBarMovie({@required this.movie});


  @override
  Widget build(BuildContext context) {

   

    final List<GenreMovie> genres =  movie.genres;
    List<int> genreIds = [];
    
    genres.forEach((item){
      int id = item.id;
      genreIds.add(id);
    });

    return ListView(
      padding: const EdgeInsets.only(top: 0),
      children: [
        _rowRatingAndNetwork(context),
        _rowPrincipalInfo(context),
        (movie.overview.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_summary')),
        _overviewInfo(),
        _titleSection(AppLocalizations.of(context).translate('label_genres')),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
          child: ChipsGenresWidget(genres: genreIds, type: 'movies', isWrap: false,),
        ),
        SizedBox(height: 10),
        //! Casting
        new BlocProvider<CreditsBloc>(
          create: (_) => serviceLocator<CreditsBloc>(),
          child: AllDetailsCastingTab(id: movie.id, type: movie.type,),
        ),
        SizedBox(height: 10),

        _titleSection(AppLocalizations.of(context).translate('details_more_info')),
        _columnMoreInfo(context),
        SizedBox(height: 10),

        //! Trailers
        _titleSection(AppLocalizations.of(context).translate('trailer')),
        BlocProvider<VideoYoutubeBloc>(
          create: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsTrailerTab(title: '${movie.title} ${movie.type}'),
        ),
        SizedBox(height: 10),

        BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
        //! Production Companies
         (movie.productionCompanies.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_production')),
        _getListCompanies(context),
        SizedBox(height: 10),
        //! Poster Section
        _titleSection(AppLocalizations.of(context).translate('label_images')),
        BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15.0),
              child: RowImagesWidget(id: movie.id, type: movie.type),
            ),
          ),
        SizedBox(height: 10),
        
        //! Video Review
        _titleSection(AppLocalizations.of(context).translate('video_review')),
        new BlocProvider<VideoYoutubeBloc>(
          create: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsVideoReviewTab(title: '${movie.title} ${movie.type}',),
        ),

        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/1298100531',),
        SizedBox(height: 10),
        _titleSection(AppLocalizations.of(context).translate('similar')),
        BlocProvider<SimilarBloc>(
          create: (_) => serviceLocator<SimilarBloc>(),
          child: AllDetailsSimilarTab(id: movie.id, type: movie.type,),
        ),
        _titleSection(AppLocalizations.of(context).translate('recommedation')),
        BlocProvider<RecommendationsBloc>(
          create: (_) => serviceLocator<RecommendationsBloc>(),
          child: AllDetailsRecomendationTab(id: movie.id, type: movie.type,),
        ),
        SizedBox(height: 10),
        //! Keywords Section
        _titleSection(AppLocalizations.of(context).translate('label_keyword')),
        BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: BuildKeywordsWidget(
              id: movie.id,
              type: movie.type,
            ),
          ),
        

        SizedBox(height: 40)
      ],
    );
  }

  Widget _titleSection(String title){
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 30),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _overviewInfo() {
    if(movie.overview.isEmpty) return Container();

    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text( (movie.overview == null) ?  'info not yet available' : movie.overview,
        style: _overviewStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }



  Widget _getListCompanies(BuildContext context){
    List<MovieProductionCompany> listMovieProducer = [];
    List<Company> companies = [];

    listMovieProducer = new List<MovieProductionCompany>.from(movie.productionCompanies) ?? [];

    if(listMovieProducer.isEmpty) return Container();

    listMovieProducer.forEach((item) {

      Company company = new Company(
        id: item.id.toString(),
        imagePath: (item.logoPath == null) ? '' : 'https://image.tmdb.org/t/p/h50_filter(negate,000,666)/${item.logoPath}',
        label: item.name,
        type: 'movies',
        isCompany: true
      );

      companies.add(company);

    });


    return Padding(
          padding: const EdgeInsets.only(left: 25, top: 20),
          child: ListCompaniesAndNetworkWidget(companies: companies,),
        );

    
  }


  Widget _rowRatingAndNetwork(BuildContext context) {

    final _voteCountStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );
    
    String logo = '';
    List<MovieProductionCompany> listMovieProducer = [];
    
    Company company;
    
      final listMovieProd = movie.productionCompanies;
      listMovieProducer = new List<MovieProductionCompany>.from(listMovieProd);

      if(listMovieProducer.isNotEmpty){

        logo =  listMovieProducer.first.logoPath ?? '';
      
      company = new Company(
        id: listMovieProducer.first.id.toString() ?? '',
        imagePath: logo,
        label: listMovieProducer.first.name ?? '',
        type: 'movies'
      );

      }

      

      

    


    

    


    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/ExplorerCompany', arguments: company);
              },
              child: _imageNetworkLogo(logo), 
            ),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BigCircularChartRating(movie.voteAverage),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(movie.voteCount.toString(), style: _voteCountStyle,),
                SizedBox(width: 1,),
                Icon(Icons.people, color: Colors.grey[400], size: 18.0, ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   Widget _imageNetworkLogo(String logoPath) {

    Preferences prefs = Preferences(); 

    if (logoPath == null && logoPath == '' && logoPath.isEmpty) {
      return Icon(
        Icons.broken_image_rounded,
        color: Colors.grey,
        size: 40,
      );
    } 
    
  
    final poster = prefs.whatModeIs ? NetworkImage('https://image.tmdb.org/t/p/original_filter(negate,000,999)/$logoPath') : NetworkImage('https://image.tmdb.org/t/p/original_filter(negate,999,999)/$logoPath');


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(
        image: poster,
        fit: BoxFit.contain,
        height: 50.0,
        width: 50.0,
      ),
    );  

  }

  Widget _rowPrincipalInfo(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoPoster(context),
          _columnBasicInfo(context),
          
        ],
      ),
    );
  }

  Widget _columnBasicInfo(BuildContext context){

    final List<MovieSpokenLanguage> language = movie.spokenLanguage;
    final List<MovieProductionCountry> country = movie.productionCountry;

    return Column(
      children: [

        _labelExtraInfo(AppLocalizations.of(context).translate('details_release_date'),  13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(movie.releaseDate == '' ? 'No date' : formatterDate(movie.releaseDate), 16.0, FontWeight.w700,),
        SizedBox(height: 2.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_origin_country'), 13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(country.isEmpty ? 'no data' : country[0].name, 16.0, FontWeight.w700,),
        SizedBox(height: 2.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_orginal_language'), 13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(language.isEmpty ? 'no data' : language[0].englishName.toString(), 16.0, FontWeight.w700,),
        
      ],
    );
  } 

  

 

  Widget _infoPoster(BuildContext context) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ movie.posterPath }');
  
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: 100,
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
          image: (movie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
    );
  }


  


  Widget _columnMoreInfo(BuildContext context){

    final List<MovieSpokenLanguage> language = movie.spokenLanguage;
    final List<MovieProductionCountry> country = movie.productionCountry;

    return Padding(
      padding: const EdgeInsets.only(left: 35, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_original_title'), movie.originalTitle),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_orginal_language'), getAllLanguage(language)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_origin_country'), getAllCountry(country)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_release_date'), movie.releaseDate == '' ? 'No date' : formatterDate(movie.releaseDate)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_budget'), '\$${movie.budget}'),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_revenue'), '\$${movie.revenue}'),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context,AppLocalizations.of(context).translate('details_tagline'), movie.tagline),
          SizedBox(height: 12.0,),
          _rowWebExtraInfo(AppLocalizations.of(context).translate('details_web'), movie.homepage),
          SizedBox(height: 12.0,),
        ],
      ),
    );
  }

  Widget _rowLabelExtraInfo(BuildContext context, String label, String info){
    return Row(
      children: [
        Expanded(child: _labelExtraInfo(label, 14.0, FontWeight.w600, color: Colors.grey), flex: 1,),
        SizedBox(width: 25.0,),
        Expanded(child: _labelExtraInfo(info, 16.0, FontWeight.w700,), flex: 1,),
      ],
    );
  }



  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
    return Padding(
        padding: const EdgeInsets.only(right: 10,),
        child: Text( (text == null) ? 'info not yet available' : text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.justify,
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
            _labelExtraInfo(label, 14.0, FontWeight.w600, color: Colors.grey),
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


  String getAllLanguage(List<MovieSpokenLanguage> language){

    if (language.isEmpty) return  'no data';
    
    List<String> languages = [];

    language.forEach((e) {
      languages.add(e.englishName);
    });


    final String text = languages.join(", ");

    return text;

  }


  String getAllCountry(List<MovieProductionCountry> country){

    if (country.isEmpty) return  'no data';
    
    List<String> countries = [];

    country.forEach((e){

      countries.add(e.name);

    });


    return countries.join(", ");

  }

    

}



// class AllDetailsInfoTabMovie extends StatelessWidget {
  
//   final MovieDetailsEntity movie;
  
//   AllDetailsInfoTabMovie({@required this.movie});

//   @override
//   Widget build(BuildContext context) {

//     return ListView(
//       padding: EdgeInsets.only(top: 0),
//       children: <Widget>[
//         _boxInfo(child: _rowRatingAndNetwork()),
//         //MiniNativeBannerAds(adPlacementID: "177059330328908_179579176743590",),
//         MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
//         _boxInfo(child: _columnInfo()),
//         _boxInfo(child: _columnExtrasInfo(context)),
//         BannerPremiumWidget()
         
//         //MaxNativeBannerAds(adPlacementID: "177059330328908_179579400076901",),
//       ],
//     );
//   }

//   Widget _boxInfo({Widget child}) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//       elevation: 5.0,
//       borderOnForeground: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0)
//       ),
//       child: child,
//     );
//   }

//   Widget _columnInfo() {

//     final List<GenreMovie> genres =  movie.genres;
//     List<int> genreIds = new List();
//     // for(var item in genres){
//     //     genreIds.add(item.id);
//     // }
//     genres.forEach((item){
//       int id = item.id;
//       genreIds.add(id);
//     });


//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           _overviewInfo(),
//           ChipsGenresWidget(genres: genreIds, type: 'movies', isWrap: true,)
//           //_chipGenresItem()
//         ],
//       ),
//     );
//   }

//   Widget _rowRatingAndNetwork() {
//     final _ratingStyle = new TextStyle(
//       color: Colors.pink,
//       fontSize: 20.0,
//       fontWeight: FontWeight.w700
//     );

//     final _voteCountStyle = new TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600
//     );

//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//            Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: <Widget>[
//                 Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
//                 Text(movie.voteCount.toString(), style: _voteCountStyle,),
//               ],
//             ),
//           ),
//           //Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: BigCircularChartRating(movie.voteAverage),
//           ),
//           //Spacer(),
//           // Spacer(),
//           // Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
//           // Image.network('https://image.tmdb.org/t/p/h50_filter(negate,000,666)/tuomPhY2UtuPTqqFnKMVHvSb724.png', height: 15.0,)
//         ],
//       ),
//     );
//   }

//   Widget _overviewInfo() {
//     if(movie.overview.isEmpty) return Container();

//     final _overviewStyle = new TextStyle(
//       fontStyle: FontStyle.italic,
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
//       child: Text( (movie.overview == null) ?  'info not yet available' : movie.overview ,
//         style: _overviewStyle,
//         textAlign: TextAlign.justify,
//       ),
//     );
//   }

//   Widget _chipGenresItem() {
    
//     // final List<int> genres = movie.genres.cast<int>();
//     // return ChipsGenresWidget(genres: genres,);
     

//     return Container(
//       padding: EdgeInsets.all(4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _fakeChip('Drama', Colors.grey[500].withOpacity(0.2)),
//           _fakeChip('Action', Colors.grey[500].withOpacity(0.2)),
//           _fakeChip('War & Politics', Colors.grey[500].withOpacity(0.2)),
//         ],
//       ),
//     );
//   }

//   Widget _fakeChip(String text, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0 ),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10.0)
//       ), 
//       child: Text(
//         text, 
//         textAlign: TextAlign.center, 
//         style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
//     );
//   }

//   Widget _columnExtrasInfo(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(
//             AppLocalizations.of(context).translate('details_more_info'), 
//             22.0, 
//             FontWeight.w600),
//           SizedBox(height: 10.0,),
//           _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_original_title'),
//             AppLocalizations.of(context).translate('details_status')
//             ),
//           _rowDataExtraInfo(
//              movie.originalTitle, 
//              movie.status
//             ),
//           SizedBox(height: 10.0,),
//           _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_release_date'), 
//             AppLocalizations.of(context).translate('details_orginal_language')
//             ),
//           _rowDataExtraInfo(
//              formatterDate(movie.releaseDate), 
//              movie.originalLanguage
//             ),
//           SizedBox(height: 10.0,),
//           _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_budget'), 
//             AppLocalizations.of(context).translate('details_revenue')
//             ),
//           _rowDataExtraInfo(
//             '\$${movie.budget}' , 
//             '\$${movie.revenue}'
//             ),
//           SizedBox(height: 10.0,),
//           _rowTaglineExtraInfo(
//             AppLocalizations.of(context).translate('details_tagline'), 
//             movie.tagline
//           ),
//           _rowWebExtraInfo(
//             AppLocalizations.of(context).translate('details_web'), 
//             movie.homepage
//           ),

//         ],
//       ),
//     );
//   }

//   Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
//     return Flexible(
//       child: Container(
//         padding: EdgeInsets.all(1.0),
//         child: Text( (text == null) ? 'info not yet available' : text,
//           style: TextStyle(
//             color: color,
//             fontSize: size,
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.justify,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     ); 
//   }

//   Widget _rowLabelExtraInfo(String label1, String label2){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(label1, 14.0, FontWeight.w600, color: Colors.grey),
//           _labelExtraInfo(label2, 14.0, FontWeight.w600, color: Colors.grey)
//         ],
//       ),
//     );
//   }

//   Widget _rowDataExtraInfo(String label1, String label2){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(label1, 16.0, FontWeight.w600,),
//           Spacer(),
//           _labelExtraInfo(label2, 16.0, FontWeight.w600, ), 
//         ],
//       ),
//     );
//   }

//   Widget _rowTaglineExtraInfo(String label, String data,){
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _labelExtraInfo(label, 14.0, FontWeight.w800),
//           Expanded(
//             child: Text(
//               (data == null ) ? 'info not yet available' : data,
//               overflow: TextOverflow.ellipsis ,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _rowWebExtraInfo(String label, String data,){
//     return GestureDetector(
//       onTap: () => launch(data),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             _labelExtraInfo(label, 14.0, FontWeight.w800),
//             Expanded(
//               child: Text(
//                 (data == null ) ? 'info not yet available' : data,
//                 overflow: TextOverflow.ellipsis ,
//                 style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// }


class AllDetailsInfoTabBarSerie extends StatelessWidget {

  final SerieDetailsEntity serie;

  const AllDetailsInfoTabBarSerie({@required this.serie});


  @override
  Widget build(BuildContext context) {

   SerieLastEpisodeToAir lastEpisode = serie.lastEpisodeToAir;

   SerieLastEpisodeToAir nextEpisode = serie.nextEpisodeToAir;

    final List<GenreSerie> genres =  serie.genres;
    List<int> genreIds = [];
    
    genres.forEach((item){
      int id = item.id;
      genreIds.add(id);
    });

    return ListView(
      padding: const EdgeInsets.only(top: 0),
      children: [
        _rowRatingAndNetwork(context),
        _rowPrincipalInfo(context),
        (serie.overview.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_summary')),
        _overviewInfo(),
        _titleSection(AppLocalizations.of(context).translate('label_genres')),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
          child: ChipsGenresWidget(genres: genreIds, type: 'series', isWrap: false,),
        ),
        //! Casting

        new BlocProvider<CreditsBloc>(
          create: (_) => serviceLocator<CreditsBloc>(),
          child: AllDetailsCastingTab(id: serie.id, type: serie.type,),
        ),
        SizedBox(height: 10),


        //! Last Episode And Next Episode
        (lastEpisode == null) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_last_episode')),
        _lastEpisodes(context, lastEpisode),

        (nextEpisode.airDate == 'no data') ? Container() : _titleSection(AppLocalizations.of(context).translate('label_next_episode')),
        _lastEpisodes(context, nextEpisode),
        SizedBox(height: 10),
        //! Season

        _titleSection(AppLocalizations.of(context).translate('season')),
        new BlocProvider<OuevreDetailsBloc>(
          create: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsSeasonTab(id: serie.id, type: serie.type,),
        ),
        SizedBox(height: 10),



        _titleSection(AppLocalizations.of(context).translate('details_more_info')),
        _columnMoreInfo(context),
        BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
        //! Trailers
        SizedBox(height: 10),
        _titleSection(AppLocalizations.of(context).translate('trailer')),
        BlocProvider<VideoYoutubeBloc>(
          create: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsTrailerTab(title: '${serie.name} ${serie.type}'),
        ),
        SizedBox(height: 10),


        //! Redes
        (serie.networks.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_network')),
        _getListNetworks(context),
        //! Production Companies
         (serie.productionCompanies.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_production')),
        _getListCompanies(context),
        //! Poster Section
        SizedBox(height: 10),
        _titleSection(AppLocalizations.of(context).translate('label_images')),
        BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15.0),
              child: RowImagesWidget(id: serie.id, type: serie.type),
            ),
          ),
        SizedBox(height: 10),
        
        //! Video Review

        _titleSection(AppLocalizations.of(context).translate('video_review')),
        new BlocProvider<VideoYoutubeBloc>(
          create: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsVideoReviewTab(title: '${serie.name} ${serie.type}',),
        ),
        SizedBox(height: 10),


        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/1298100531',),
        _titleSection(AppLocalizations.of(context).translate('similar')),
        BlocProvider<SimilarBloc>(
          create: (_) => serviceLocator<SimilarBloc>(),
          child: AllDetailsSimilarTab(id: serie.id, type: serie.type,),
        ),
        _titleSection(AppLocalizations.of(context).translate('recommedation')),
        BlocProvider<RecommendationsBloc>(
          create: (_) => serviceLocator<RecommendationsBloc>(),
          child: AllDetailsRecomendationTab(id: serie.id, type: serie.type,),
        ),
        SizedBox(height: 10),
        //! Keywords Section
        _titleSection(AppLocalizations.of(context).translate('label_keyword')),
        BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: BuildKeywordsWidget(
              id: serie.id,
              type: serie.type,
            ),
          ),
          
        SizedBox(height: 40)
      ],
    );
  }

  Widget _titleSection(String title){
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 30),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _overviewInfo() {
    if(serie.overview.isEmpty) return Container();

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


  Widget _getListNetworks(BuildContext context){
    List<NetworkSerie> listserieNetwork = [];
    List<Company> companies = [];

    listserieNetwork = new List<NetworkSerie>.from(serie.networks);

    if(listserieNetwork.isEmpty) return Container();

    listserieNetwork.forEach((item) {

      Company company = new Company(
        id: item.id.toString(),
        imagePath: (item.logoPath == null) ? '' : 'https://image.tmdb.org/t/p/h50_filter(negate,000,666)/${item.logoPath}',
        label: item.name,
        type: 'tv',
        isCompany: false
      );

      companies.add(company);

    });


    return Padding(
          padding: const EdgeInsets.only(left: 25, top: 20),
          child: ListCompaniesAndNetworkWidget(companies: companies,),
        );


  }

  Widget _getListCompanies(BuildContext context){
    List<SerieProductionCompany> listserieProducer = [];
    List<Company> companies = [];

    listserieProducer = new List<SerieProductionCompany>.from(serie.productionCompanies);

    if(listserieProducer.isEmpty) return Container();

    listserieProducer.forEach((item) {

      Company company = new Company(
        id: item.id.toString(),
        imagePath: (item.logoPath == null) ? '' : 'https://image.tmdb.org/t/p/h50_filter(negate,000,666)/${item.logoPath}',
        label: item.name,
        type: 'tv',
        isCompany: true
      );

      companies.add(company);

    });


    return Padding(
          padding: const EdgeInsets.only(left: 45, top: 20),
          child: ListCompaniesAndNetworkWidget(companies: companies,),
        );

    
  }


  Widget _rowRatingAndNetwork(BuildContext context) {

    final _voteCountStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    

    List<dynamic> serieNetwork = [];
    String logo = '';
    List<SerieProductionCompany> listserieProducer = [];
    List<NetworkSerie> listserieNetwork = [];
    Company company;


    if(serie.networks.isEmpty){
      
      serieNetwork = serie.productionCompanies;
      listserieProducer = new List<SerieProductionCompany>.from(serieNetwork);
      
      company = new Company(
        id: listserieProducer[0].id.toString(),
        imagePath: logo,
        label: listserieProducer[0].name,
        type: 'tv',
        isCompany: true
      );

      logo =  listserieProducer[0].logoPath;
    
    }else{
      
      serieNetwork = serie.networks;
      listserieNetwork = new List<NetworkSerie>.from(serieNetwork);
      
      company = new Company(
        id: listserieNetwork[0].id.toString(),
        imagePath: logo,
        label: listserieNetwork[0].name,
        type: 'tv',
        isCompany: false
      );
      
      logo = listserieNetwork[0].logoPath;

    }


    




    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/ExplorerCompany', arguments: company);
              },
              child: _imageNetworkLogo(logo), 
            ),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BigCircularChartRating(serie.voteAverage),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(serie.voteCount.toString(), style: _voteCountStyle,),
                SizedBox(width: 1,),
                Icon(Icons.people, color: Colors.grey[400], size: 18.0, ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   Widget _imageNetworkLogo(String logoPath) {

    Preferences prefs = Preferences(); 

    if (logoPath == null) {
      return Icon(
        Icons.broken_image_rounded,
        color: Colors.grey,
        size: 40,
      );
    } 
    
    final placeholder = AssetImage('assets/poster_placeholder.png'); 
  
    final poster = prefs.whatModeIs ? NetworkImage('https://image.tmdb.org/t/p/original_filter(negate,000,999)/$logoPath') : NetworkImage('https://image.tmdb.org/t/p/original_filter(negate,999,999)/$logoPath');


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(
        image: poster,
        fit: BoxFit.contain,
        height:50.0,
        width: 50.0,
      ),
    );  

  }

  Widget _rowPrincipalInfo(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoPoster(context),
          _columnBasicInfo(context),
          
        ],
      ),
    );
  }

  Widget _columnBasicInfo(BuildContext context){
    return Column(
      children: [
        createdBy(context),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_season'), 13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(serie.numberOfSeasons.toString(), 16.0, FontWeight.w700,),
        SizedBox(height: 2.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_episode'), 13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(serie.numberOfEpisodes.toString(), 16.0, FontWeight.w700,),
        
        
      ],
    );
  } 

  Widget createdBy(BuildContext context){
    final List<SerieCreatedBy> createdBy = new List<SerieCreatedBy>.from(serie.createdBy);

    if(createdBy.isNotEmpty){
      return Column(
        children: [
          _labelExtraInfo(AppLocalizations.of(context).translate('label_created_by') , 13.0, FontWeight.w600, color: Colors.grey),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/AllDetailsPeople', arguments: getIdAndNameCast(createdBy[0].id, createdBy[0].name));
            },
            child: _labelExtraInfo( createdBy[0].name, 16.0, FontWeight.w800,)
          ),
          SizedBox(height: 6.0,),
        ],
      );
    }else{
      return Column(
        children: [
          
          _labelExtraInfo(AppLocalizations.of(context).translate('details_last_episode') , 13.0, FontWeight.w600, color: Colors.grey),
          _labelExtraInfo(serie.lastAirDate == '' ? 'No date' : formatterDate(serie.lastAirDate), 16.0, FontWeight.w700,),
          SizedBox(height: 4.0,),
        ],
      );
    }


    

    


  }

 

  Widget _infoPoster(BuildContext context) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ serie.posterPath }');
  
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: 100,
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
          image: (serie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
    );
  }


  Widget _lastEpisodes(BuildContext context, SerieLastEpisodeToAir lastEpisode){

    if(lastEpisode.airDate == 'no data') return SizedBox.shrink();

    final Preferences prefs = new Preferences();    

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ lastEpisode.stillPath }');

    final season = AppLocalizations.of(context).translate('season');
    final episode = AppLocalizations.of(context).translate('episode');

    final releaseDate = formatterDate(lastEpisode.airDate);

    return ListTile(
      onTap: () {
        
        final Episode episode = Episode(
          airDate: lastEpisode.airDate, 
          episodeNumber: lastEpisode.episodeNumber, 
          crew: [], 
          guestStars: [], 
          id: lastEpisode.id, 
          name: lastEpisode.name, 
          overview: lastEpisode.overview, 
          productionCode: lastEpisode.productionCode, 
          seasonNumber: lastEpisode.seasonNumber, 
          stillPath: lastEpisode.stillPath, 
          voteAverage: lastEpisode.voteAverage, 
          voteCount: lastEpisode.voteCount
        );

        Navigator.pushNamed(context, '/AllDetailsEpisode', arguments: episode);

      },
      leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
          image: (serie.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
      title: Text(
        lastEpisode.name.isEmpty 
        ? '$episode ${lastEpisode.episodeNumber}'
        : lastEpisode.name,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.justify,

      ),
      subtitle: Text(
        '$season ${lastEpisode.seasonNumber} $episode ${lastEpisode.episodeNumber} \n $releaseDate',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.justify,
      ),
      isThreeLine: true,
      trailing: Icon(Icons.chevron_right, size: 30.0, color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],),
    );

  }


  Widget _columnMoreInfo(BuildContext context){

    final List<SerieSpokenLanguage> language = serie.spokenLanguage;
    final List<SerieProductionCountry> country = serie.productionCountry;

    return Padding(
      padding: const EdgeInsets.only(left: 35, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_original_title'), serie.originalName),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_orginal_language'), getAllLanguage(language)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_origin_country'), getAllCountry(country)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_release_date'),serie.firstAirDate == '' ? 'No date' : formatterDate(serie.firstAirDate)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_last_episode'),serie.lastAirDate == '' ? 'No date' : formatterDate(serie.lastAirDate)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_number_season'), serie.numberOfSeasons.toString()),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_number_episode'), serie.numberOfEpisodes.toString()),
          SizedBox(height: 12.0,),
          _rowWebExtraInfo(AppLocalizations.of(context).translate('details_web'), serie.homepage),
          SizedBox(height: 12.0,),
        ],
      ),
    );
  }

  Widget _rowLabelExtraInfo(BuildContext context, String label, String info){
    return Row(
      children: [
        Expanded(child: _labelExtraInfo(label, 14.0, FontWeight.w600, color: Colors.grey), flex: 1,),
        SizedBox(width: 25.0,),
        Expanded(child: _labelExtraInfo(info, 16.0, FontWeight.w700,), flex: 1,),
      ],
    );
  }



  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
    return Padding(
        padding: const EdgeInsets.only(right: 10,),
        child: Text( (text == null) ? 'info not yet available' : text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.justify,
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
            _labelExtraInfo(label, 14.0, FontWeight.w600, color: Colors.grey),
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

    String getAllLanguage(List<SerieSpokenLanguage> language){

    if (language.isEmpty) return  'no data';
    
    List<String> languages = [];

    language.forEach((e) {
      languages.add(e.englishName);
    });


    final String text = languages.join(", ");

    return text;

  }


  String getAllCountry(List<SerieProductionCountry> country){

    if (country.isEmpty) return  'no data';
    
    List<String> countries = [];

    country.forEach((e){

      countries.add(e.name);

    });


    return countries.join(", ");

  }

}





// class AllDetailsInfoTabSerie extends StatelessWidget {
  
//   final SerieDetailsEntity serie;
  
//   AllDetailsInfoTabSerie({@required this.serie});

//   @override
//   Widget build(BuildContext context) {

//     return ListView(
//       padding: EdgeInsets.only(top: 0),
//       children: <Widget>[
//         _buttonWatchInNetflix(),
//         _buttonWatchInHBO(),
//         _buttonWatchInAmazonPrimeVideo(),
//         _boxInfo(child: _rowRatingAndNetwork(context)),
//         //MiniNativeBannerAds(adPlacementID: "177059330328908_179579176743590",),
//          MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
//         _boxInfo(child: _columnInfo()),
//         _boxInfo(child: _columnExtrasInfo(context)),
//         BannerPremiumWidget(),
        
//         //MaxNativeBannerAds(adPlacementID: "177059330328908_179579400076901",),
//       ],
//     );
//   }

//   Widget _boxInfo({Widget child}) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//       elevation: 5.0,
//       borderOnForeground: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0)
//       ),
//       child: child,
//     );
//   }

//   Widget _columnInfo() {

//     final List<GenreSerie> genres =  serie.genres;
//     List<int> genreIds = new List();

//     genres.forEach((item){
//       int id = item.id;
//       genreIds.add(id);
//     });

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           //_rowRatingAndNetwork(),
//           _overviewInfo(),
//           //_chipGenresItem(),
//           serie.genres == null ? Container() : ChipsGenresWidget(genres: genreIds, type: serie.type, isWrap: true,)
//         ],
//       ),
//     );
//   }

//   Widget _buttonWatchInNetflix(){
//     final serieNetwork = serie.networks;

//     final List<NetworkSerie> listSerieNetwork = new List<NetworkSerie>.from(serieNetwork);

//     // if(listSerieNetwork == null && listSerieNetwork.isEmpty && listSerieNetwork[0] == null) return Container();

//     if(listSerieNetwork != null && listSerieNetwork.isNotEmpty && listSerieNetwork[0] != null && listSerieNetwork[0].id == 213){

//       return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 110.0),
//       child: RaisedButton(
//         elevation: 10.0,
//         color: Colors.transparent,
//         padding: const EdgeInsets.all(0.0),
//         onPressed: (){
//           launch(serie.homepage);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             gradient: LinearGradient(
//               colors: <Color>[
//                 Colors.redAccent[700],
//                 Colors.redAccent[400],
//                 Colors.redAccent,
//               ],
//             ),
//           ),
//           padding: const EdgeInsets.all(12.0),
//           child:
//               const Text('Watch on Netflix', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );

//     } 
    
//     return Container();

    
//   }

//   Widget _buttonWatchInHBO(){
//     final serieNetwork = serie.networks;

//     final List<NetworkSerie> listSerieNetwork = new List<NetworkSerie>.from(serieNetwork);

//     // if(listSerieNetwork == null && listSerieNetwork.isEmpty && listSerieNetwork[0] == null) return Container();

//     if(listSerieNetwork != null && listSerieNetwork.isNotEmpty &&  listSerieNetwork[0] != null && listSerieNetwork[0].id == 49){
//       return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 110.0),
//       child: RaisedButton(
//         elevation: 10.0,
//         color: Colors.transparent,
//         padding: const EdgeInsets.all(0.0),
//         onPressed: (){
//           launch(serie.homepage);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             gradient: LinearGradient(
//               colors: <Color>[
//                 Colors.grey[850],
//                 Colors.grey[700],
//                 Colors.grey[600],
//               ],
//             ),
//           ),
//           padding: const EdgeInsets.all(12.0),
//           child:
//               const Text('Watch on HBO', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );
//     } 
    
//     return Container();

    
//   }

//   Widget _buttonWatchInAmazonPrimeVideo(){
//     final serieNetwork = serie.networks;

//     final List<NetworkSerie> listSerieNetwork = new List<NetworkSerie>.from(serieNetwork);

//     // if(listSerieNetwork == null && listSerieNetwork.isEmpty && listSerieNetwork[0] == null) return Container();

//     if(listSerieNetwork != null && listSerieNetwork.isNotEmpty && listSerieNetwork[0] != null && listSerieNetwork[0].id == 1024){
//       return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 90.0),
//       child: RaisedButton(
//         elevation: 10.0,
//         color: Colors.transparent,
//         padding: const EdgeInsets.all(0.0),
//         onPressed: (){
//           launch(serie.homepage);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             gradient: LinearGradient(
//               colors: <Color>[
//                 Colors.lightBlueAccent[700],
//                 Colors.lightBlueAccent[400],
//                 Colors.lightBlueAccent,
//               ],
//             ),
//           ),
//           padding: const EdgeInsets.all(12.0),
//           child:
//               const Text('Watch on Prime Video', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600)),
//         ),
//       ),
//     );
//     } 
    
//     return Container();

    
//   }

//   Widget _rowRatingAndNetwork(BuildContext context) {
    
//     final _ratingStyle = new TextStyle(
//       color: Colors.pink,
//       fontSize: 20.0,
//       fontWeight: FontWeight.w700
//     );

//     final _voteCountStyle = new TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600
//     );

//     final serieNetwork = serie.networks;

//     final List<NetworkSerie> listSerieNetwork = new List<NetworkSerie>.from(serieNetwork);

//     String logo = '';
//     Company company;


//     if(listSerieNetwork == null && listSerieNetwork.isEmpty && listSerieNetwork[0] == null){
//       logo = '';
//       company = new Company(
//         id: '', 
//         imagePath: logo,
//         label: '',
//         type: 'tv'
//       );
//     }else if(listSerieNetwork != null && listSerieNetwork.isNotEmpty && listSerieNetwork[0] != null){
      
//       logo = listSerieNetwork[0].logoPath;
//       company = new Company(
//         id: listSerieNetwork[0].id.toString(), 
//         imagePath: logo,
//         label: listSerieNetwork[0].name,
//         type: 'tv'
//       );
//     }
    

//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: <Widget>[
//                 Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
//                 Text(serie.voteCount.toString(), style: _voteCountStyle,),
//               ],
//             ),
//           ),
//           //Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: BigCircularChartRating(serie.voteAverage),
//           ),
//           //Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: GestureDetector(
//               onTap: (){
//                 Navigator.pushNamed(context, '/ExplorerCompany', arguments: company);
//               },
//               child: Column(
//                 children: <Widget>[
//                   Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
//                   _imageNetworkLogo(logo),
//                 ],
//               ),
//             ),
//           ),
//           //Image.network('https://image.tmdb.org/t/p/orginal/' + logo, height: 15.0,)

//         ],
//       ),
//     );
//   }

//   Widget _imageNetworkLogo(String logoPath) {
//      final placeholder = AssetImage('assets/poster_placeholder.png'); 
//      final poster = NetworkImage('https://image.tmdb.org/t/p/w92/$logoPath');



//     return FadeInImage(
//           image: (logoPath == null) ? placeholder : poster,//? Image Poster Item,
//           placeholder: placeholder, //? PlaceHolder Item,
//           fit: BoxFit.contain,
//           height: 40.0,
//           width: 40.0,
//     );

//   }

//   Widget _overviewInfo() {
//     if(serie.overview.isEmpty) return Container();

//     final _overviewStyle = new TextStyle(
//       fontStyle: FontStyle.italic,
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
//       child: Text( (serie.overview == null) ?  'info not yet available' : serie.overview,
//         style: _overviewStyle,
//         textAlign: TextAlign.justify,
//       ),
//     );
//   }


//   Widget _columnExtrasInfo(BuildContext context) {

//     String country = 'No data';

//     if(serie.originCountry != null && serie.originCountry.isNotEmpty){
//       country = serie.originCountry.first;
//     } 

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//          _labelExtraInfo(
//             AppLocalizations.of(context).translate('details_more_info'), 
//             22.0, 
//             FontWeight.w600),
//           SizedBox(height: 10.0,),
//           _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_original_title'), 
//             AppLocalizations.of(context).translate('details_orginal_language') 
//           ),
//           _rowDataExtraInfo(
//              serie.originalName, 
//              serie.originalLanguage
//             ),
//           SizedBox(height: 10.0,),
//            _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_release_date'), 
//             AppLocalizations.of(context).translate('details_last_episode') 
//           ),
//           _rowDataExtraInfo(
//              formatterDate(serie.firstAirDate), 
//              formatterDate(serie.lastAirDate)
//             ),
//           SizedBox(height: 10.0,),
//            _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_number_season'), 
//             AppLocalizations.of(context).translate('details_number_episode'), 
//           ),
//           _rowDataExtraInfo(
//              serie.numberOfSeasons.toString(), 
//              serie.numberOfEpisodes.toString()
//             ),
//           SizedBox(height: 10.0,),
//            _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_origin_country'), 
//             AppLocalizations.of(context).translate('details_status'), 
//           ),
//           _rowDataExtraInfo(
//              country, 
//              serie.status
//             ),
//           _rowWebExtraInfo(
//             AppLocalizations.of(context).translate('details_web'), 
//             serie.homepage
//           )

//         ],
//       ),
//     );
//   }

//   Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
//     return Padding(
//       padding: EdgeInsets.all(1.0),
//       child: Text( (text == null) ? 'info not yet available' : text,
//         style: TextStyle(
//           color: color,
//           fontSize: size,
//           fontWeight: FontWeight.w600,
//         ),
//         textAlign: TextAlign.justify,
//       ),
//     ); 
//   }

//   Widget _rowLabelExtraInfo(String label1, String label2){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(label1, 14.0, FontWeight.w600, color: Colors.grey),
//           _labelExtraInfo(label2, 14.0, FontWeight.w600, color: Colors.grey)
//         ],
//       ),
//     );
//   }

//   Widget _rowDataExtraInfo(String label1, String label2){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(label1, 16.0, FontWeight.w600,),
//           Spacer(),
//           _labelExtraInfo(label2, 16.0, FontWeight.w600, ), 
//         ],
//       ),
//     );
//   }

//   Widget _rowWebExtraInfo(String label, String data,){
//     return GestureDetector(
//       onTap: () => launch(data),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             _labelExtraInfo(label, 14.0, FontWeight.w800),
//             Expanded(
//               child: Text(
//                 (data == null ) ? 'info not yet available' : data,
//                 overflow: TextOverflow.ellipsis ,
//                 style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// }








class AllDetailsInfoTabBarAnime extends StatelessWidget {

  final AnimeDetailsEntity anime;

  const AllDetailsInfoTabBarAnime({@required this.anime});


  @override
  Widget build(BuildContext context) {

   AnimeLastEpisodeToAir lastEpisode = anime.lastEpisodeToAir;

   AnimeLastEpisodeToAir nextEpisode = anime.nextEpisodeToAir;

    final List<GenreAnime> genres =  anime.genres;
    List<int> genreIds = [];
    
    genres.forEach((item){
      int id = item.id;
      genreIds.add(id);
    });

    return ListView(
      padding: const EdgeInsets.only(top: 0),
      children: [
        _rowRatingAndNetwork(context),
        _rowPrincipalInfo(context),
        (anime.overview.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_summary')),
        _overviewInfo(),
        _titleSection(AppLocalizations.of(context).translate('label_genres')),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
          child: ChipsGenresWidget(genres: genreIds, type: 'animes', isWrap: false,),
        ),

        //! Casting

        new BlocProvider<CreditsBloc>(
          create: (_) => serviceLocator<CreditsBloc>(),
          child: AllDetailsCastingTab(id: anime.id, type: anime.type,),
        ),
        SizedBox(height: 10),


        //! Last Episode And Next Episode
        (lastEpisode == null) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_last_episode')),
        _lastEpisodes(context, lastEpisode),

        (nextEpisode.airDate == 'no data') ? Container() : _titleSection(AppLocalizations.of(context).translate('label_next_episode')),
        _lastEpisodes(context, nextEpisode),
        SizedBox(height: 10),
        //! Season

         _titleSection(AppLocalizations.of(context).translate('season')),
        new BlocProvider<OuevreDetailsBloc>(
          create: (_) => serviceLocator<OuevreDetailsBloc>(),
          child: AllDetailsSeasonTab(id: anime.id, type: anime.type,),
        ),
        SizedBox(height: 10),

        _titleSection(AppLocalizations.of(context).translate('details_more_info')),
        _columnMoreInfo(context),
        BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
        SizedBox(height: 10),
        //! Trailers

        _titleSection(AppLocalizations.of(context).translate('trailer')),
        BlocProvider<VideoYoutubeBloc>(
          create: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsTrailerTab(title: '${anime.name} ${anime.type}'),
        ),
        SizedBox(height: 10),


        //! Redes
        (anime.networks.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_network')),
        _getListNetworks(context),
        //! Production Companies
         (anime.productionCompanies.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_production')),
        _getListCompanies(context),
        //! Poster Section
        SizedBox(height: 10),
        _titleSection(AppLocalizations.of(context).translate('label_images')),
        BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15.0),
              child: RowImagesWidget(id: anime.id, type: anime.type),
            ),
          ),
        
        //! Video Review

        _titleSection(AppLocalizations.of(context).translate('video_review')),
        new BlocProvider<VideoYoutubeBloc>(
          create: (_) => serviceLocator<VideoYoutubeBloc>(),
          child: AllDetailsVideoReviewTab(title: '${anime.name} ${anime.type}',),
        ),
        SizedBox(height: 10),



        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/1298100531',),
        _titleSection(AppLocalizations.of(context).translate('similar')),
        BlocProvider<SimilarBloc>(
          create: (_) => serviceLocator<SimilarBloc>(),
          child: AllDetailsSimilarTab(id: anime.id, type: anime.type,),
        ),
        _titleSection(AppLocalizations.of(context).translate('recommedation')),
        BlocProvider<RecommendationsBloc>(
          create: (_) => serviceLocator<RecommendationsBloc>(),
          child: AllDetailsRecomendationTab(id: anime.id, type: anime.type,),
        ),
        SizedBox(height: 10),
        //! Keywords Section
        _titleSection(AppLocalizations.of(context).translate('label_keyword')),
        BlocProvider<OuevreDetailsBloc>(
            create: (_) => serviceLocator<OuevreDetailsBloc>(),
            child: BuildKeywordsWidget(
              id: anime.id,
              type: anime.type,
            ),
          ),
          

        SizedBox(height: 40)

      ],
    );
  }

  Widget _titleSection(String title){
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 30),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _overviewInfo() {
    if(anime.overview.isEmpty) return Container();

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


  Widget _getListNetworks(BuildContext context){
    List<NetworkAnime> listAnimeNetwork = [];
    List<Company> companies = [];

    listAnimeNetwork = new List<NetworkAnime>.from(anime.networks);

    if(listAnimeNetwork.isEmpty) return Container();

    listAnimeNetwork.forEach((item) {

      Company company = new Company(
        id: item.id.toString(),
        imagePath: (item.logoPath == null) ? '' : 'https://image.tmdb.org/t/p/h50_filter(negate,000,666)/${item.logoPath}',
        label: item.name,
        type: 'animes',
        isCompany: false
      );

      companies.add(company);

    });


    return Padding(
          padding: const EdgeInsets.only(left: 25, top: 20),
          child: ListCompaniesAndNetworkWidget(companies: companies,),
        );


  }

  Widget _getListCompanies(BuildContext context){
    List<AnimeProductionCompany> listAnimeProducer = [];
    List<Company> companies = [];

    listAnimeProducer = new List<AnimeProductionCompany>.from(anime.productionCompanies);

    if(listAnimeProducer.isEmpty) return Container();

    listAnimeProducer.forEach((item) {

      Company company = new Company(
        id: item.id.toString(),
        imagePath: (item.logoPath == null) ? '' : 'https://image.tmdb.org/t/p/h50_filter(negate,000,666)/${item.logoPath}',
        label: item.name,
        type: 'animes',
        isCompany: true
      );

      companies.add(company);

    });


    return Padding(
          padding: const EdgeInsets.only(left: 45, top: 20),
          child: ListCompaniesAndNetworkWidget(companies: companies,),
        );

    
  }


  Widget _rowRatingAndNetwork(BuildContext context) {

    final _voteCountStyle = new TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600
    );

    

    List<dynamic> animeNetwork = [];
    String logo = '';
    List<AnimeProductionCompany> listAnimeProducer = [];
    List<NetworkAnime> listAnimeNetwork = [];
    Company company;


    if(anime.productionCompanies.isEmpty){
      animeNetwork = anime.networks;
      listAnimeNetwork = new List<NetworkAnime>.from(animeNetwork);
      
      company = new Company(
        id: listAnimeNetwork[0].id.toString(),
        imagePath: logo,
        label: listAnimeNetwork[0].name,
        type: 'animes',
        isCompany: false
      );
      
      logo = listAnimeNetwork[0].logoPath;



    }else{
      animeNetwork = anime.productionCompanies;
      listAnimeProducer = new List<AnimeProductionCompany>.from(animeNetwork);
      
      company = new Company(
        id: listAnimeProducer[0].id.toString(),
        imagePath: logo,
        label: listAnimeProducer[0].name,
        type: 'animes',
        isCompany: true
      );

      logo =  listAnimeProducer[0].logoPath;

    }


    




    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/ExplorerCompany', arguments: company);
              },
              child: _imageNetworkLogo(logo), 
            ),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BigCircularChartRating(anime.voteAverage),
          ),
          //Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(anime.voteCount.toString(), style: _voteCountStyle,),
                SizedBox(width: 1,),
                Icon(Icons.people, color: Colors.grey[400], size: 18.0, ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   Widget _imageNetworkLogo(String logoPath) {

    Preferences prefs = Preferences(); 

    if (logoPath == null) {
      return Icon(
        Icons.broken_image_rounded,
        color: Colors.grey,
        size: 40,
      );
    } 
    
    final placeholder = AssetImage('assets/poster_placeholder.png'); 
  
    final poster = prefs.whatModeIs ? NetworkImage('https://image.tmdb.org/t/p/original_filter(negate,000,999)/$logoPath') : NetworkImage('https://image.tmdb.org/t/p/original_filter(negate,999,999)/$logoPath');


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(
        image: poster,
        fit: BoxFit.contain,
        height: 50.0,
        width: 50.0,
      ),
    );  

  }

  Widget _rowPrincipalInfo(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoPoster(context),
          _columnBasicInfo(context),
          
        ],
      ),
    );
  }

  Widget _columnBasicInfo(BuildContext context){
    return Column(
      children: [
        createdBy(context),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_season'), 13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(anime.numberOfSeasons.toString(), 16.0, FontWeight.w700,),
        SizedBox(height: 2.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_episode'), 13.0, FontWeight.w600, color: Colors.grey),
        _labelExtraInfo(anime.numberOfEpisodes.toString(), 16.0, FontWeight.w700,),
        
        
      ],
    );
  } 

  Widget createdBy(BuildContext context){
    final List<AnimeCreatedBy> createdBy = new List<AnimeCreatedBy>.from(anime.createdBy);

    if(createdBy.isNotEmpty){
      return Column(
        children: [
          _labelExtraInfo(AppLocalizations.of(context).translate('label_created_by') , 13.0, FontWeight.w600, color: Colors.grey),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/AllDetailsPeople', arguments: getIdAndNameCast(createdBy[0].id, createdBy[0].name));
            },
            child: _labelExtraInfo( createdBy[0].name, 16.0, FontWeight.w800,)
          ),
          SizedBox(height: 6.0,),
        ],
      );
    }else{
      return Column(
        children: [
          
          _labelExtraInfo(AppLocalizations.of(context).translate('details_last_episode') , 13.0, FontWeight.w600, color: Colors.grey),
          _labelExtraInfo(anime.lastAirDate == '' ? 'No date' :formatterDate(anime.lastAirDate), 16.0, FontWeight.w700,),
          SizedBox(height: 4.0,),
        ],
      );
    }


    

    


  }

 

  Widget _infoPoster(BuildContext context) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ anime.posterPath }');
  
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: 100,
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
          image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
    );
  }


  Widget _lastEpisodes(BuildContext context, AnimeLastEpisodeToAir lastEpisode){

    if(lastEpisode.airDate == 'no data') return SizedBox.shrink();

    final Preferences prefs = new Preferences();    

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ lastEpisode.stillPath }');

    final season = AppLocalizations.of(context).translate('season');
    final episode = AppLocalizations.of(context).translate('episode');

    final releaseDate = formatterDate(lastEpisode.airDate);

    return ListTile(
      onTap: () {
        
        final Episode episode = Episode(
          airDate: lastEpisode.airDate, 
          episodeNumber: lastEpisode.episodeNumber, 
          crew: [], 
          guestStars: [], 
          id: lastEpisode.id, 
          name: lastEpisode.name, 
          overview: lastEpisode.overview, 
          productionCode: lastEpisode.productionCode, 
          seasonNumber: lastEpisode.seasonNumber, 
          stillPath: lastEpisode.stillPath, 
          voteAverage: lastEpisode.voteAverage, 
          voteCount: lastEpisode.voteCount
        );

        Navigator.pushNamed(context, '/AllDetailsEpisode', arguments: episode);

      },
      leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
          image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
      title: Text(
        lastEpisode.name.isEmpty 
        ? '$episode ${lastEpisode.episodeNumber}'
        : lastEpisode.name,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.justify,

      ),
      subtitle: Text(
        '$season ${lastEpisode.seasonNumber} $episode ${lastEpisode.episodeNumber} \n $releaseDate',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.justify,
      ),
      isThreeLine: true,
      trailing: Icon(Icons.chevron_right, size: 30.0, color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],),
    );

  }


  Widget _columnMoreInfo(BuildContext context){

    final List<AnimeSpokenLanguage> language = anime.spokenLanguage;
    final List<AnimeProductionCountry> country = anime.productionCountry;

    return Padding(
      padding: const EdgeInsets.only(left: 35, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_original_title'), anime.originalName),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_orginal_language'), language.isEmpty ? 'no data' : language[0].englishName),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_origin_country'), country.isEmpty ? 'no data' : country[0].name),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_release_date'),anime.firstAirDate == '' ? 'No date' : formatterDate(anime.firstAirDate)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_last_episode'),anime.lastAirDate == '' ? 'No date' : formatterDate(anime.lastAirDate)),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_number_season'), anime.numberOfSeasons.toString()),
          SizedBox(height: 12.0,),
          _rowLabelExtraInfo(context, AppLocalizations.of(context).translate('details_number_episode'), anime.numberOfEpisodes.toString()),
          SizedBox(height: 12.0,),
          _rowWebExtraInfo(AppLocalizations.of(context).translate('details_web'), anime.homepage),
          SizedBox(height: 12.0,),
        ],
      ),
    );
  }

  Widget _rowLabelExtraInfo(BuildContext context, String label, String info){
    return Row(
      children: [
        Expanded(child: _labelExtraInfo(label, 14.0, FontWeight.w600, color: Colors.grey), flex: 1,),
        SizedBox(width: 25.0,),
        Expanded(child: _labelExtraInfo(info, 16.0, FontWeight.w700,), flex: 1,),
      ],
    );
  }



  Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
    return Padding(
        padding: const EdgeInsets.only(right: 10,),
        child: Text( (text == null) ? 'info not yet available' : text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.justify,
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
            _labelExtraInfo(label, 14.0, FontWeight.w600, color: Colors.grey),
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



// class AllDetailsInfoTabAnime extends StatelessWidget {
  
//   final AnimeDetailsEntity anime;
  
//   AllDetailsInfoTabAnime({@required this.anime});

//   @override
//   Widget build(BuildContext context) {

//     return ListView(
//       padding: EdgeInsets.only(top: 0),
//       children: <Widget>[
//         _boxInfo(child: _rowPrincipalInfo(context)),
//         //MiniNativeBannerAds(adPlacementID: "177059330328908_179579176743590",),
//         MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/9899129766',),
//         _boxInfo(child: _columnInfo()),
//         _boxInfo(child: _columnExtrasInfo(context)),
//         BannerPremiumWidget(),
//         //MaxNativeBannerAds(adPlacementID: "177059330328908_179579400076901",),
//       ],
//     );
//   }

//   Widget _boxInfo({Widget child}) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//       elevation: 5.0,
//       borderOnForeground: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0)
//       ),
//       child: child,
//     );
//   }

//   Widget _rowPrincipalInfo(BuildContext context){
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _infoPoster(context),
//           _rowRatingAndNetwork(context)
//         ],
//       ),
//     );
//   }


//   Widget _infoPoster(BuildContext context) {

//     final placeholder = AssetImage('assets/poster_placeholder.png'); 
//     final poster = NetworkImage('https://image.tmdb.org/t/p/w185${ anime.posterPath }');
  
//     return Container(
//       padding: const EdgeInsets.all(4.0),
//       child: Container(
//           width: MediaQuery.of(context).size.width / 4.5,
//           height: 120.0,
//           alignment: Alignment.bottomCenter,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: FadeInImage(
//           image: (anime.posterPath == null) ? placeholder : poster,//? Image Poster Item,
//           placeholder: placeholder, //? PlaceHolder Item,
//           fit: BoxFit.fill,
//         ),
//           ),
//       ),
//     );
//   }







//   Widget _columnInfo() {

//     final List<GenreAnime> genres =  anime.genres;
//     List<int> genreIds = [];
    
//     genres.forEach((item){
//       int id = item.id;
//       genreIds.add(id);
//     });


//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
          
//           _overviewInfo(),
//           ChipsGenresWidget(genres: genreIds, type: 'animes', isWrap: true, )
//           //_chipGenresItem()
//         ],
//       ),
//     );
//   }

//   Widget _rowRatingAndNetwork(BuildContext context) {
//     final _ratingStyle = new TextStyle(
//       color: Colors.pink,
//       fontSize: 20.0,
//       fontWeight: FontWeight.w700
//     );

//     final _voteCountStyle = new TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600
//     );

//     final animeNetwork = anime.networks;

//     final List<NetworkAnime> listAnimeNetwork = new List<NetworkAnime>.from(animeNetwork);

//     final logo = listAnimeNetwork[0].logoPath;

//     final Company company = new Company(
//       id: listAnimeNetwork[0].id.toString(),
//       imagePath: logo,
//       label: listAnimeNetwork[0].name,
//       type: 'animes'
//     );

//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: <Widget>[
//                 Icon(Icons.people, color: Colors.grey[400], size: 25.0, ),
//                 Text(anime.voteCount.toString(), style: _voteCountStyle,),
//               ],
//             ),
//           ),
//           //Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: BigCircularChartRating(anime.voteAverage),
//           ),
//           //Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: GestureDetector(
//               onTap: (){
//                 Navigator.pushNamed(context, '/ExplorerCompany', arguments: company);
//               },
//               child: Column(
//                 children: <Widget>[
//                   Icon(Icons.business, color: Colors.grey[400], size: 25.0, ),
//                   _imageNetworkLogo(logo),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _imageNetworkLogo(String logoPath) {
//      final placeholder = AssetImage('assets/poster_placeholder.png'); 
//      final poster = NetworkImage('https://image.tmdb.org/t/p/w92/$logoPath');



//     return FadeInImage(
//       image: (logoPath == null) ? placeholder : poster,//? Image Poster Item,
//       placeholder: placeholder, //? PlaceHolder Item,
//       fit: BoxFit.contain,
//       height: 40.0,
//       width: 40.0,
//     );

//   }

//   Widget _overviewInfo() {
//     if(anime.overview.isEmpty) return Container();

//     final _overviewStyle = new TextStyle(
//       fontStyle: FontStyle.italic,
//       fontSize: 16.0,
//       fontWeight: FontWeight.w600
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
//       child: Text( (anime.overview == null) ?  'info not yet available' : anime.overview,
//         style: _overviewStyle,
//         textAlign: TextAlign.justify,
//       ),
//     );
//   }

//   Widget _chipGenresItem() {
//     return Container(
//       padding: EdgeInsets.all(4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _fakeChip('Drama', Colors.grey[500].withOpacity(0.2)),
//           _fakeChip('Action', Colors.grey[500].withOpacity(0.2)),
//           _fakeChip('War & Politics', Colors.grey[500].withOpacity(0.2)),
//         ],
//       ),
//     );
//   }

//   Widget _fakeChip(String text, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0 ),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10.0)
//       ), 
//       child: Text(
//         text, 
//         textAlign: TextAlign.center, 
//         style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), ),
//     );
//   }

//   Widget _columnExtrasInfo(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//          _labelExtraInfo(
//             AppLocalizations.of(context).translate('details_more_info'), 
//             22.0, 
//             FontWeight.w600),
//           SizedBox(height: 10.0,),
//           _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_original_title'), 
//             AppLocalizations.of(context).translate('details_orginal_language') 
//           ),
//           _rowDataExtraInfo(
//              anime.originalName, 
//              anime.originalLanguage
//             ),
//           SizedBox(height: 10.0,),
//            _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_release_date'), 
//             AppLocalizations.of(context).translate('details_last_episode') 
//           ),
//           _rowDataExtraInfo(
//              formatterDate(anime.firstAirDate), 
//              formatterDate(anime.lastAirDate)
//             ),
//           SizedBox(height: 10.0,),
//            _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_number_season'), 
//             AppLocalizations.of(context).translate('details_number_episode'), 
//           ),
//           _rowDataExtraInfo(
//              anime.numberOfSeasons.toString(), 
//              anime.numberOfEpisodes.toString()
//             ),
//           SizedBox(height: 10.0,),
//            _rowLabelExtraInfo(
//             AppLocalizations.of(context).translate('details_origin_country'), 
//             AppLocalizations.of(context).translate('details_status'), 
//           ),
//           _rowDataExtraInfo(
//              anime.originCountry.isEmpty ? 'no data' : anime.originCountry.first, 
//              anime.status
//             ),
//           _rowWebExtraInfo(
//             AppLocalizations.of(context).translate('details_web'), 
//             anime.homepage
//           )

//         ],
//       ),
//     );
//   }

//   Widget _labelExtraInfo(String text, double size, FontWeight fontWeight, {Color color}) {
//     return Padding(
//       padding: EdgeInsets.all(1.0),
//       child: Text( (text == null) ? 'info not yet available' : text,
//         style: TextStyle(
//           color: color,
//           fontSize: size,
//           fontWeight: FontWeight.w600,
//         ),
//         textAlign: TextAlign.justify,
//       ),
//     ); 
//   }

//   Widget _rowLabelExtraInfo(String label1, String label2){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(label1, 14.0, FontWeight.w600, color: Colors.grey),
//           _labelExtraInfo(label2, 14.0, FontWeight.w600, color: Colors.grey)
//         ],
//       ),
//     );
//   }

//   Widget _rowDataExtraInfo(String label1, String label2){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _labelExtraInfo(label1, 16.0, FontWeight.w600,),
//           Spacer(),
//           _labelExtraInfo(label2, 16.0, FontWeight.w600, ), 
//         ],
//       ),
//     );
//   }

//  Widget _rowWebExtraInfo(String label, String data,){
//     return GestureDetector(
//       onTap: () => launch(data),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             _labelExtraInfo(label, 14.0, FontWeight.w800),
//             Expanded(
//               child: Text(
//                 (data == null ) ? 'info not yet available' : data,
//                 overflow: TextOverflow.ellipsis ,
//                 style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 16.0),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }


// }
