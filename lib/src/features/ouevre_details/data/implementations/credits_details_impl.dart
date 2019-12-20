import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/credits_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/credits_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class CreditsDetailsImpl extends CreditsDetailsContract {

    final CreditsDetailsRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

    CreditsDetailsImpl({
      @required this.remoteDataSource,
      @required this.networkInfo
    });



  @override
  Future<Either<Failures, CreditsEntity>> getCredits(int id, String type) async {
    networkInfo.isConnected;
    try{

      final remoteCreditsDetails = await remoteDataSource.getCredits(id, type);
      return Right(remoteCreditsDetails);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

}