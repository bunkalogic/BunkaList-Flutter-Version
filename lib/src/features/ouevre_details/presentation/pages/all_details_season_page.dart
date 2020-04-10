import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_season_info/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsSeasonPage extends StatefulWidget {

  final Map<String, dynamic> data;

  const AllDetailsSeasonPage({@required this.data});

  @override
  _AllDetailsSeasonPageState createState() => _AllDetailsSeasonPageState();
}

class _AllDetailsSeasonPageState extends State<AllDetailsSeasonPage> {


  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBarSeason(),
      body: BlocProvider<SeasonInfoBloc>(
        builder: (_) => serviceLocator<SeasonInfoBloc>(),
        child: SeasonInfoBodyWidget(
          id: widget.data['id'], 
          seasonId: widget.data['seasonId'],
          ),
      ),
    );
    

    
  }

  Widget _appBarSeason() {
    return AppBar(
      leading: AppBarButtonBack(),
      title: Text('Season ${widget.data['seasonId']}'),
    );
  }
  
}

class SeasonInfoBodyWidget extends StatefulWidget {

  final int id;
  final int seasonId;

  SeasonInfoBodyWidget({this.id, this.seasonId});

  @override
  _SeasonInfoBodyWidgetState createState() => _SeasonInfoBodyWidgetState();
}

class _SeasonInfoBodyWidgetState extends State<SeasonInfoBodyWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     BlocProvider.of<SeasonInfoBloc>(context)
    ..add(GetInfoSeason(widget.id, widget.seasonId));
  }

  


  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SeasonInfoBloc, SeasonInfoState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is Loaded){

            if(state.episode.isEmpty || state.episode.length <= 0){
             
             return EmptyIconWidget();

            }else{
              return SeasonInfoWidget(episodes: state.episode);
            }
            
          }else if(state is Error){
            
            return EmptyIconWidget();
            
          }

          return EmptyIconWidget();

        },
      ),
    );
  }
}


class SeasonInfoWidget extends StatelessWidget{

  final List<EpisodeEntity> episodes;

  SeasonInfoWidget({@required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _listEpisodeSeason(),
    );
  }

  

  Widget _listEpisodeSeason() {
    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, i) => _episodeItem(episodes[i]),
    );

  }

  Widget _episodeItem(EpisodeEntity episode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      child: Container(
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: _stackInfoEpisode(episode),
        ),
      ),
    );
  }

  Widget _stackInfoEpisode(EpisodeEntity episode) {
    return Stack(
      children: <Widget>[
        _itemImageEpisode(episode),
        _columnEpisodeTextInfo(episode)
      ],
    );
  }

  Widget _itemImageEpisode(EpisodeEntity episode) {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage('https://image.tmdb.org/t/p/original/${episode.stillPath}'),
          ),
      ),
    );
  }

  Widget _columnEpisodeTextInfo(EpisodeEntity episode) {
    return Container(
      child: Column(
        children: <Widget>[
          _titleEpisodeItem(episode),
          _resumeEpisodeItem(episode),
          _rowRateAndDateEpisodeItem(episode),
        ]
      ),
    );
  }

  Widget _titleEpisodeItem(EpisodeEntity episode) {
    final String title = '${episode.episodeNumber}. ${episode.name}';
    return Padding(
        padding: EdgeInsets.all(1.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
          ),
        ),
    );
  }

  Widget _resumeEpisodeItem(EpisodeEntity episode) {
    return Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            episode.overview,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
               shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
            ),
            textAlign: TextAlign.justify,
          ),
    );
  }

  Widget _rowRateAndDateEpisodeItem(EpisodeEntity episode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.stars, color: Colors.deepOrange, size: 25.0,),
          SizedBox(width: 4.0,),
          Text(episode.voteAverage.toString(), 
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 16.0, 
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
            ),
          ),
          Spacer(),
          Icon(Icons.today, color: Colors.grey[500], size: 25.0,),
          SizedBox(width: 4.0,),
          Text(formatterDate(episode.airDate),
           style: TextStyle( 
             fontSize: 14.0, 
             fontWeight: FontWeight.w500,
             color: Colors.white,
              shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
             ),
             )
        ],
      ),
    );
  }

}