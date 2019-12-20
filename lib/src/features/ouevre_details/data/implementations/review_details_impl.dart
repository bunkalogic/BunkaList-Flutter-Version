
import 'package:bunkalist/src/core/error/exception.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/review_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/review_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ReviewDetailsImpl implements ReviewDetailsContracts{
  
  final ReviewDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReviewDetailsImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });
  
  
  
  
  @override
  Future<Either<Failures, List<ReviewEntity>>> getReviews(int id, String type) async {
    networkInfo.isConnected;
    try{

      final remoteReviews = await remoteDataSource.getReviews(id, type);

      return Right(remoteReviews);

    }on ServerException{

      return Left(ServerFailure());

    }
  }


}