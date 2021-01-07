
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:bunkalist/src/features/search/domain/contracts/search_result_contract.dart';

class SearchResultImpl implements SearchResultContract{

  final SearchResultRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  SearchResultImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failures, ResultsEntity>> getSearch(String query, int page) async {
    
    if(await networkInfo.isConnected){

      try{

        final remoteSearchInfo = await remoteDataSource.getSearchResult(query, page);

        return Right(remoteSearchInfo);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }

  }

}