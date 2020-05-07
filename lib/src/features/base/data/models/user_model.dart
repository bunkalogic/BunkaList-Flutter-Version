

import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity{

  UserModel({
    final String    username,
    final String    email,
    final String    photoUrl,
    final bool      isNotAds,
    final bool      isPremium,
    final DateTime  subcriptionTime,
  }) : super(
    username        : username,
    email           : email, 
    photoUrl        : photoUrl,
    isNotAds        : isNotAds,
    isPremium       : isPremium,
    subcriptionTime : subcriptionTime
  );


  factory UserModel.fromSnapshot(DocumentSnapshot snap){

     Timestamp timestamp = snap.data['subcriptionTime'];
    
    DateTime datetime = timestamp.toDate();

    return UserModel(
      username        : snap.data['username'],
      email           : snap.data['email'],
      photoUrl        : snap.data['photoUrl'],
      isNotAds        : snap.data['isNotAds'],
      isPremium       : snap.data['isPremium'],
      subcriptionTime : datetime,
    );
  }


   Map<String, Object> toDocument(){
     return {
      "username"       : username,
      "email"          : email, 
      "photoUrl"       : photoUrl,
      "isNotAds"       : isNotAds,
      "isPremium"      : isPremium,
      "subcriptionTime": subcriptionTime
     };
   }

}