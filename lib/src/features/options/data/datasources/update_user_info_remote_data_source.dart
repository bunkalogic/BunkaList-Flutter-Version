import 'dart:async';
import 'dart:io';

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';



abstract class UpdateUserInfoRemoteDataSource{

  Future<void> updateProfileImage(File image);

  Future<void> updateUsername(String username);


}

class UpdateUserInfoRemoteDataSourceImpl implements UpdateUserInfoRemoteDataSource{
  
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Preferences prefs = new Preferences();
  Uuid uuid = Uuid();

  
  @override
  Future<void> updateUsername(String username) async {
    
    print('Old Username: ${prefs.getCurrentUsername}');

    FirebaseUser currentUser = await _auth.currentUser();

    UserUpdateInfo userUpdateInfo  = new UserUpdateInfo();

    userUpdateInfo.displayName = username;
    userUpdateInfo.photoUrl = prefs.getCurrentUserPhoto;

    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();

    currentUser = await _auth.currentUser();

    prefs.getCurrentUsername = currentUser.displayName;

    print('New Username: ${prefs.getCurrentUsername}');

  }
  
  @override
  Future<void> updateProfileImage(File image) async {
    
    print('Old Photo Profile Url: ${prefs.getCurrentUserPhoto}');

    FirebaseUser currentUser = await _auth.currentUser();

    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();


    final String filename = uuid.v4();

    print('File name:  $filename');
    
    // Uint8List imageBytes = image.readAsBytesSync() as Uint8List;

    final StorageReference storageReference = FirebaseStorage().ref().child('PROFILEIMAGES/$filename');

    final StorageUploadTask uploadTask = storageReference.putFile(image);

    final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print('EVENT ${event.type}');
    });

    // Cancel your subscription when done.
    await uploadTask.onComplete;
    streamSubscription.cancel();

    // obtenemos el url de la foto
    final String imageProfileUrl = await storageReference.getDownloadURL();

    print('New url $imageProfileUrl');

    // update del photo url
    userUpdateInfo.displayName = prefs.getCurrentUsername;
    userUpdateInfo.photoUrl = imageProfileUrl;
    

    await currentUser.updateProfile(userUpdateInfo);

    await currentUser.reload();

    currentUser = await _auth.currentUser();

    prefs.getCurrentUserPhoto =  currentUser.photoUrl;

    print('New Photo Profile Url: ${prefs.getCurrentUserPhoto}');
  }

  


  
}
