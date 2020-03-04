
import 'package:bunkalist/src/features/profile/domain/contracts/get_ouevre_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllOuevre extends UseCase<Stream<List<OuevreEntity>>, Params>{
  
  final GetOuevreContract contract;

  GetAllOuevre(this.contract);

  @override
  Future<Either<Failures, Stream<List<OuevreEntity>>>> call(Params params) async {

    return await contract.getOuevreInFirebase(params.type, params.status);
    
  }

}

class Params extends Equatable{

  final String type; 
  final String status;

  Params({@required this.type, @required this.status}) : super([type, status]);

}