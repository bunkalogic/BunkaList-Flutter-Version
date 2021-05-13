import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/watch_provider_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/watch_provider_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class WatchProviderDetailsImpl extends WatchProviderDetailsContract {

    final WatchProviderRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

    WatchProviderDetailsImpl({
      @required this.remoteDataSource,
      @required this.networkInfo
    });



  @override
  Future<Either<Failures, WatchProvider>> getWatchProvider(int id, String type) async {
    networkInfo.isConnected;
    try{

      final remoteWatchProviderDetails = await remoteDataSource.getWatchProvider(id, type);
      return Right(remoteWatchProviderDetails);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

}