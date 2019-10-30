import 'package:bunkalist/src/core/constans/constants.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';



abstract class SeriesTopsRepository {


  Future<Either<Failures, List<SeriesEntity>>> getTopsSeries(int typeTop) async {
    switch (typeTop) {
      
      case Constants.topsSeriesPopularId        : return await    _getTopSeriesPopular();  

      case Constants.topsSeriesRatedId          : return await    _getTopSeriesRated();     

      case Constants.topsSeriesUpcommingId      : return await    _getSeriesUpcoming();

      case Constants.topsSeriesActAndAdvId      : return await    _getSeriesGenresActionAndAdventure();

      case Constants.topsSeriesComedyId         : return await    _getSeriesGenresComedy();

      case Constants.topsSeriesCrimenId         : return await    _getSeriesGenresCrimen();

      case Constants.topsSeriesDocumentalId     : return await    _getSeriesGenresDocumental();

      case Constants.topsSeriesFamilyId         : return await    _getSeriesGenresFamily();

      case Constants.topsSeriesDramaId          : return await   _getSeriesGenresDrama();

      case Constants.topsSeriesMisteryId        : return await   _getSeriesGenresMistery();

      case Constants.topsSeriesFantasyAndSciFiId: return await   _getSeriesGenresFantasyAndSciFi();

      case Constants.topsSeriesSoapId           : return await   _getSeriesGenresSoap();

      case Constants.topsSeriesWarAndPoliticsId : return await   _getSeriesGenresWarAndPolitics(); 

      case Constants.topsSeriesWesternId        : return await   _getSeriesGenresWestern();

      case Constants.topsSeriesNetflixId        : return await   _getSeriesCompanyNetflix(); 

      case Constants.topsSeriesHBOId            : return await   _getSeriesCompanyHBO();

      case Constants.topsSeriesAmazonPrimeId    : return await   _getSeriesCompanyAmazonPrime();

      case Constants.topsSeriesBBCOneId         : return await   _getSeriesCompanyBBCOne();

      case Constants.topsSeriesAMCId            : return await   _getSeriesCompanyAMC();

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