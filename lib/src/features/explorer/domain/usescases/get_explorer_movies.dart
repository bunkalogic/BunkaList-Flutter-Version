import 'package:bunkalist/src/features/explorer/domain/contracts/movie_explorer_contract.dart';
import 'package:meta/meta.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetExplorerMovies extends UseCase<List<MovieEntity>, Params>{
  
  final MovieExplorerContract contract;

  GetExplorerMovies(this.contract);
  
  @override
  Future<Either<Failures, List<MovieEntity>>> call(Params params) async {
   
   return await contract.getMoviesExplorer(
     params.page,
     genre: params.genre,
     sortBy: params.sortBy,
     voteCountGte: params.voteCountGte,
     withKeywords: params.withKeywords,
     withOriginalLanguage: params.withOriginalLanguage,
     year: params.year,
     withCompanies: params.withCompanies,
     withWatchProvider: params.withWatchProvider
   );

  }

}

class Params extends Equatable{
  final int page;
  final String sortBy;
  final int year;
  final int voteCountGte;
  final String genre;
  final String withKeywords;
  final String withOriginalLanguage;
  final String withCompanies;
  final String withWatchProvider;

  Params({
    @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withOriginalLanguage,
    this.withCompanies,
    this.withWatchProvider
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withOriginalLanguage,
    withCompanies,
    withWatchProvider
  ]);

}