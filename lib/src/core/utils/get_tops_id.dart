
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetTopId{
  Either<Failures, int> getValidateTopId(int id){
    try {
      if(id < 0) throw FormatException();
      return Right(id);
      
    } on FormatException {

      return Left(InvalidInputFailure());
    } 
  }
}

class InvalidInputFailure extends Failures {}