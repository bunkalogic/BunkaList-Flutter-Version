
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/explorer/data/datasources/series_explorer_remote_source.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/serie_explorer_contract.dart';

class SeriesExplorerImpl extends SerieExplorerContract{

  final SeriesExplorerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SeriesExplorerImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });



  @override
  Future<Either<Failures, List<SeriesEntity>>> getSeriesExplorer(int page, 
  {
  String sortBy, 
  int year, 
  int voteCountGte, 
  String genre, 
  String withKeywords, 
  String withNetwork
  }
  ) async {
    
    if(await networkInfo.isConnected){

      try{

        final remoteExplorerSeries = await remoteDataSource.getExplorerSeries(
          page,
          genre: genre,
          sortBy: sortBy,
          voteCountGte: voteCountGte,
          withKeywords: withKeywords,
          withNetwork: withNetwork,
          year: year
        
        );

        return Right(remoteExplorerSeries);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }


  }

}