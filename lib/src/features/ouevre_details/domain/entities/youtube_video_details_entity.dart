

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VideoYoutubeEntity extends Equatable {

  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String publishedAt;

  VideoYoutubeEntity({
    @required this.id,
    @required this.title,
    @required this.thumbnailUrl,
    @required this.channelTitle,
    @required this.publishedAt,
  }) : super ([
    id,
    title,
    thumbnailUrl,
    channelTitle,
    publishedAt
  ]);

}