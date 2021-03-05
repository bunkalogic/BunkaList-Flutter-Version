import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/anime_personal_top_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetPersonalTopsAnime extends UseCase<List<AnimeEntity>, AnimeParams>{
  
  final AnimePersonalTopsContract contract;

  GetPersonalTopsAnime(this.contract);
  
  @override
  Future<Either<Failures, List<AnimeEntity>>> call(AnimeParams params) async {
   
   return await contract.getAnimePersonalTops(
     params.page,
     genre: params.genre,
     sortBy: params.sortBy,
     voteCountGte: params.voteCountGte,
     withKeywords: params.withKeywords,
     withNetwork: params.withNetwork,
     year: params.year
   );

  }

}

class AnimeParams extends Equatable{
  final int page;
  final String sortBy;
  final int year;
  final int voteCountGte;
  final String genre;
  final String withKeywords;
  final String withNetwork;

  AnimeParams({
    @required this.page,
    this.sortBy,
    this.year,
    this.voteCountGte,
    this.genre,
    this.withKeywords,
    this.withNetwork
  }) : super([
    page,
    sortBy,
    year,
    voteCountGte,
    genre,
    withKeywords,
    withNetwork,
  ]);

}