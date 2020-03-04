
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/profile/data/datasources/crud_ouevre_remote_data_source.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/update_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';

class UpdateOuevreImpl implements UpdateOuevreContract{
  
  final CrudOuevreRemoteDataSource remoteDataSource;

  UpdateOuevreImpl({@required this.remoteDataSource});
  
  
  @override
  Future<Either<Failures, void>> updateOuevreInFirebase(OuevreEntity ouevre, String type) async {
    try{

      final remote = await remoteDataSource.updateInFirebase(ouevre, type);

      return Right(remote); 

    }on ServerException{

      return Left(ServerFailure());
    } 
  }

}