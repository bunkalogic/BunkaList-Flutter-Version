import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';



abstract class SeriesTopsRepository {


  Future<Either<Failures, List<SeriesEntity>>> getTopsSeries(int typeTop) async {
    switch (typeTop) {
      
      case 1: return await getTopSeriesPopular();  

      case 2: return await getTopSeriesRated();     

      case 3: return await getSeriesUpcoming();

      case 4: return await  getSeriesGenresActionAndAdventure();

      case 5: return await  getSeriesGenresComedy();

      case 6: return await getSeriesGenresCrimen();

      case 7: return await  getSeriesGenresDocumental();

      case 8: return await  getSeriesGenresDrama();

      case 9: return await getSeriesGenresFamily();

      case 10: return await  getSeriesGenresDocumental();

      case 11: return await   getSeriesGenresDrama();

      case 12: return await getSeriesGenresFamily();

      case 13: return await  getSeriesGenresMistery();

      case 14: return await  getSeriesGenresFantasyAndSciFi();

      case 15: return await getSeriesGenresMistery();

      case 16: return await getSeriesGenresSoap();

      case 17: return await  getSeriesGenresWarAndPolitics(); 

      case 18: return await getSeriesGenresWestern();

      case 19: return await  getSeriesCompanyNetflix(); 

      case 20: return await getSeriesCompanyHBO();

      case 21: return await  getSeriesCompanyAmazonPrime();

      case 22: return await getSeriesCompanyBBCOne();

      case 23: return await getSeriesCompanyAMC();

      default: return await getTopSeriesPopular();
    }
  }

  //? Series Tops

  Future<Either<Failures, List<SeriesEntity>>> getTopSeriesPopular();

  Future<Either<Failures, List<SeriesEntity>>> getTopSeriesRated();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesUpcoming();

  //? Series Popular Genres

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresActionAndAdventure();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresComedy();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresCrimen();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresDocumental();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresDrama();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresFamily();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresMistery();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresFantasyAndSciFi();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresSoap();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresWarAndPolitics();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresWestern();

  //? Series Popular Company

  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyNetflix();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyHBO();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyAmazonPrime();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyBBCOne();

  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyAMC();

  


  


  

}