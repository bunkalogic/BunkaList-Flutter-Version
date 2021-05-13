import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/watch_provider_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class GetWatchProviderDetails extends UseCase<WatchProvider, ParamsWatchProvider>{
  
  final WatchProviderDetailsContract contract;

  GetWatchProviderDetails(this.contract);


  @override
  Future<Either<Failures, WatchProvider>> call(paramsWatchProvider) async {
    return await contract.getWatchProvider(paramsWatchProvider.id, paramsWatchProvider.type);
  }

}

class ParamsWatchProvider extends Equatable{
  final int id;
  final String type;

  ParamsWatchProvider({@required this.id, @required this.type}) : super([id, type]);
}