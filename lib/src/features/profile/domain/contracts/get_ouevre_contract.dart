
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetOuevreContract{

  Either<Failures, Stream<List<OuevreEntity>>> getOuevreInFirebase( String type, ListProfileQuery status);


}