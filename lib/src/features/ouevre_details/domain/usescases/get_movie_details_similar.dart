

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_rec_sim_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetMoviesSimilar extends UseCase<List<MovieEntityRS>, Params>{

  final MoviesDetailsRecommendationAndSimilarContracts contracts;

  GetMoviesSimilar(this.contracts);



  @override
  Future<Either<Failures, List<MovieEntityRS>>> call(params) async{
    return await contracts.getSimilarMovie(params.id);
  }

}

class Params extends Equatable {

final int id;

 Params ({ @required this.id }) : super([id]);

}