import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/empty_last_added_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/emptys_list_profile_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/item_watching_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stack_card/flutter_stack_card.dart';
import 'package:percent_indicator/percent_indicator.dart';


class CardStackWatchingWidget extends StatefulWidget {
  
  final String type; 
  final ListProfileQuery status;

  CardStackWatchingWidget({
    @required this.type,
    @required this.status
  });


  @override
  _CardStackWatchingWidgetState createState() => _CardStackWatchingWidgetState();
}

class _CardStackWatchingWidgetState extends State<CardStackWatchingWidget> {
  

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListsBloc, GetListsState>(
    builder: (context, state) {
      if(state is GetListsLoading){

        return Container(
          height: MediaQuery.of(context).size.height * 0.33,
          width: MediaQuery.of(context).size.width / 0.80,
          child: LoadingCustomWidget()
        );


      }else if(state is GetListsLoaded){

        if(state.ouevreList.isEmpty){
          return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("watching_empty_label"),
            color: Colors.blueAccent[400],
            icon: Icons.play_circle_outline,
            );
        }else{

          return  StackedCardsWatchingBuilder(ouevreList: state.ouevreList);

        }

        

      }else if(state is GetlistsError){

       return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("watching_empty_label"),
            color: Colors.blueAccent[400],
            icon: Icons.play_circle_outline,
            );

      }

      return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("watching_empty_label"),
            color: Colors.blueAccent[400],
            icon: Icons.play_circle_outline,
            );

    },
    );
  }
}


class StackedCardsWatchingBuilder extends StatefulWidget {
   
  final List<OuevreEntity> ouevreList;

  StackedCardsWatchingBuilder({@required this.ouevreList});

  @override
  _StackedCardsWatchingBuilderState createState() => _StackedCardsWatchingBuilderState();
}

class _StackedCardsWatchingBuilderState extends State<StackedCardsWatchingBuilder> {
  
  int position = 0;

  Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: (){
        //    Navigator.pushNamed(
        // context, '/AllDetails', 
        // arguments: 
        //   getIdAndType(
        //   widget.ouevreList[position].oeuvreId, 
        //   widget.ouevreList[position].oeuvreType,  
        //   widget.ouevreList[position].oeuvreTitle)
        // );

          showDialog(
            context: context,
            builder: (_) {
              return Dialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 30.0
              ),  
              elevation: 5,
              backgroundColor: Colors.transparent,
              child: BuildItemWatchingDetailsWidget(ouevreEntity: widget.ouevreList[position]),
              );
            },
          ); 
        },
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width / 0.80,
          padding: const EdgeInsets.only(
            top: 18.0,  
          ),
          child: StackCard.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,  
                ),
                child: new BlocProvider<OuevreDetailsBloc>(
                  create: (_) => serviceLocator<OuevreDetailsBloc>(),
                  child:  !prefs.currentDesignWatching 
                      ? ItemImageStackedCards(ouevreEntity: widget.ouevreList[index],) 
                      : ItemRowStackedCards(ouevreEntity: widget.ouevreList[index],), 
                ),
              );
            },
            onSwap: (value) {
              setState(() {
                position = value;
              });
            },
            stackType: StackType.middle,
            stackOffset: const Offset(28.0, -10.0),
            dimension: StackDimension(
              height: 260,  //MediaQuery.of(context).size.height * 0.36,
              width: MediaQuery.of(context).size.width / 0.85,
            ), 
            itemCount: widget.ouevreList.length
          ),
        ), 
    );
  }
}

//?  Item Image Stacked Cards

class ItemImageStackedCards extends StatefulWidget {
  final OuevreEntity ouevreEntity;

  ItemImageStackedCards({
    @required this.ouevreEntity,
  });

  @override
  _ItemImageStackedCardsState createState() => _ItemImageStackedCardsState();
}

class _ItemImageStackedCardsState extends State<ItemImageStackedCards> {
  
  
  // @override
  // void initState() {
  //   // BlocProvider.of<OuevreDetailsBloc>(context)
  //   // ..add(GetDetailsOuevre(widget.ouevreEntity.oeuvreId, widget.ouevreEntity.oeuvreType));
  //   // super.initState();
  // }

  SerieDetailsEntity serieDetailsEntity;
  AnimeDetailsEntity animeDetailsEntity;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          clipBehavior: Clip.none, 
          fit: StackFit.expand,
          children: [
            _cardItem(),
            _titleOfItem(),
            _progressBarAndLabel()
          ],
        ),
      ),
    );
  }

  

  Widget _titleOfItem() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 15.0,
          right: 15.0
        ),
        child: Text(
          widget.ouevreEntity.oeuvreTitle,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(blurRadius: 1.5, color: Colors.black, offset: Offset(1.5, 1.5))
            ]
          ),
        ),
      )
    );
  }

  Widget _cardItem() {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage(widget.ouevreEntity.oeuvrePoster);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          placeholder: placeholder, 
          image: poster,
          fit: BoxFit.fill,
        ),
      ), 
    );
  }

  Widget _progressBarAndLabel() {

     

    if (widget.ouevreEntity.seasonTotal != null && widget.ouevreEntity.episodeTotal != null){
      
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _labelSeasonAndEpisode(),
            new BlocProvider<AddOuevreBloc>(
              create: (_) => serviceLocator<AddOuevreBloc>(),
              child: ProgressBarEpisode(ouevreEntity: widget.ouevreEntity, serieDetailsEntity: serieDetailsEntity, animeDetailsEntity: animeDetailsEntity)
            ),
          ],
        ),
       );
          
    }else{

      return _getSeasonAndEpisode();

    } 
    
  }


  Widget _getSeasonAndEpisode(){
    
    
    BlocProvider.of<OuevreDetailsBloc>(context)
      ..add(GetDetailsOuevre(widget.ouevreEntity.oeuvreId, widget.ouevreEntity.oeuvreType));

      return BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
      builder: (context, state){

        if(state is Loading){
          return LoadingCustomWidget();
        }

        if(state is LoadedSerie){

          serieDetailsEntity = state.serie;
          

        }

        if(state is LoadedAnime){

           animeDetailsEntity = state.anime;

        }

        return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _labelSeasonAndEpisode(),
            new BlocProvider<AddOuevreBloc>(
              create: (_) => serviceLocator<AddOuevreBloc>(),
              child: ProgressBarEpisode(ouevreEntity: widget.ouevreEntity, serieDetailsEntity: serieDetailsEntity, animeDetailsEntity: animeDetailsEntity)
            ),
          ],
        ),
       );
      }
    );
  }


  Widget _labelSeasonAndEpisode(){

    TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16.0, 
      fontWeight: FontWeight.w800,
      shadows: [
      Shadow(blurRadius: 0.5, color: Colors.black, offset: Offset(1.0, 1.0))
      ]
    );

    final String season = AppLocalizations.of(context).translate("season");

    final String watchSeason = widget.ouevreEntity.seasons.toString();

    final String episode = AppLocalizations.of(context).translate("episode");

    final String watchEpisode = widget.ouevreEntity.episodes.toString();

    return Padding(
      padding: const EdgeInsets.only(
        top: 35.0,
      ),
      child: Column(
        children: [
          Text('$season $watchSeason ', style: textStyle,),
          SizedBox(height: 5.0,),
          Text('$episode $watchEpisode', style: textStyle,),
        ],
      ),
    );

  }


}



//?  Item Row Stacked Cards

class ItemRowStackedCards extends StatefulWidget {
  final OuevreEntity ouevreEntity;

  ItemRowStackedCards({
    @required this.ouevreEntity,
  });

  @override
  _ItemRowStackedCardsState createState() => _ItemRowStackedCardsState();
}

class _ItemRowStackedCardsState extends State<ItemRowStackedCards> {
  
  Preferences prefs = Preferences();
  SerieDetailsEntity serieDetailsEntity;
  AnimeDetailsEntity animeDetailsEntity;

  
  // @override
  // void initState() {
  //   BlocProvider.of<OuevreDetailsBloc>(context)
  //   ..add(GetDetailsOuevre(widget.ouevreEntity.oeuvreId, widget.ouevreEntity.oeuvreType));
  //   super.initState();
  // }

  

  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
       child: Container(
         child: _itemInfo(),
         height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: getBackgroundColorItemTheme()
          ),
       ),
     ); 
  }

//    Color _getTabbarBackgroundColor(){

//     final bool theme = prefs.whatModeIs;
//     final bool dark = prefs.whatDarkIs;
    
//     if(theme && dark == false){
//       return Colors.blueGrey[800];
//     }else if(theme && dark){
//       return Colors.grey[900];
//     }else{
//       return Colors.grey[100];
//     }
//  }

  Widget _itemInfo(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardItem(),
        SizedBox(width: 6.0,),
        Expanded(child: _columnCenterItem())
      ],
    );
  }

  Widget _columnCenterItem(){
    return Container(
      child: Column(
        children: <Widget>[
          _titleOfItem(),
          SizedBox(height: 15.0,),
          //_chipGenresItem(widget.movie),
          _progressBarAndLabel(),
          //SizedBox(height: 35.0,),
          // Expanded(child: _rowButtons()),
        ],
      ),
    );
  }
  

  Widget _titleOfItem() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 15.0,
          right: 15.0
        ),
        child: Text(
          widget.ouevreEntity.oeuvreTitle,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            // color: Colors.white,
            // shadows: [
            //   Shadow(
            //     color: Colors.black,
            //     blurRadius: 2.5,
            //   )
            // ]
          ),
        ),
      )
    );
  }

  Widget _cardItem() {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage(widget.ouevreEntity.oeuvrePoster);

     final _poster = Container(
      width: 140.0,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          image: poster,
          placeholder: placeholder,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Container(
      //margin: EdgeInsets.only(right: 25.0),
      child: _poster,
    );

  }

  Widget _progressBarAndLabel() {

     

    if (widget.ouevreEntity.seasonTotal != null && widget.ouevreEntity.episodeTotal != null){
      
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _labelSeasonAndEpisode(),
            new BlocProvider<AddOuevreBloc>(
              create: (_) => serviceLocator<AddOuevreBloc>(),
              child: ProgressBarEpisode(ouevreEntity: widget.ouevreEntity, serieDetailsEntity: serieDetailsEntity, animeDetailsEntity: animeDetailsEntity)
            ),
          ],
        ),
       );
          
    }else{

      return _getSeasonAndEpisode();

    } 
    
  }


  Widget _getSeasonAndEpisode(){
    
    
    BlocProvider.of<OuevreDetailsBloc>(context)
      ..add(GetDetailsOuevre(widget.ouevreEntity.oeuvreId, widget.ouevreEntity.oeuvreType));

      return BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
      builder: (context, state){

        if(state is Loading){
          return LoadingCustomWidget();
        }

        if(state is LoadedSerie){

          serieDetailsEntity = state.serie;
          

        }

        if(state is LoadedAnime){

           animeDetailsEntity = state.anime;

        }

        return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _labelSeasonAndEpisode(),
            new BlocProvider<AddOuevreBloc>(
              create: (_) => serviceLocator<AddOuevreBloc>(),
              child: ProgressBarEpisode(ouevreEntity: widget.ouevreEntity, serieDetailsEntity: serieDetailsEntity, animeDetailsEntity: animeDetailsEntity)
            ),
          ],
        ),
       );
      }
    );
  }


  Widget _labelSeasonAndEpisode(){

    TextStyle textStyle = TextStyle(
      // color: Colors.white,
      fontSize: 16.0, 
      fontWeight: FontWeight.w600,
    );


    final String season = AppLocalizations.of(context).translate("season");

    final String watchSeason = widget.ouevreEntity.seasons.toString();

    final String episode = AppLocalizations.of(context).translate("episode");

    final String watchEpisode = widget.ouevreEntity.episodes.toString();


    return Column(
      children: [
        Text('$season $watchSeason ', style: textStyle,),
        SizedBox(height: 5.0,),
        Text('$episode $watchEpisode', style: textStyle,),
      ],
    );

  }


}



class ProgressBarEpisode extends StatefulWidget {
  
  final OuevreEntity ouevreEntity;
  final SerieDetailsEntity serieDetailsEntity;
  final AnimeDetailsEntity animeDetailsEntity;
  
  const ProgressBarEpisode({
    @required this.ouevreEntity,
    this.serieDetailsEntity,
    this.animeDetailsEntity,

  });

  

  @override
  _ProgressBarEpisodeState createState() => _ProgressBarEpisodeState();
}

class _ProgressBarEpisodeState extends State<ProgressBarEpisode> {
  @override
  Widget build(BuildContext context) {
    
    int totalEpisode = widget.ouevreEntity.episodeTotal;
    int watchEpisode = widget.ouevreEntity.episodes;

    if(widget.ouevreEntity.oeuvreType == 'tv' && widget.serieDetailsEntity != null &&  widget.ouevreEntity.seasonTotal == null && widget.ouevreEntity.episodeTotal == null){
      updateSerieTotalSeasonAndEpisode();
      totalEpisode = widget.serieDetailsEntity.numberOfEpisodes;
    } 
    if(widget.ouevreEntity.oeuvreType == 'anime' && widget.animeDetailsEntity != null  && widget.ouevreEntity.seasonTotal == null && widget.ouevreEntity.episodeTotal == null){
      updateAnimeTotalSeasonAndEpisode();
      totalEpisode = widget.animeDetailsEntity.numberOfEpisodes;
    }


    double percentOfWatch = widget.ouevreEntity.episodes / totalEpisode;

    int episodesLeft = totalEpisode - watchEpisode;

    final String labelEpisodesLeft = AppLocalizations.of(context).translate("label_epiosde_left");

    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0,
          left: 15.0,
          right: 15.0
        ),
      child: Column(
        children: [
          LinearPercentIndicator(
            lineHeight: 20.0,
            animation: true,
            percent: percentOfWatch,
            backgroundColor: Colors.blueGrey.withOpacity(0.7),
            center: Text(
            '$watchEpisode / $totalEpisode',
              style: TextStyle(
              color: Colors.white,
              fontSize: 16.0, 
              fontWeight: FontWeight.w800,
              shadows: [
              Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
              ]
            ),
            ),
            linearGradient: LinearGradient(
              colors: percentOfWatch <= 0.2
              ? 
              [
                Colors.deepPurpleAccent[400].withOpacity(0.9),
                Colors.deepPurpleAccent.withOpacity(0.9),
                Colors.pinkAccent.withOpacity(0.9),
              ]
              :
              [
                Colors.deepPurpleAccent[400].withOpacity(0.9),
                Colors.deepPurpleAccent.withOpacity(0.9),
                Colors.pinkAccent.withOpacity(0.9),
                Colors.pinkAccent[400].withOpacity(0.9)
              ]
            ),
          ),
          Text(
            '$episodesLeft $labelEpisodesLeft',
              style: TextStyle(
              color: Colors.white,
              fontSize: 16.0, 
              fontWeight: FontWeight.w800,
              shadows: [
              Shadow(blurRadius: 2.0, color: Colors.black, offset: Offset(1.5, 1.5))
              ]
            ),
          ),
        ],
      ),
    );
  }


  void updateSerieTotalSeasonAndEpisode(){
    
    OuevreEntity item = widget.ouevreEntity;

    item.episodeTotal =  widget.serieDetailsEntity.numberOfEpisodes;
    item.seasonTotal = widget.serieDetailsEntity.numberOfSeasons;

    BlocProvider.of<AddOuevreBloc>(context)..add(
      ButtonAddPressed( type: item.oeuvreType, ouevreEntity: item )
    );

  }

  void updateAnimeTotalSeasonAndEpisode(){
    
    OuevreEntity item = widget.ouevreEntity;

    item.episodeTotal =  widget.animeDetailsEntity.numberOfEpisodes;
    item.seasonTotal = widget.animeDetailsEntity.numberOfSeasons;

    BlocProvider.of<AddOuevreBloc>(context)..add(
      ButtonAddPressed( type: item.oeuvreType, ouevreEntity: item )
    );

  }
}