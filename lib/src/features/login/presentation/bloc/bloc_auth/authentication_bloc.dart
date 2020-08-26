import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_delete_token.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_has_token.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_persist_token.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';
import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  Preferences prefs = Preferences();
  final GetUserHasToken userHasToken;
  final GetUserDeleteToken userDeleteToken;
  final GetUserPersistToken userPersistToken;

  AuthenticationBloc({
    @required GetUserHasToken hasToken,
    @required GetUserDeleteToken deleteToken,
    @required GetUserPersistToken persistToken
  }) :
  assert(hasToken != null),
  assert(deleteToken != null),
  assert(persistToken != null),
  userHasToken = hasToken,
  userDeleteToken = deleteToken,
  userPersistToken = persistToken;
  

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      if(prefs.isOpenFirstTime){
        yield AuthenticationFirstTimeOpen();
      } 


      final Either<Failures, bool> eitherFailOrBolean = await userHasToken(NoParams());
      

      bool hasToken;

      eitherFailOrBolean.fold(
        (failure) => failure, 
        (boolean) => hasToken = boolean
        );
        print('has token: $hasToken');

       

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
     
      await userPersistToken(Params(token: event.token));
      event.toString();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userDeleteToken(NoParams());

      yield AuthenticationUnauthenticated();
    }
  }
}
