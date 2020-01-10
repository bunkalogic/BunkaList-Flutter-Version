import 'package:equatable/equatable.dart';

abstract class VideoYoutubeEvent extends Equatable {
  const VideoYoutubeEvent([List props = const <dynamic>[]]) : super (props);
}

class GetTrailersVideos extends VideoYoutubeEvent{
  final String query;
  GetTrailersVideos(this.query) : super([query]);
}


class GetReviewsVideos extends VideoYoutubeEvent{
  final String query;
  GetReviewsVideos(this.query) : super([query]);
}


class GetOpenningVideos extends VideoYoutubeEvent{
  final String query;
  GetOpenningVideos(this.query) : super([query]);
}
