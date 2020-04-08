
import 'dart:io';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/options/domain/contracts/changed_profile_image_contract.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:equatable/equatable.dart';

class GetChangedProfileImage extends UseCase<void, ParamsPi>{
  
  final  ChangeProfileImageContract contract;

  GetChangedProfileImage(this.contract);


  @override
  Future<Either<Failures, void>> call(ParamsPi paramsPi) async {
    
    return await contract.changeProfileImage(newImage: paramsPi.image);

  }

}

class ParamsPi extends Equatable{
  
  final File image;

  ParamsPi({ @required this.image}) : super([image]);
}