
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_details_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_details_entity.dart';
import 'package:dartz/dartz.dart';

class PeopleDetailsImpl implements PeopleDetailsContract{
  
  final PeopleDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PeopleDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failures, PeopleEntity>> getPeopleDetails(int id) async {

    if(await networkInfo.isConnected){
      try{

        final remotePeopleDetails = await remoteDataSource.getPeopleDetails(id);

        return Right(remotePeopleDetails);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());

    }    

  }

}