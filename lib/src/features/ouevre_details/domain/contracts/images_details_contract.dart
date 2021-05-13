import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:dartz/dartz.dart';



abstract class ImagesPosterDetailsContract {


  Future<Either<Failures, PosterImages>> getImagesPoster(int id, String type);


}