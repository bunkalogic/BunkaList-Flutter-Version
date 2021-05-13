import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
          return <Widget>[
            _createSliverAppBar(innerBoxScrolled),
          ];
        },
        body: BlocProvider<SeasonInfoBloc>(
          create: (_) => serviceLocator<SeasonInfoBloc>(),
          child: SeasonInfoBodyWidget(
            id: widget.data['id'], 
            seasonId: widget.data['seasonId'],
            title: widget.data['title'],
          )
        ),
        
      ),
    );

      

    
  }

  Widget _createSliverAppBar(bool innerBoxScrolled) {

    return SliverAppBar(
        leading: AppBarButtonBack(),
        pinned: true,
        stretch: true,
        forceElevated: innerBoxScrolled,
        elevation: 10.0,
        expandedHeight: 240,
        flexibleSpace: BlocProvider<SeasonInfoBloc>(
          create: (_) => serviceLocator<SeasonInfoBloc>(),
          child: BuildHeaderSeasonWidget(
            id: widget.data['id'], 
            seasonId: widget.data['seasonId'],
            title: widget.data['title'],
          )
        ),        
    );

  }

  
  
}



class BuildHeaderSeasonWidget extends StatefulWidget {

  final int id;
  final int seasonId;
  final String title;

  BuildHeaderSeasonWidget({this.id, this.seasonId, this.title});

  @override
  _BuildHeaderSeasonWidgetState createState() => _BuildHeaderSeasonWidgetState();
}

class _BuildHeaderSeasonWidgetState extends State<BuildHeaderSeasonWidget> {
  

  Preferences prefs = Preferences();

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

            if(state.season == null){
             
             return EmptyIconWidget();

            }else{
              return _buildHeaderSeason(state.season);
            }
            
          }else if(state is Error){
            
            return EmptyIconWidget();
            
          }

          return EmptyIconWidget();

        },
      ),
    );
  }



  Widget _buildHeaderSeason(SeasonEntity season){

    return FlexibleSpaceBar(
    stretchModes: <StretchMode>[
      StretchMode.zoomBackground,
      // StretchMode.blurBackground,
      // StretchMode.fadeTitle
    ],       
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context, season),
    centerTitle: true,
    titlePadding: const EdgeInsets.only(bottom: 10.0),
    title: _titleInfo(context ,season),
  );

  }


  
  Widget _titleInfo(BuildContext context, SeasonEntity season){


    String seasonLabel = AppLocalizations.of(context).translate('season');

    final mediaQuery = MediaQuery.of(context);

    final availableWidth = mediaQuery.size.width - 120;

    List<Shadow> shadowBlack = [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))];
    List<Shadow> shadowWhite = [Shadow(blurRadius: 1.0, color:  Colors.white, offset: Offset(0.3, 0.3))];

    return ConstrainedBox(
        constraints: BoxConstraints(
    maxWidth: availableWidth,
        ),
        child: Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    child: Text(
        '$seasonLabel ${widget.seasonId}',
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
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
        child: Text(
          '${widget.title}',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 16.0,
            shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.7, 0.7))],
            fontWeight: FontWeight.w600 
          ),
        ),
      ),
    );

  }

  

  _stackInfoBackground(BuildContext context, SeasonEntity season) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _imageBackground(season),
          _containerRounded(),
          _subtitleInfo(),
        ],
      ),
    );
  }

  Widget _imageBackground(SeasonEntity season) {
     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ season.posterPath }');


    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FadeInImage(
          image: (season.posterPath == null) ? placeholder : poster,//? Image Poster Item,
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
          color: prefs.whatModeIs ? prefs.whatDarkIs ? Colors.black : Colors.blueGrey[900] : Colors.grey[50],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25)
          )
        ),
        
        height: 55.0,
      ),
    );
  






  }

}



class SeasonInfoBodyWidget extends StatefulWidget {

  final int id;
  final int seasonId;
  final String title;

  SeasonInfoBodyWidget({this.id, this.seasonId, this.title});

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

            if(state.season == null){
             
             return EmptyIconWidget();

            }else{
              return SeasonInfoWidget(season: state.season);
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

  final SeasonEntity season;

  SeasonInfoWidget({@required this.season});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        _rowPrincipalInfo(context),
        SizedBox(height: 5,),
        (season.overview.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_summary')),
        _overviewInfo(),
        SizedBox(height: 5,),
        _titleSection(AppLocalizations.of(context).translate('episode')),
        Expanded(child: _listEpisodeSeason()),
      ],
    );
  }


  Widget _titleSection(String title){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 30),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _overviewInfo() {
    if(season.overview.isEmpty) return Container();

    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 14.0,
      fontWeight: FontWeight.w700
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text( (season.overview == null) ?  'info not yet available' : season.overview,
        style: _overviewStyle,
        textAlign: TextAlign.justify,
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
        _labelExtraInfo(AppLocalizations.of(context).translate('details_release_date') , 13.0, FontWeight.w500, color: Colors.grey),
        _labelExtraInfo(formatterDate(season.airDate), 16.0, FontWeight.w700,),
        SizedBox(height: 4.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_season'), 13.0, FontWeight.w500, color: Colors.grey),
        _labelExtraInfo(season.seasonNumber.toString(), 16.0, FontWeight.w700,),
        SizedBox(height: 4.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_episode'), 13.0, FontWeight.w500, color: Colors.grey),
        _labelExtraInfo(season.episodes.length.toString(), 16.0, FontWeight.w700,),
        
        
      ],
    );
  }


   Widget _infoPoster(BuildContext context) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ season.posterPath }');
  
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
          image: (season.posterPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
    );
  } 

  

  Widget _listEpisodeSeason() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: season.episodes.length,
        itemBuilder: (context, i) => _buildEpisodes(context, season.episodes[i]),
      ),
    );

  }

  Widget _buildEpisodes(BuildContext context, Episode episode){

    // if(episode.airDate == 'no data') return SizedBox.shrink();

    final Preferences prefs = new Preferences();    

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ episode.stillPath }');

    final labelSeason = AppLocalizations.of(context).translate('season');
    final labelEpisode = AppLocalizations.of(context).translate('episode');

    final releaseDate = formatterDate(episode.airDate);

    return ListTile(
      onTap: () {
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
          image: (episode.stillPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
      title: Text(
        episode.name.isEmpty 
        ? '$labelEpisode ${episode.episodeNumber}'
        : episode.name,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.justify,

      ),
      subtitle: Text(
        '$labelSeason ${episode.seasonNumber} $labelEpisode ${episode.episodeNumber} \n $releaseDate',
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
}