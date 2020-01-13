
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';

class EpisodeModel extends EpisodeEntity{


  EpisodeModel({

    @required final String airDate,
    @required final int episodeNumber,
    @required final int id,
    @required final String name,
    @required final String overview,
    @required final String productionCode,
    @required final int seasonNumber,
    @required final int showId,
    @required final String stillPath,
    @required final double voteAverage,
    @required final int voteCount,

  }): super(

   airDate        : airDate,
   episodeNumber  : episodeNumber,
   id             : id,
   name           : name,
   overview       : overview,
   productionCode : productionCode,
   seasonNumber   : seasonNumber,
   showId         : showId,
   stillPath      : stillPath,
   voteAverage    : voteAverage,
   voteCount      : voteCount,

  );

  factory EpisodeModel.fromJson(Map<String, dynamic> json){
    return EpisodeModel(
      airDate        : json['air_date'],
      episodeNumber  : json['episode_number'],
      id             : json['id'],
      name           : json['name'],
      overview       : json['overview'],
      productionCode : json['production_code'],
      seasonNumber   : json['season_number'],
      showId         : json['show_id'],
      stillPath      : json['still_path'],
      voteAverage    : json['vote_average'] / 1,
      voteCount      : json['vote_count'],
    );
  }

  Map<String, dynamic> toJson(){

    return {
      'airDate'       : airDate,
      'episodeNumber' : episodeNumber,
      'id'            : id,
      'name'          : name,
      'overview'      : overview,
      'productionCode': productionCode,
      'seasonNumber'  : seasonNumber,
      'showId'        : showId,
      'stillPath'     : stillPath,
      'voteAverage'   : voteAverage,
      'voteCount'     : voteCount,
    };
  }
}

class Episodes {

  List<EpisodeModel> items = new List();

  Episodes();

  Episodes.fromJsonList(List<dynamic> jsonList){

    if(jsonList ==  null) return;

    for(var item in jsonList){
      final episode = new EpisodeModel.fromJson(item);

      items.add(episode);
    }

  }

}