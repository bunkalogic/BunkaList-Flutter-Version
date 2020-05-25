import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/get_total_by_status_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTotalByStatus extends UseCase< List<int>, ParamsTotal>{
  
  final  GetTotalByStatusContract contract;

  GetTotalByStatus(this.contract);

  @override
  Future<Either<Failures, List<int>>> call(ParamsTotal params) async {
   return contract.getTotalByStatusFirebase(params.type);
  }

  

}

class ParamsTotal extends Equatable{

  final String type; 

  ParamsTotal({@required this.type}) : super([type]);

}