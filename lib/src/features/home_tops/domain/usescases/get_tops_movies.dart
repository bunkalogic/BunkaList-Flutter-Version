import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_tops_repository.dart';
import 'package:equatable/equatable.dart';


class GetTopsMovies extends UseCase<List<MovieEntity>, Params> {

  final MovieTopsRepository repository; 
  
  GetTopsMovies(this.repository);


  @override
  Future<Either<Failures, List<MovieEntity>>> call(Params params) async {
    return await repository.getTopsMovies( params.topTypeId, params.page );
  }
}

class Params extends Equatable {
  final int topTypeId;
  final int page;

  Params({@required this.topTypeId, @required this.page}) :super([topTypeId, page]);
}