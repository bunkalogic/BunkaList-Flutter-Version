import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_credits_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_credits_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class PeopleCreditsImpl implements PeopleCreditsContract{
  
  final PeopleCreditsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PeopleCreditsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failures, PeopleCreditsEntity>> getPeopleCredits(int id) async {
    if(await networkInfo.isConnected){
      try{

        final remotePeopleDetails = await remoteDataSource.getPeopleCredits(id);

        return Right(remotePeopleDetails);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());

    }
  }
  
  

}