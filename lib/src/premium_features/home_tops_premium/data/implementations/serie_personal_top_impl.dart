
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/datasources/serie_personal_top_remote_data_source.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/serie_personal_top_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';


class SeriesPersonalTopsImpl extends SeriePersonalTopsContract{

  final SeriesPersonalTopsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SeriesPersonalTopsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });



  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesPersonalTops(int page, 
  {
  String sortBy, 
  int year, 
  int voteCountGte, 
  String genre, 
  String withKeywords, 
  String withNetwork,
  String withOriginalLanguage
  }
  ) async {
    
    if(await networkInfo.isConnected){

      try{

        final remotePersonalTopsSeries = await remoteDataSource.getPersonalTopsSeries(
          page,
          genre: genre,
          sortBy: sortBy,
          voteCountGte: voteCountGte,
          withKeywords: withKeywords,
          withNetwork: withNetwork,
          withOriginalLanguage: withOriginalLanguage,
          year: year
        
        );

        return Right(remotePersonalTopsSeries);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }


  }

}