import 'package:bunkalist/src/premium_features/home_tops_premium/data/datasources/anime_personal_top_remote_data_source.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/anime_personal_top_contract.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:dartz/dartz.dart';

class AnimesPersonalTopsImpl extends AnimePersonalTopsContract{

  final AnimesPersonalTopsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnimesPersonalTopsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });



  @override
  Future<Either<Failures, List<AnimeEntity>>> getAnimePersonalTops(int page, 
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

        final remotePersonalTopsAnimes = await remoteDataSource.getPersonalTopsAnimes(
          page,
          genre: genre,
          sortBy: sortBy,
          voteCountGte: voteCountGte,
          withKeywords: withKeywords,
          withNetwork: withNetwork,
          year: year
        
        );

        return Right(remotePersonalTopsAnimes);

      }on ServerException{

        return Left(ServerFailure());

      }

    }else{

      return Left(ServerFailure());
    
    }


  }

}