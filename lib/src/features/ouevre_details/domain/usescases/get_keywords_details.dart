import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/keywords_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/keywords_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class GetKeywordsDetails extends UseCase<Keywords, ParamsKeywords>{
  
  final KeywordsDetailsContract contract;

  GetKeywordsDetails(this.contract);


  @override
  Future<Either<Failures, Keywords>> call(paramsKeywords) async {
    return await contract.getKeywords(paramsKeywords.id, paramsKeywords.type);
  }

}

class ParamsKeywords extends Equatable{
  final int id;
  final String type;

  ParamsKeywords({@required this.id, @required this.type}) : super([id, type]);
}