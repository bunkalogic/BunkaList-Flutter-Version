import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class AnimeDetailsImpl implements AnimeDetailsContract{
  final AnimeDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimeDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  @override
  Future<Either<Failures, AnimeDetailsEntity>> getDetailsAnime(int id) async {
    networkInfo.isConnected;
    try {
      
      final remoteAnimeDetails = await remoteDataSource.getAnimeDetails(id);
      return Right(remoteAnimeDetails);

    } on ServerException {
      
      return Left(ServerFailure());

    }
  }

}