
import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_season_info/seasoninfo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsSeasonTab extends StatefulWidget {

     final int id;
    final String type;

  AllDetailsSeasonTab({@required this.id, @required this.type});



  @override
  _AllDetailsSeasonTabState createState() => _AllDetailsSeasonTabState();
}

class _AllDetailsSeasonTabState extends State<AllDetailsSeasonTab> {


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

          }else if(state is LoadedSerie){

            return SeasonSerieItems(serie: state.serie,);

          }else if(state is LoadedAnime){

            return SeasonAnimeItems(anime: state.anime,);

          }else if(state is Error){
            
            return EmptyIconWidget();

          }

          return EmptyIconWidget();

        },
      ),
    );
  }

  
}


class SeasonSerieItems extends StatelessWidget{

  final SerieDetailsEntity serie;

  SeasonSerieItems({@required this.serie});

  


  @override
  Widget build(BuildContext context) {
    final serieSeason = serie.seasonSerie;

    final List<SeasonSerie> listSerieSeasons = new List<SeasonSerie>.from(serieSeason);

    if(listSerieSeasons.isEmpty){
      return Center(child: Text('No data Seasons'),);
    }else{
      return ListView.builder(
       itemCount: listSerieSeasons.length,
       itemBuilder:  (context, i) => _itemSeason(context, listSerieSeasons[i]),
      );
    }
    
    
  }

  Widget _itemSeason(BuildContext context, SeasonSerie seasonItem) {
    

    return GestureDetector(
      onTap: () =>  Navigator.pushNamed(context, '/AllDetailsSeason', arguments: getIdAndSeasonId(serie.id , seasonItem.seasonNumber)),
      child: Container(
    height: 180.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: _rowSeasonInfo(context, seasonItem),
    ),
        ),
      );
  }

  Widget _rowSeasonInfo(BuildContext context, SeasonSerie seasonItem) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _imageSeasonItem(seasonItem), flex: 2 ),
        Expanded(child: _columnSeasonTextInfo(context, seasonItem) , flex: 3 ),
        Expanded(child: _buttomDetailsSeason(context, seasonItem), flex: 1)
      ],
    );
  }

  Widget _imageSeasonItem(SeasonSerie seasonItem) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original/${seasonItem.posterPath}');


    return Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (seasonItem.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _columnSeasonTextInfo(BuildContext context, SeasonSerie seasonItem) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _titleSeasonItem(seasonItem),
          _numberEpisodeSeasonItem(context ,seasonItem),
          _releaseDateSeasonItem(seasonItem)

        ],
      ),
    );
  }

  Widget _titleSeasonItem(SeasonSerie seasonItem) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          seasonItem.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic
          ),
        ),
    );
  }

  Widget _numberEpisodeSeasonItem(BuildContext context, SeasonSerie seasonItem) {

    final String episodeCount = seasonItem.episodeCount.toString();
    final String label = AppLocalizations.of(context).translate('episode');

    final String episodes = '$episodeCount  $label';

    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          episodes,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
    );
  }

  Widget _releaseDateSeasonItem(SeasonSerie seasonItem) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          formatterDate(seasonItem.airDate),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
    );
  }

  Widget _buttomDetailsSeason(BuildContext context, SeasonSerie seasonItem) {
    return IconButton(
      icon: Icon(Icons.chevron_right, size: 40.0, color: Colors.deepOrange,),
      onPressed: () => null,
    );
  }

}


class SeasonAnimeItems extends StatelessWidget{

  final AnimeDetailsEntity anime;

  SeasonAnimeItems({@required this.anime});  


  @override
  Widget build(BuildContext context) {
    final animeSeason = anime.seasonAnime;

    final List<SeasonAnime> listAnimeSeasons = new List<SeasonAnime>.from(animeSeason);

    if(listAnimeSeasons.isEmpty){
      return Center(child: Text('No data Seasons'),);
    }else{
      return ListView.builder(
       itemCount: listAnimeSeasons.length,
       itemBuilder:  (context, i) => _itemSeason(context, listAnimeSeasons[i]),
      );
    }
    
    
  }

  Widget _itemSeason(BuildContext context, SeasonAnime seasonItem) {
    return GestureDetector(
      onTap: () =>  Navigator.pushNamed(context, '/AllDetailsSeason', arguments: getIdAndSeasonId(anime.id , seasonItem.seasonNumber)),
      child: Container(
    height: 180.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: _rowSeasonInfo(context, seasonItem),
    ),
        ),
      );
  }

  Widget _rowSeasonInfo(BuildContext context, SeasonAnime seasonItem) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: _imageSeasonItem(seasonItem), flex: 2 ),
        Expanded(child: _columnSeasonTextInfo(context, seasonItem) , flex: 3 ),
        Expanded(child: _buttomDetailsSeason(context, seasonItem), flex: 1)
      ],
    );
  }

  Widget _imageSeasonItem(SeasonAnime seasonItem) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/original/${seasonItem.posterPath}');


    return Container(
      width: 110.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: (seasonItem.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _columnSeasonTextInfo(BuildContext context, SeasonAnime seasonItem) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _titleSeasonItem(seasonItem),
          _numberEpisodeSeasonItem(context ,seasonItem),
          _releaseDateSeasonItem(seasonItem)

        ],
      ),
    );
  }

  Widget _titleSeasonItem(SeasonAnime seasonItem) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          seasonItem.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic
          ),
        ),
    );
  }

  Widget _numberEpisodeSeasonItem(BuildContext context, SeasonAnime seasonItem) {

    final String episodeCount = seasonItem.episodeCount.toString();
    final String label = AppLocalizations.of(context).translate('episode');

    final String episodes = '$episodeCount  $label';

    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          episodes,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
    );
  }

  Widget _releaseDateSeasonItem(SeasonAnime seasonItem) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          formatterDate(seasonItem.airDate),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
    );
  }

  Widget _buttomDetailsSeason(BuildContext context, SeasonAnime seasonItem){
    return IconButton(
      icon: Icon(Icons.chevron_right, size: 40.0, color: Colors.deepOrange,),
      onPressed: () => null
    );
  }


}