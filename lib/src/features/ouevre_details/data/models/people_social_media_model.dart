
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_social_media_entity.dart';

class PeopleSocialMediaModel extends PeopleSocialMediaEntity{

  PeopleSocialMediaModel({
    @required String imdbId,
    @required dynamic facebookId,
    @required String freebaseMid,
    @required dynamic freebaseId,
    @required int tvrageId,
    @required dynamic twitterId,
    @required int id,
    @required dynamic instagramId
  }) : super(
      imdbId       : imdbId,
      facebookId   : facebookId,
      freebaseMid  : freebaseMid,
      freebaseId   : freebaseId,
      tvrageId     : tvrageId,
      twitterId    : twitterId,
      id           : id,
      instagramId  : instagramId,
  );

  factory PeopleSocialMediaModel.fromJson(Map<String, dynamic> json){
    return PeopleSocialMediaModel(
      imdbId       : json['imdb_id'],
      facebookId   : json['facebook_id'],
      freebaseMid  : json['freebase_mid'],
      freebaseId   : json['freebase_id'],
      tvrageId     : json['tvrage_id'],
      twitterId    : json['twitter_id'],
      id           : json['id'],
      instagramId  : json['instagram_id'], 
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'imdbId     '  : imdbId,
      'facebookId '  : facebookId,
      'freebaseMid'  : freebaseMid,
      'freebaseId '  : freebaseId,
      'tvrageId   '  : tvrageId,
      'twitterId  '  : twitterId,
      'id         '  : id,
      'instagramId'  : instagramId,
    };
  }

}