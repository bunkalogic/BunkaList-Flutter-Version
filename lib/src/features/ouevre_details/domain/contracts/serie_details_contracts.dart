import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SerieDetailsContract {

  Future<Either<Failures, SerieDetailsEntity>> getDetailsSerie(int id);

}