import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';

import 'package:bunkalist/src/features/home_tops/data/datasources/tops_series_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/serie_tops_repository.dart';


class SeriesTopRepositoryImpl implements SeriesTopsRepository{
  
  final TopsSeriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SeriesTopRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });


  @override
  Future<Either<Failures, List<SeriesEntity>>> getTopsSeries(int typeTop) async {
    networkInfo.isConnected;
    try {

      final remoteSeries = await remoteDataSource.getTopsSeries(typeTop);
      return Right(remoteSeries);

    } on ServerException {

      return Left(ServerFailure());

    }
  }


}