
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/profile/data/datasources/crud_ouevre_remote_data_source.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/get_total_by_status_contract.dart';

class GetTotalByStatusImpl implements GetTotalByStatusContract{
  
  final CrudOuevreRemoteDataSource remoteDataSource;

 GetTotalByStatusImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failures, List<int>>>  getTotalByStatusFirebase(String type) async {
    try{

      final remote = await remoteDataSource.getTotalByStatus(type);

      return Right(remote);

    }on ServerException{

      return Left(ServerFailure());

    }
  }
  
  
  
}