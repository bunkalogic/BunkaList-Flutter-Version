
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_cinema_repository.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCinemaMovies extends UseCase<List<MovieEntity>, Params>{
  

  final MoviesCinemaRepository contract;

  GetCinemaMovies(this.contract);
  
  @override
  Future<Either<Failures, List<MovieEntity>>> call(params) async {
    
    return await contract.getCinemaMovies(params.page);

  }

}

 class Params extends Equatable {
  
  final int page;

  Params({@required this.page}) :super([page]);
}