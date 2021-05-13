
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/serie_explorer_contract.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetExplorerSeries extends UseCase<List<SeriesEntity>, Params>{
  
  final SerieExplorerContract contract;

  GetExplorerSeries(this.contract);
  
  @override
  Future<Either<Failures, List<SeriesEntity>>> call(Params params) async {
   
   return await contract.getSeriesExplorer(
     params.page,
     genre: params.genre,
     sortBy: params.sortBy,
     voteCountGte: params.voteCountGte,
     withKeywords: params.withKeywords,
     withNetwork: params.withNetwork,
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
  final String withNetwork;
  final String withCompanies;
  final String withWatchProvider;

  Params({
    @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withNetwork,
    this.withCompanies,
    this.withWatchProvider
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withNetwork,
    withCompanies,
    withWatchProvider
  ]);

}