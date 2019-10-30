import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';



abstract class SeriesTopsRepository {


  Future<Either<Failures, List<SeriesEntity>>> getTopsSeries(int typeTop) async {
    switch (typeTop) {
      
      case 1: return await    _getTopSeriesPopular();  

      case 2: return await    _getTopSeriesRated();     

      case 3: return await    _getSeriesUpcoming();

      case 4: return await    _getSeriesGenresActionAndAdventure();

      case 5: return await    _getSeriesGenresComedy();

      case 6: return await    _getSeriesGenresCrimen();

      case 7: return await    _getSeriesGenresDocumental();

      case 8: return await    _getSeriesGenresDrama();

      case 9: return await    _getSeriesGenresFamily();

      case 10: return await   _getSeriesGenresDocumental();

      case 11: return await   _getSeriesGenresDrama();

      case 12: return await   _getSeriesGenresFamily();

      case 13: return await   _getSeriesGenresMistery();

      case 14: return await   _getSeriesGenresFantasyAndSciFi();

      case 15: return await   _getSeriesGenresMistery();

      case 16: return await   _getSeriesGenresSoap();

      case 17: return await   _getSeriesGenresWarAndPolitics(); 

      case 18: return await   _getSeriesGenresWestern();

      case 19: return await   _getSeriesCompanyNetflix(); 

      case 20: return await   _getSeriesCompanyHBO();

      case 21: return await   _getSeriesCompanyAmazonPrime();

      case 22: return await   _getSeriesCompanyBBCOne();

      case 23: return await   _getSeriesCompanyAMC();

      default: return await   _getTopSeriesPopular();
    }
  }

  //? Series Tops

  Future<Either<Failures, List<SeriesEntity>>> _getTopSeriesPopular();

  Future<Either<Failures, List<SeriesEntity>>> _getTopSeriesRated();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesUpcoming();

  //? Series Popular Genres

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresActionAndAdventure();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresComedy();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresCrimen();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresDocumental();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresDrama();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresFamily();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresMistery();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresFantasyAndSciFi();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresSoap();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresWarAndPolitics();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesGenresWestern();

  //? Series Popular Company

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesCompanyNetflix();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesCompanyHBO();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesCompanyAmazonPrime();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesCompanyBBCOne();

  Future<Either<Failures, List<SeriesEntity>>> _getSeriesCompanyAMC();

  


  


  

}