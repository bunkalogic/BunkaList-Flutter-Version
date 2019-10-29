
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';

abstract class TopsAnimeRemoteDataSource{

  /// Calls the http://themoviedb.org/3/discover/tv endpoint.
  ///
  /// Throws a [ServerException] for all error codes.

  Future<List<AnimeModel>> getTopAnimePopular();
  Future<List<AnimeModel>> getTopAnimeRated();
  Future<List<AnimeModel>> getAnimeSeason();
  Future<List<AnimeModel>> getAnimeUpcomingNextSeason();
  Future<List<AnimeModel>> getAnimeGenresActionAndAdventure();
  Future<List<AnimeModel>> getAnimeGenresComedy();
  Future<List<AnimeModel>> getAnimeGenresCrimen();
  Future<List<AnimeModel>> getAnimeGenresDrama();
  Future<List<AnimeModel>> getAnimeGenresMistery();
  Future<List<AnimeModel>> getAnimeGenresFantasyAndSciFi();
  Future<List<AnimeModel>> getAnimeGenresWarAndPolitics();
  Future<List<AnimeModel>> getAnimeGenresShonen();
  Future<List<AnimeModel>> getAnimeGenresSpokon();
  Future<List<AnimeModel>> getAnimeGenresMecha();
  Future<List<AnimeModel>> getAnimeGenresSliceOfLife();
  Future<List<AnimeModel>> getAnimeGenresBasedOnManga();
  Future<List<AnimeModel>> getAnimeGenresRomance();
  Future<List<AnimeModel>> getAnimeGenresSuperNatural();



}