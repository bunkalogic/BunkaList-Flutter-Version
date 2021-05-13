import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/images_poster_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/images_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ImagesPosterDetailsImpl extends ImagesPosterDetailsContract {

    final ImagesDetailsRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

    ImagesPosterDetailsImpl({
      @required this.remoteDataSource,
      @required this.networkInfo
    });



  @override
  Future<Either<Failures, PosterImages>> getImagesPoster(int id, String type) async {
    networkInfo.isConnected;
    try{

      final remoteImagesPosterDetails = await remoteDataSource.getPosterImages(id, type);
      return Right(remoteImagesPosterDetails);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

}