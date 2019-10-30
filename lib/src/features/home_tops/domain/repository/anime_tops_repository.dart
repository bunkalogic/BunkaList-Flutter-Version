import 'package:bunkalist/src/core/constans/constants.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';



abstract class AnimeTopsRepository {


  Future<Either<Failures, List<AnimeEntity>>> getTopsAnime(int typeTop) async {
    
    switch (typeTop) {
      
      case Constants.topsAnimePopularId           : return await    _getTopAnimePopular();  

      case Constants.topsAnimeRatedId             : return await    _getTopAnimeRated();     

      case Constants.topsAnimeSeasonId            : return await    _getAnimeSeason();

      case Constants.topsAnimeUpcomingNextSeasonId: return await    _getAnimeUpcomingNextSeason();

      case Constants.topsAnimeActionAndAdventureId: return await    _getAnimeGenresActionAndAdventure(); 

      case Constants.topsAnimeComedyId            : return await    _getAnimeGenresComedy();

      case Constants.topsAnimeCrimenId            : return await    _getAnimeGenresCrimen();

      case Constants.topsAnimeDramaId             : return await    _getAnimeGenresDrama();

      case Constants.topsAnimeMisteryId           : return await    _getAnimeGenresMistery();

      case Constants.topsAnimeFantasyAndSciFiId   : return await   _getAnimeGenresFantasyAndSciFi();

      case Constants.topsAnimeWarAndPoliticsId    : return await   _getAnimeGenresWarAndPolitics();

      case Constants.topsAnimeShonenId            : return await   _getAnimeGenresShonen();

      case Constants.topsAnimeSpokonId            : return await   _getAnimeGenresSpokon();

      case Constants.topsAnimeMechaId             : return await   _getAnimeGenresMecha();

      case Constants.topsAnimeSliceOfLifeId       : return await   _getAnimeGenresSliceOfLife();

      case Constants.topsAnimeBasedOnMangaId      : return await   _getAnimeGenresBasedOnManga();

      case Constants.topsAnimeRomanceId           : return await   _getAnimeGenresRomance(); 

      case Constants.topsAnimeSuperNaturalId      : return await   _getAnimeGenresSuperNatural();

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