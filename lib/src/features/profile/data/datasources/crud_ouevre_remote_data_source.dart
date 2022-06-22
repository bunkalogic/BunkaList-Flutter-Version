

import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/data/datasources/post_rate_in_tmdb.dart';
import 'package:bunkalist/src/features/profile/data/models/oeuvre_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CrudOuevreRemoteDataSource{

  Future<List<int>> getTotalByStatus(String type);

  Future<void> addInFirebase(OuevreModel ouevre, String type);

  Future<void> deleteInFirebase(OuevreModel ouevre, String type);

  Stream<List<OuevreModel>> getOfFirebase( String type, ListProfileQuery status);

  Future<void> updateInFirebase(OuevreModel ouevre, String type);

  
  
}


class CrudOuevreRemoteDataSourceImpl implements CrudOuevreRemoteDataSource{
  
   
  Preferences prefs = new Preferences();
  final firebase = Firestore.instance;
  
  @override
  Future<void> addInFirebase(OuevreModel ouevre, String type) async {
    
    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    if(ouevre.status == 1){
      postRateTMDb(ouevre.oeuvreId.toString(), type, ouevre.finalRate);
    }
    

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
  Stream<List<OuevreModel>> getOfFirebase(String type, ListProfileQuery status) {
    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    switch (status) {
      case ListProfileQuery.Completed :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('finalRate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.Watching :{
        
        return ouevreCollection
        .where('status',isEqualTo: 2)
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });

      }
      
      case ListProfileQuery.Pause :{

        return ouevreCollection
        .where('status',isEqualTo: 3)
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });

      }
      
      case ListProfileQuery.Dropped :{
        return ouevreCollection
        .where('status',isEqualTo: 4)
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }
      
      case ListProfileQuery.Wishlist :{
        return ouevreCollection
        .where('status',isEqualTo: 5)
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      case ListProfileQuery.Last :{
        return ouevreCollection
        .orderBy('addDate', descending: true)
        .limit(15)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      case ListProfileQuery.Total : {
        return ouevreCollection
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      case ListProfileQuery.Favorite :{
        return ouevreCollection
        .where('isFavorite',isEqualTo: true)
        .orderBy('positionListFav', descending: false)
        .limit(prefs.isNotAds ? 20 : 10 )
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      case ListProfileQuery.CompleteAddDate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteHistoryRate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('historyRate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteCharacterRate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('characterRate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteOSTRate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('ostRate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteEffectsRate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('effectsRate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteEnjoymentRate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('enjoymentRate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteOeuvreRating :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('oeuvreRating', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }

      case ListProfileQuery.CompleteOeuvreReleaseDate :{

        return ouevreCollection
        .where('status',isEqualTo: 1)
        .orderBy('oeuvreReleaseDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();
          
        });

      }


      case ListProfileQuery.AllOrderDate :{
        return ouevreCollection
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }

      
      default:{
        return ouevreCollection
        .where('status',isEqualTo: 5)
        .orderBy('addDate', descending: true)
        .snapshots().map((snap){
          
          return snap.documents
          .map((doc) =>  OuevreModel.fromSnapshot(doc))
          .toList();

        });
      }  
    }
  }

  @override
  Future<List<int>> getTotalByStatus(String type) async {
    List<int> listTotalByStatus = new List<int>();

    print('getting total by status');

    final ouevreCollection = firebase
    .collection('user/${prefs.getCurrentUserUid}/list$type');

    final QuerySnapshot completed = await ouevreCollection
        .where('status',isEqualTo: 1)
        .getDocuments();    
    

    listTotalByStatus
    ..add(completed.documents.length);
    

    final QuerySnapshot watching = await ouevreCollection
        .where('status',isEqualTo: 2)
        .getDocuments();


    listTotalByStatus
    ..add(watching.documents.length);

    final QuerySnapshot pause = await ouevreCollection
        .where('status',isEqualTo: 3)
        .getDocuments();



    listTotalByStatus
    ..add(pause.documents.length);

    final QuerySnapshot dropped = await ouevreCollection
        .where('status',isEqualTo: 4)
        .getDocuments();

    

    listTotalByStatus
    ..add(dropped.documents.length);    

    final QuerySnapshot wishlist = await ouevreCollection
        .where('status',isEqualTo: 5)
        .getDocuments();
    
        

    listTotalByStatus
    ..add(wishlist.documents.length);

    print('get list $type by total status $listTotalByStatus');

    return listTotalByStatus;                                

  }

  

}