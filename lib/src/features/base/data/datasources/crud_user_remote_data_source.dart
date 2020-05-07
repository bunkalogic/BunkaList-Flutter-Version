


import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/base/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CrudUserRemoteDataSource{

  Future<void> addUserDataInFirebase(UserModel userModel);

  Stream<UserModel> getOfFirebase();

  Future<void> updateUserDataInFirebase(UserModel userModel);
}

class CrudUserRemoteDataSourceImpl implements CrudUserRemoteDataSource{
  
  Preferences prefs = new Preferences();
  final firebase = Firestore.instance;
  
  @override
  Future<void> addUserDataInFirebase(UserModel userModel) async {

    final userDataCollection = firebase.collection('user/${prefs.getCurrentUserUid}/userData');

    return await userDataCollection
    .document(prefs.getCurrentUserUid.toString())
    .setData(userModel.toDocument());

  }

  @override
  Stream<UserModel> getOfFirebase() {
    final userDataCollection = firebase.collection('user/${prefs.getCurrentUserUid}/userData');
    
    return userDataCollection
    .snapshots().map((snap){
      
      final DocumentSnapshot snapData = snap.documents.first;

      final UserModel userModel = new UserModel.fromSnapshot(snapData);

      return userModel;

    });
  }

  @override
  Future<void> updateUserDataInFirebase(UserModel userModel) async {
    final userDataCollection = firebase.collection('user/${prefs.getCurrentUserUid}/userData');

    return await userDataCollection
    .document(prefs.getCurrentUserUid.toString())
    .updateData(userModel.toDocument());
  }

}