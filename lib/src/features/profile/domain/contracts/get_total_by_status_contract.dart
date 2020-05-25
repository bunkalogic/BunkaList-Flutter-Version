

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GetTotalByStatusContract{

  Future<Either<Failures, List<int>>> getTotalByStatusFirebase(String type);


}