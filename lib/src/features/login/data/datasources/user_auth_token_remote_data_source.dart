import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthTokenRemoteDataSource{

  Future<void> deleteToken();

  Future<bool> hasToken(); 
   
  Future<void> persistToken(String token);


}

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserAuthTokenRemoteDataSourceImpl implements UserAuthTokenRemoteDataSource{
  

  // Create storage
  final storage = new FlutterSecureStorage();

  @override
  Future<void> deleteToken() async {

    final FirebaseUser user = await _auth.currentUser();
    print(user.uid);
    print(user.getIdToken());
    await storage.delete(key: user.uid);

    return;
  }

  @override
  Future<bool> hasToken() async {
    final FirebaseUser user = await _auth.currentUser();
  
    if(user == null){
      return false;
    }

    String value = await storage.read(key: user.uid);

    bool hasToken = (value == null) ? false : true;

    return hasToken; 

  }

  @override
  Future<void> persistToken(String token) async {
    final FirebaseUser user = await _auth.currentUser();
    print(token);
    await storage.write(key: user.uid, value: token);

    return;
  }

}