

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MoviesCinemaRepository {


  Future<Either<Failures, List<MovieEntity>>> getCinemaMovies(int page);

} 