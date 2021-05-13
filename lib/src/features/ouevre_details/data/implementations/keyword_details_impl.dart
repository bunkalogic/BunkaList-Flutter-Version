import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/keywords_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/keywords_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/keywords_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class KeywordsDetailsImpl extends KeywordsDetailsContract {

    final KeywordsRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

    KeywordsDetailsImpl({
      @required this.remoteDataSource,
      @required this.networkInfo
    });



  @override
  Future<Either<Failures, Keywords>> getKeywords(int id, String type) async {
    networkInfo.isConnected;
    try{

      final remoteKeywordsDetails = await remoteDataSource.getKeywords(id, type);
      return Right(remoteKeywordsDetails);

    }on ServerException{

      return Left(ServerFailure());

    }
  }

}