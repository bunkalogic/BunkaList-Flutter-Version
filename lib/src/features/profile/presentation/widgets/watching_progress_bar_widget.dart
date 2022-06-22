import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';


import '../../../../../injection_container.dart';


class WatchingProgressBar extends StatefulWidget {

  final OuevreEntity ouevreEntity;

  WatchingProgressBar({@required this.ouevreEntity});

  @override
  State<WatchingProgressBar> createState() => _WatchingProgressBarState();
}

class _WatchingProgressBarState extends State<WatchingProgressBar> {
  
  SerieDetailsEntity serieDetailsEntity;
  AnimeDetailsEntity animeDetailsEntity;
  
  @override
  Widget build(BuildContext context) {

    if (widget.ouevreEntity.oeuvreType == "movie") return SizedBox.shrink();

    return _progressBarAndLabel();
  }

  
  Widget _progressBarAndLabel() {

    
     

    if (widget.ouevreEntity.seasonTotal != null && widget.ouevreEntity.episodeTotal != null){
      
      return Align(
        alignment: Alignment.bottomCenter,
        child: new BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: ProgressBarEpisode(ouevreEntity: widget.ouevreEntity, serieDetailsEntity: serieDetailsEntity, animeDetailsEntity: animeDetailsEntity)
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

        if(state is LoadingDetails){
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
        child: new BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: ProgressBarEpisode(ouevreEntity: widget.ouevreEntity, serieDetailsEntity: serieDetailsEntity, animeDetailsEntity: animeDetailsEntity)
        ),
       );
      }
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

    return Align(
      alignment: Alignment.bottomCenter,
      child: LinearPercentIndicator(
        lineHeight: 13.0,
        animation: true,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        linearStrokeCap: LinearStrokeCap.roundAll,       
        percent: percentOfWatch,
        backgroundColor: Colors.blueGrey.withOpacity(0.7),
        center: Text(
        '$watchEpisode / $totalEpisode',
          style: TextStyle(
          color: Colors.white,
          fontSize: 11.0, 
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