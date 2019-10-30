
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_anime_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/anime_tops_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class AnimeTopRepositoryImpl implements AnimeTopsRepository {
  
  final TopsAnimeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimeTopRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failures, List<AnimeEntity>>> getTopsAnime(int typeTop) async {
    networkInfo.isConnected;
    try {

      final remoteAnime = await remoteDataSource.getTopsAnimes(typeTop);
      return Right(remoteAnime);

    } on ServerException {

      return Left(ServerFailure());

    }
  }




}