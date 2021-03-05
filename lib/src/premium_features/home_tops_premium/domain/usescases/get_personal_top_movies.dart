import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/movie_personal_top_contract.dart';
import 'package:meta/meta.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetPersonalTopsMovies extends UseCase<List<MovieEntity>, MovieParams>{
  
  final MoviePersonalTopsContract contract;

  GetPersonalTopsMovies(this.contract);
  
  @override
  Future<Either<Failures, List<MovieEntity>>> call(MovieParams params) async {
   
   return await contract.getMoviesPersonalTops(
     params.page,
     genre: params.genre,
     sortBy: params.sortBy,
     voteCountGte: params.voteCountGte,
     withKeywords: params.withKeywords,
     withOriginalLanguage: params.withOriginalLanguage,
     year: params.year
   );

  }

}

class MovieParams extends Equatable{
  final int page;
  final String sortBy;
  final int year;
  final int voteCountGte;
  final String genre;
  final String withKeywords;
  final String withOriginalLanguage;

  MovieParams({
    @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withOriginalLanguage
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withOriginalLanguage,
  ]);

}