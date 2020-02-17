import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRegisterRemoteDataSource{

  Future<void> getRegister({String email, String password});

}

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserRegisterRemoteDataSourceImpl implements UserRegisterRemoteDataSource{

  
  
  @override
  Future<void> getRegister({String email, String password}) async {
    
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    )).user;

    if(user != null){
      
      user.sendEmailVerification();
      
    }
  }

}