import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserAuthTokenRemoteDataSource{

  Future<void> deleteToken();

  Future<bool> hasToken(); 
   
  Future<void> persistToken(String token);


}


class UserAuthTokenRemoteDataSourceImpl implements UserAuthTokenRemoteDataSource{
  

  // Create storage
  final storage = new FlutterSecureStorage();

  Preferences prefs = new Preferences();

  @override
  Future<void> deleteToken() async {

    await storage.delete(key: prefs.getCurrentUserUid);

    return;
  }

  @override
  Future<bool> hasToken() async {
  
    if(prefs.getCurrentUserUid == null){
      return false;
    }

    String value = await storage.read(key: prefs.getCurrentUserUid);
    print('Token saved: $value');
    prefs.currentUserHasToken = (value == null) ? false : true;

    return prefs.currentUserHasToken; 

  }

  @override
  Future<void> persistToken(String token) async {
    
    print('persist token is $token');
    await storage.write(key: prefs.getCurrentUserUid, value: token);

    return;
  }

}