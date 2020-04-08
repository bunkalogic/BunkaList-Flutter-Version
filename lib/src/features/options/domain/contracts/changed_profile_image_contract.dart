
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ChangeProfileImageContract{

  Future<Either<Failures, void>> changeProfileImage({@required File newImage });
  
}