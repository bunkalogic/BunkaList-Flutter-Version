import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/search/domain/contracts/search_result_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:equatable/equatable.dart';

class GetSearch extends UseCase<ResultsEntity, Params>{

  final SearchResultContract contract;

  GetSearch(this.contract);
  
  @override
  Future<Either<Failures, ResultsEntity>> call(Params params) async {
    
    return await contract.getSearch(params.query);

  }

}


class Params extends Equatable{

  final String query;

  Params({ @required this.query}) : super([query]);
}