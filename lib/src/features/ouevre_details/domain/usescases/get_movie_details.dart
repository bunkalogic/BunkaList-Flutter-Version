
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetMovieDetails extends UseCase<MovieDetailsEntity, Params>{
  
  final MovieDetailsContract contract;

  GetMovieDetails(this.contract);
  
  @override
  Future<Either<Failures, MovieDetailsEntity>> call(Params params) async {
    return await contract.getDetailsMovie(params.movieId);
  }

}

class Params extends Equatable {

final int movieId;

 Params ({ @required this.movieId }) : super([movieId]);

}