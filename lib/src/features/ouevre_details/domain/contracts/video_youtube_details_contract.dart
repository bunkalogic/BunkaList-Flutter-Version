import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class VideoYoutubeDetailsContract{

  Future<Either<Failures, List<VideoYoutubeEntity>>> getListVideosYoutube(String query);
  
}