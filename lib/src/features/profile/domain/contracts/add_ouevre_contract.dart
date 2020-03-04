

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AddOuevreContract{

  Future<Either<Failures, void>> addOuevreInFirebase(OuevreEntity ouevre, String type);

}