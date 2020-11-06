
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/profile/data/datasources/crud_ouevre_remote_data_source.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/get_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';

class GetOuevreImpl implements GetOuevreContract{
  
  final CrudOuevreRemoteDataSource remoteDataSource;

  GetOuevreImpl({@required this.remoteDataSource});

  @override
  Either<Failures, Stream<List<OuevreEntity>>> getOuevreInFirebase(String type, ListProfileQuery status) {
    try{

      final remote = remoteDataSource.getOfFirebase(type, status);

      return Right(remote);

    }on ServerException{

      return Left(ServerFailure());

    }
  }
  
  
  
}