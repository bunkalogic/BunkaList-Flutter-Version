import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserWithGoogleAuthRemoteDataSource{

  Future<String> getAuthWithGoogle();
}


class UserWithGoogleAuthRemoteDataSourceImpl implements UserWithGoogleAuthRemoteDataSource{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<String> getAuthWithGoogle() async {
    
    String token;

    Preferences prefs = new Preferences();

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken, 
      accessToken: googleAuth.accessToken
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    
    prefs.getCurrentUsername = user.displayName;
    prefs.getCurrentUserPhoto = user.photoUrl;
    prefs.getCurrentUserUid = user.uid;


    Future<IdTokenResult> newToken = currentUser.getIdToken();

    token = newToken.toString();

    return token;

  }

}