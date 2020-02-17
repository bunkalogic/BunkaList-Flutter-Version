

import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRemoteDataSource{

  Future<String> getAuthenticate({String email, String password});
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource{
  
  @override
  Future<String> getAuthenticate({String email, String password}) async {
    
     String token;

    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    )).user;

    if(user != null){

      String newToken = user.getIdToken(refresh: true).toString();

      token = newToken;
    }

    return token;

  }

}