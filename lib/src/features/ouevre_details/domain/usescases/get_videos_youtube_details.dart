


import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/video_youtube_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetListVideosYoutube extends UseCase<List<VideoYoutubeEntity>, Params>{
  
  final VideoYoutubeDetailsContract contract;

  GetListVideosYoutube(this.contract);
  
  @override
  Future<Either<Failures, List<VideoYoutubeEntity>>> call(Params params) async {
    
    return await contract.getListVideosYoutube(params.query);
    
  }

}


class Params extends Equatable{
  
  final String query;

  Params({ @required this.query }) : super([query]);
}