

import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRemoteDataSource{

  Future<String> getAuthenticate({String email, String password});
}



class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> getAuthenticate({String email, String password}) async {
    
     String token;
  
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    )).user;

    print('get firebase user uid: ${user.uid}');
    if(user != null && user.isEmailVerified){  
      Future<IdTokenResult> newToken = user.getIdToken();
      
      token = newToken.toString();
    }
    
    return token.toString(); 

  }

}