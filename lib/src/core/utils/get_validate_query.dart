
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetValidateQuery{
  Either<Failures, String> getValidateQuery(String query){
    try {

      return Right(query);

    } on FormatException {

      return Left(InvalidInputFailure());
    } 
  }
}

class InvalidInputFailure extends Failures {}