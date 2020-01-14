import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_social_media_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PeopleSocialMediaContract{

  Future <Either<Failures, PeopleSocialMediaEntity>> getPeopleSocialMedia(int id);
}