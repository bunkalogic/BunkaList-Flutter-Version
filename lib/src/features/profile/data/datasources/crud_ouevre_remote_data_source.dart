

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/data/models/oeuvre_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CrudOuevreRemoteDataSource{

  Future<void> addInFirebase(OuevreModel ouevre, String type);

  Future<void> deleteInFirebase(OuevreModel ouevre, String type);

  Stream<List<OuevreModel>> getOfFirebase( String type, String status);

  Future<void> updateInFirebase(OuevreModel ouevre, String type);
  
}


class CrudOuevreRemoteDataSourceImpl implements CrudOuevreRemoteDataSource{
  
   
  Preferences prefs = new Preferences();
  final firebase = Firestore.instance;
  
  @override
  Future<void> addInFirebase(OuevreModel ouevre, String type) async {
    
    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    return await ouevreCollection
    .document(ouevre.oeuvreId.toString())
    .setData(ouevre.toDocument());

  }

  @override
  Future<void> deleteInFirebase(OuevreModel ouevre, String type) async {
    
    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    return await ouevreCollection
    .document(ouevre.oeuvreId.toString())
    .delete();

  }

  @override
  Future<void> updateInFirebase(OuevreModel ouevre, String type) async {
    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    return await ouevreCollection
    .document(ouevre.oeuvreId.toString())
    .updateData(ouevre.toDocument());

  }

  @override
  Stream<List<OuevreModel>> getOfFirebase(String type, String status) {
    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    switch (status) {
      case 'Completed':{

        return ouevreCollection
        .where('status',isEqualTo: 'Completed')
        .orderBy('finalRate')
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case 'Watching':{
        
        return ouevreCollection
        .where('status',isEqualTo: 'Watching')
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });

      }
      
      case 'Pause':{

        return ouevreCollection
        .where('status',isEqualTo: 'Pause')
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });

      }
      
      case 'Dropped':{
        return ouevreCollection
        .where('status',isEqualTo: 'Dropped')
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }
      
      case 'WishList':{
        return ouevreCollection
        .where('status',isEqualTo: 'WishList')
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      case 'Last':{
        return ouevreCollection
        .orderBy('addDate', descending: true)
        .limit(10)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      
      default:{
        return ouevreCollection
        .where('status',isEqualTo: 'WishList')
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }  
    }
  }

  

}