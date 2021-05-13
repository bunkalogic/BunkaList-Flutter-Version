import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/keywords_entity.dart';
import 'package:dartz/dartz.dart';



abstract class KeywordsDetailsContract {


  Future<Either<Failures, Keywords>> getKeywords(int id, String type);


}