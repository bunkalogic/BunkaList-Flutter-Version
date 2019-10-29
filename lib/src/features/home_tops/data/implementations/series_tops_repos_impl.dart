

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_series_remote_source.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/serie_tops_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SeriesTopRepositoryImpl implements SeriesTopsRepository{
  
  final TopsSeriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SeriesTopRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });


  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyAMC() {
    // TODO: implement getSeriesCompanyAMC
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyAmazonPrime() {
    // TODO: implement getSeriesCompanyAmazonPrime
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyBBCOne() {
    // TODO: implement getSeriesCompanyBBCOne
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyHBO() {
    // TODO: implement getSeriesCompanyHBO
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesCompanyNetflix() {
    // TODO: implement getSeriesCompanyNetflix
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresActionAndAdventure() {
    // TODO: implement getSeriesGenresActionAndAdventure
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresComedy() {
    // TODO: implement getSeriesGenresComedy
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresCrimen() {
    // TODO: implement getSeriesGenresCrimen
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresDocumental() {
    // TODO: implement getSeriesGenresDocumental
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresDrama() {
    // TODO: implement getSeriesGenresDrama
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresFamily() {
    // TODO: implement getSeriesGenresFamily
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresFantasyAndSciFi() {
    // TODO: implement getSeriesGenresFantasyAndSciFi
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresMistery() {
    // TODO: implement getSeriesGenresMistery
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresSoap() {
    // TODO: implement getSeriesGenresSoap
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresWarAndPolitics() {
    // TODO: implement getSeriesGenresWarAndPolitics
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesGenresWestern() {
    // TODO: implement getSeriesGenresWestern
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesUpcoming() {
    // TODO: implement getSeriesUpcoming
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getTopSeriesPopular() {
    // TODO: implement getTopSeriesPopular
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getTopSeriesRated() {
    // TODO: implement getTopSeriesRated
    return null;
  }

  @override
  Future<Either<Failures, List<SeriesEntity>>> getTopsSeries(int typeTop) {
    // TODO: implement getTopsSeries
    return null;
  }


}