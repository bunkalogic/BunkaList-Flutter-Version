import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';



abstract class AnimeTopsRepository {


  Future<Either<Failures, List<AnimeEntity>>> getTopsAnime(int typeTop) async {
    switch (typeTop) {
      
      case 1: return await getTopAnimePopular();  

      case 2: return await getTopAnimeRated();     

      case 3: return await getAnimeSeason();

      case 4: return await  getAnimeUpcomingNextSeason();

      case 5: return await  getAnimeGenresActionAndAdventure(); 

      case 6: return await getAnimeGenresComedy();

      case 7: return await  getAnimeGenresCrimen();

      case 8: return await  getAnimeGenresDrama();

      case 9: return await getAnimeGenresMistery();

      case 10: return await getAnimeGenresFantasyAndSciFi();

      case 11: return await getAnimeGenresWarAndPolitics();

      case 12: return await getAnimeGenresShonen();

      case 13: return await  getAnimeGenresSpokon();

      case 14: return await  getAnimeGenresMecha();

      case 15: return await getAnimeGenresSliceOfLife();

      case 16: return await getAnimeGenresBasedOnManga();

      case 17: return await  getAnimeGenresRomance(); 

      case 18: return await  getAnimeGenresSuperNatural();

      default: return await getTopAnimePopular();
    }
  }

  //? Anime Tops

  Future<Either<Failures, List<AnimeEntity>>> getTopAnimePopular();

  Future<Either<Failures, List<AnimeEntity>>> getTopAnimeRated();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeSeason();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeUpcomingNextSeason();

  //? Anime Popular Genres

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresActionAndAdventure();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresComedy();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresCrimen();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresDrama();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresMistery();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresFantasyAndSciFi();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresWarAndPolitics();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresShonen();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresSpokon();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresMecha();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresSliceOfLife();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresBasedOnManga();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresRomance();

  Future<Either<Failures, List<AnimeEntity>>> getAnimeGenresSuperNatural();

  

  

  



  


  


  

}