import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/explorer/data/datasources/anime_explorer_remote_data_source.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/anime_explorer_contract.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';

class AnimesExplorerImpl extends AnimeExplorerContract{

  final AnimesExplorerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimesExplorerImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });



  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimeExplorer(int page, 
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

        final remoteExplorerAnimes = await remoteDataSource.getExplorerAnimes(
          page,
          genre: genre,
          sortBy: sortBy,
          voteCountGte: voteCountGte,
          withKeywords: withKeywords,
          withNetwork: withNetwork,
          year: year
        
        );

        return Right(remoteExplorerAnimes);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }


  }

}