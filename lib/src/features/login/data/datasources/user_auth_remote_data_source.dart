

import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRemoteDataSource{

  Future<String> getAuthenticate({String email, String password});
}



class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Preferences prefs = new Preferences();

  @override
  Future<String> getAuthenticate({String email, String password}) async {
    
     String token;
  
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    )).user;

    print('get firebase user uid: ${user.uid}');
    if(user != null && user.isEmailVerified){ 

      prefs.getCurrentUsername = user.displayName;
      prefs.getCurrentUserPhoto = user.photoUrl;
      prefs.getCurrentUserUid = user.uid;

      Future<IdTokenResult> newToken = user.getIdToken();
      
      token = newToken.toString();
    }
    
    return token.toString(); 

  }

}