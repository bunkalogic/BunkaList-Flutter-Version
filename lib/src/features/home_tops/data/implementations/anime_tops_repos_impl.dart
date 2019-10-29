

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_anime_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/anime_tops_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class AnimeTopRepositoryImpl implements AnimeTopsRepository {
  
  final TopsAnimeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimeTopRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });


   @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresActionAndAdventure() {
    // TODO: implement getAnimeGenresActionAndAdventure
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresBasedOnManga() {
    // TODO: implement getAnimeGenresBasedOnManga
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresComedy() {
    // TODO: implement getAnimeGenresComedy
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresCrimen() {
    // TODO: implement getAnimeGenresCrimen
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresDrama() {
    // TODO: implement getAnimeGenresDrama
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresFantasyAndSciFi() {
    // TODO: implement getAnimeGenresFantasyAndSciFi
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresMecha() {
    // TODO: implement getAnimeGenresMecha
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresMistery() {
    // TODO: implement getAnimeGenresMistery
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresRomance() {
    // TODO: implement getAnimeGenresRomance
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresShonen() {
    // TODO: implement getAnimeGenresShonen
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresSliceOfLife() {
    // TODO: implement getAnimeGenresSliceOfLife
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresSpokon() {
    // TODO: implement getAnimeGenresSpokon
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresSuperNatural() {
    // TODO: implement getAnimeGenresSuperNatural
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresWarAndPolitics() {
    // TODO: implement getAnimeGenresWarAndPolitics
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeSeason() {
    // TODO: implement getAnimeSeason
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeUpcomingNextSeason() {
    // TODO: implement getAnimeUpcomingNextSeason
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getTopAnimePopular() {
    // TODO: implement getTopAnimePopular
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getTopAnimeRated() {
    // TODO: implement getTopAnimeRated
    return null;
  }

  @override
  Future<Either<Failures, List<AnimeEntity>>> getTopsAnime(int typeTop) {
    // TODO: implement getTopsAnime
    return null;
  }




}