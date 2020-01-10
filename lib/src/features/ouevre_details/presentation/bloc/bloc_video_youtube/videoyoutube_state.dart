import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';
import 'package:equatable/equatable.dart';

abstract class VideoYoutubeState extends Equatable {
  const VideoYoutubeState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends VideoYoutubeState{}

class Loading extends VideoYoutubeState{}

class Loaded extends VideoYoutubeState{
  final List<VideoYoutubeEntity> videos;
  Loaded({ @required this.videos }) : super([videos]);
}

class Error extends VideoYoutubeState{
  final String message;
  Error({@required this.message}) : super ([message]);
}
