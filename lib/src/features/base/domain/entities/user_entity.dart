import 'package:bunkalist/src/features/base/data/models/user_model.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class UserEntity extends Equatable{
  
  final String    username;
  final String    email;
  final String    photoUrl;
  final bool      isNotAds;
  final bool      isPremium;
  final DateTime  subcriptionTime;
  

  UserEntity({
    this.username,
    this.email,
    this.photoUrl,
    this.isNotAds,
    this.isPremium,
    this.subcriptionTime
  }) : super ([
    username,
    email,
    photoUrl,
    isNotAds,
    isPremium,
    subcriptionTime
  ]);

  UserModel toModel(){
    return UserModel(
      username        : username,
      email           : email, 
      photoUrl        : photoUrl,
      isNotAds        : isNotAds,
      isPremium       : isPremium,
      subcriptionTime : subcriptionTime
    );
  }

  static UserEntity fromModel(UserModel model){

    return UserEntity(

      username        : model.username ?? "",
      email           : model.email ?? "", 
      photoUrl        : model.photoUrl ?? "",
      isNotAds        : model.isNotAds ?? false,
      isPremium       : model.isPremium ?? false,
      subcriptionTime : model.subcriptionTime

    );


  }
}