
import 'package:bunkalist/src/features/profile/domain/contracts/delete_ouevre_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetDeleteOuevre extends UseCase<void, Params>{
  
  final DeleteOuevreContract contract;

  GetDeleteOuevre(this.contract);

  @override
  Future<Either<Failures, void>> call(Params params) async {

    return await contract.deleteOuevreInFirebase(params.ouevreEntity ,params.type);
    
  }

}

class Params extends Equatable{

  final OuevreEntity ouevreEntity;
  final String type; 

  Params({@required this.ouevreEntity, @required this.type}) : super([ouevreEntity ,type]);

}