import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/utils/format_date.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:flutter/material.dart';



class AllDetailsEpisodePage extends StatefulWidget {

  final Episode episode;

  AllDetailsEpisodePage({@required this.episode});

  @override
  _AllDetailsEpisodePageState createState() => _AllDetailsEpisodePageState();
}

class _AllDetailsEpisodePageState extends State<AllDetailsEpisodePage> {
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
          return <Widget>[
            _createSliverAppBar(innerBoxScrolled),
          ];
        },
        body: BuildBodyEpisodePage(episode: widget.episode,),
        
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
        flexibleSpace: BuildHeaderEpisodePage(episode: widget.episode,),
    );

  }

}



class BuildHeaderEpisodePage extends StatefulWidget {


  final Episode episode;

  BuildHeaderEpisodePage({@required this.episode});

  @override
  _BuildHeaderEpisodePageState createState() => _BuildHeaderEpisodePageState();
}

class _BuildHeaderEpisodePageState extends State<BuildHeaderEpisodePage> {
  
  Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    
    return FlexibleSpaceBar(
    stretchModes: <StretchMode>[
      StretchMode.zoomBackground,
      // StretchMode.blurBackground,
      // StretchMode.fadeTitle
    ],       
    collapseMode: CollapseMode.parallax,
    background: _stackInfoBackground(context),
    centerTitle: true,
    titlePadding: const EdgeInsets.only(bottom: 10.0),
    title: _titleInfo(context),
  );

  }

  Widget _titleInfo(BuildContext context){


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
        '${widget.episode.episodeNumber} ${widget.episode.name}',
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
          formatterDate(widget.episode.airDate),
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

  

  _stackInfoBackground(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          _imageBackground(),
          _containerRounded(),
          _subtitleInfo(),
        ],
      ),
    );
  }

  Widget _imageBackground() {
     final placeholder = AssetImage('assets/poster_placeholder.png'); 
     final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ widget.episode.stillPath }');


    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FadeInImage(
          image: (widget.episode.stillPath == null) ? placeholder : poster,//? Image Poster Item,
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





class BuildBodyEpisodePage extends StatefulWidget {
  
  
  final Episode episode;

  BuildBodyEpisodePage({@required this.episode});


  @override
  _BuildBodyEpisodePageState createState() => _BuildBodyEpisodePageState();
}

class _BuildBodyEpisodePageState extends State<BuildBodyEpisodePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        _rowPrincipalInfo(context),
        SizedBox(height: 5,),
        (widget.episode.overview.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('label_summary')),
        _overviewInfo(),
        SizedBox(height: 5.0,),
        (widget.episode.crew == null || widget.episode.crew.isEmpty) ? Container() : _titleSection(AppLocalizations.of(context).translate('crew')),
        _buildListCrew()
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
    if(widget.episode.overview.isEmpty) return Container();

    final _overviewStyle = new TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 14.0,
      fontWeight: FontWeight.w700
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Text( (widget.episode.overview == null) ?  'info not yet available' : widget.episode.overview,
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
        _labelExtraInfo(formatterDate(widget.episode.airDate), 16.0, FontWeight.w700,),
        SizedBox(height: 4.0,),
        _labelExtraInfo(AppLocalizations.of(context).translate('details_number_season'), 13.0, FontWeight.w500, color: Colors.grey),
        _labelExtraInfo(widget.episode.seasonNumber.toString(), 16.0, FontWeight.w700,),
      ],
    );
  }


   Widget _infoPoster(BuildContext context) {


    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ widget.episode.stillPath }');
  
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
          image: (widget.episode.stillPath == null) ? placeholder : poster,//? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.fill,
        ),
          ),
      ),
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


  Widget _buildListCrew(){

    if(widget.episode.crew == null) return SizedBox.shrink();


    return Container(
        height: 280.0,
        width: double.infinity,
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          scrollDirection: Axis.horizontal,
          itemCount: widget.episode.crew.length,
          itemBuilder: (context, i)=> _personItem(context, widget.episode.crew[i]),
        ),
    );

  }


  Widget _personItem(BuildContext context, Crew crew ){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/AllDetailsPeople', arguments: getIdAndNameCast(crew.id, crew.name)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Column(
          children: <Widget>[
            // _personPhotoItem(cast),
            _peopleImage(crew),
            SizedBox(height: 10.0,),
            _columnName(crew),
          ],
        ),
      ),
    );
  }


  Widget _peopleImage(Crew crew) {

    final placeholder = AssetImage('assets/photo-placeholder.png');
    final photo = NetworkImage('https://image.tmdb.org/t/p/original${crew.profilePath}');

    return Container(
      padding: const EdgeInsets.only(top:15.0),
      child: Container(
        width:  109.3,
        height: 160.0,
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
              image: (crew.profilePath == null) ? placeholder : photo,//? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.contain,
            ),
          ),
      ),
    );

    
  }

  

   

  Widget _columnName(Crew crew) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(crew.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),),
          Text(crew.character == null ? crew.job : crew.character, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.grey),),
        ],
      ),
    );
  }


}







