
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetValidateQuery{
  Either<Failures, String> getValidateQuery(String query){
    try {
      String _query;
      if(query != null || query.isNotEmpty) _query = query;
      return Right(_query);
      
    } on FormatException {

      return Left(InvalidInputFailure());
    } 
  }
}

class InvalidInputFailure extends Failures {}