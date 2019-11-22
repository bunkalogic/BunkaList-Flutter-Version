import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/serie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SerieDetailsImpl implements SerieDetailsContract{
  final SerieDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SerieDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });


  @override
  Future<Either<Failures, SerieDetailsEntity>> getDetailsSerie(int id) async {
    networkInfo.isConnected;
    try {
      
      final remoteSerieDetails = await remoteDataSource.getSerieDetails(id);
      return Right(remoteSerieDetails);

    } on ServerException {
      
      return Left(ServerFailure());

    }
  }

}