import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';



abstract class AnimeTopsRepository {


  Future<Either<Failures, List<AnimeEntity>>> getTopsAnime(int typeTop) async {
    
    switch (typeTop) {
      
      case 1: return await    _getTopAnimePopular();  

      case 2: return await    _getTopAnimeRated();     

      case 3: return await    _getAnimeSeason();

      case 4: return await    _getAnimeUpcomingNextSeason();

      case 5: return await    _getAnimeGenresActionAndAdventure(); 

      case 6: return await    _getAnimeGenresComedy();

      case 7: return await    _getAnimeGenresCrimen();

      case 8: return await    _getAnimeGenresDrama();

      case 9: return await    _getAnimeGenresMistery();

      case 10: return await   _getAnimeGenresFantasyAndSciFi();

      case 11: return await   _getAnimeGenresWarAndPolitics();

      case 12: return await   _getAnimeGenresShonen();

      case 13: return await   _getAnimeGenresSpokon();

      case 14: return await   _getAnimeGenresMecha();

      case 15: return await   _getAnimeGenresSliceOfLife();

      case 16: return await   _getAnimeGenresBasedOnManga();

      case 17: return await   _getAnimeGenresRomance(); 

      case 18: return await   _getAnimeGenresSuperNatural();

      default: return await   _getTopAnimePopular();
    }
    
  }

  //? Anime Tops

  Future<Either<Failures, List<AnimeEntity>>> _getTopAnimePopular();

  Future<Either<Failures, List<AnimeEntity>>> _getTopAnimeRated();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeSeason();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeUpcomingNextSeason();

  //? Anime Popular Genres

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresActionAndAdventure();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresComedy();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresCrimen();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresDrama();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresMistery();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresFantasyAndSciFi();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresWarAndPolitics();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresShonen();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresSpokon();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresMecha();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresSliceOfLife();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresBasedOnManga();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresRomance();

  Future<Either<Failures, List<AnimeEntity>>> _getAnimeGenresSuperNatural();

  

  

  



  


  


  

}