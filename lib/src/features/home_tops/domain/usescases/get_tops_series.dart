import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/serie_tops_repository.dart';



class GetTopsSeries  extends UseCase<List<SeriesEntity>, Params> {

  final SeriesTopsRepository repository;
  
  GetTopsSeries(this.repository);


  @override
  Future<Either<Failures, List<SeriesEntity>>> call(Params params) async {
    return await repository.getTopsSeries(params.topTypeId, params.page);
  }
}

class Params extends Equatable {
  final int topTypeId;
  final int page;

  Params({@required this.topTypeId, @required this.page}) :super([topTypeId, page]);
}