import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';
import 'package:dartz/dartz.dart';



abstract class WatchProviderDetailsContract {


  Future<Either<Failures, WatchProvider>> getWatchProvider(int id, String type);


}