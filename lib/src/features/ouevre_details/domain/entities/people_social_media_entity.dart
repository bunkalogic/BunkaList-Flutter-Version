import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PeopleSocialMediaEntity extends Equatable{
    final String imdbId;
    final dynamic facebookId;
    final String freebaseMid;
    final dynamic freebaseId;
    final int tvrageId;
    final dynamic twitterId;
    final int id;
     final dynamic instagramId;
   

    PeopleSocialMediaEntity({
        @required this.imdbId,
        @required this.facebookId,
        @required this.freebaseMid,
        @required this.freebaseId,
        @required this.tvrageId,
        @required this.twitterId,
        @required this.id,
        @required this.instagramId
    }) : super ([
      imdbId,
      facebookId,
      freebaseMid,
      freebaseId,
      tvrageId,
      twitterId,
      id,
      instagramId
    ]);
}