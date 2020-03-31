import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/anime_tops_repository.dart';




class GetTopsAnime  extends UseCase<List<AnimeEntity>, Params> {

  final AnimeTopsRepository repository;
  
  GetTopsAnime(this.repository);


  @override
  Future<Either<Failures, List<AnimeEntity>>> call(Params params) async {
    return await repository.getTopsAnime(params.topTypeId, params.page);
  }
}

class Params extends Equatable {
  final int topTypeId;
  final int page;

  Params({@required this.topTypeId, @required this.page}) :super([topTypeId]);
}