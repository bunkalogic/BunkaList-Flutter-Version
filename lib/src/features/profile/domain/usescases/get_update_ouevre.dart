
import 'package:bunkalist/src/features/profile/domain/contracts/Update_ouevre_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUpdateOuevre extends UseCase<void, Params>{
  
  final UpdateOuevreContract contract;

  GetUpdateOuevre(this.contract);

  @override
  Future<Either<Failures, List<OuevreEntity>>> call(Params params) async {

    return await contract.updateOuevreInFirebase(params.ouevreEntity ,params.type);
    
  }

}

class Params extends Equatable{

  final OuevreEntity ouevreEntity;
  final String type; 

  Params({@required this.ouevreEntity, @required this.type}) : super([ouevreEntity ,type]);

}