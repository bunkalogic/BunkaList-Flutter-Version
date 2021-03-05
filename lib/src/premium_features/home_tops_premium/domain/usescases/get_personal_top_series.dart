
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/serie_personal_top_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetPersonalTopsSeries extends UseCase<List<SeriesEntity>, SerieParams>{
  
  final SeriePersonalTopsContract contract;

  GetPersonalTopsSeries(this.contract);
  
  @override
  Future<Either<Failures, List<SeriesEntity>>> call(SerieParams params) async {
   
   return await contract.getSeriesPersonalTops(
     params.page,
     genre: params.genre,
     sortBy: params.sortBy,
     withOriginalLanguage: params.withOriginalLanguage,
     voteCountGte: params.voteCountGte,
     withKeywords: params.withKeywords,
     withNetwork: params.withNetwork,
     year: params.year
   );

  }

}

class SerieParams extends Equatable{
  final int page;
  final String sortBy;
  final int year;
  final int voteCountGte;
  final String genre;
  final String withKeywords;
  final String withNetwork;
  final String withOriginalLanguage;

  SerieParams({
    @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withNetwork,
    this.withOriginalLanguage
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withNetwork,
    withOriginalLanguage
  ]);

}