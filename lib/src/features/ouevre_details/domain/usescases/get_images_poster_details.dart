import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/images_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class GetPosterImagesDetails extends UseCase<PosterImages, ParamsPosterImages>{
  
  final ImagesPosterDetailsContract contract;

  GetPosterImagesDetails(this.contract);


  @override
  Future<Either<Failures, PosterImages>> call(paramsPosterImages) async {
    return await contract.getImagesPoster(paramsPosterImages.id, paramsPosterImages.type);
  }

}

class ParamsPosterImages extends Equatable{
  final int id;
  final String type;

  ParamsPosterImages({@required this.id, @required this.type}) : super([id, type]);
}