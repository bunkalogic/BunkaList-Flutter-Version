import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/video_youtube_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/video_youtube_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class VideoYoutubeDetailsImpl implements VideoYoutubeDetailsContract{
  
  final VideoYoutubeDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VideoYoutubeDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failures, List<VideoYoutubeEntity>>> getListVideosYoutube(String query) async {
    if(await networkInfo.isConnected){
      try{

        final remoteVideoYoutube = await remoteDataSource.getListVideoYoutube(query);

        return Right(remoteVideoYoutube);

      }on ServerException{

        return Left(ServerFailure());

      }
    }else{

      return Left(ServerFailure());

    }
  }

}