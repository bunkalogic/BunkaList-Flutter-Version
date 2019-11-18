import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieDetailsContract {

  Future<Either<Failures, MovieDetailsEntity>> getDetailsMovie(int id);

}