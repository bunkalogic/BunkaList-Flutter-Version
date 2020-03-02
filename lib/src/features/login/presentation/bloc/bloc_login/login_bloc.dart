import 'dart:async';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth_with_google.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_register.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth.dart' as paramsAuth;
import 'package:bunkalist/src/features/login/domain/usescases/get_user_register.dart' as paramsSign;
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  final GetUserRegister getUserRegister;
  final GetUserAuth getUserAuth;
  final AuthenticationBloc authenticationBloc;
  final GetUserWithGoogleAuth getGoogleAuth;

  LoginBloc({
    @required GetUserRegister userRegister,
    @required GetUserAuth userAuth,
    @required AuthenticationBloc authBloc,
    @required GetUserWithGoogleAuth googleAuth
  }) 
   :  assert(userRegister != null),
      assert(userAuth != null),
      assert(authBloc != null),
      assert(googleAuth != null),
      getUserRegister = userRegister,
      getUserAuth = userAuth,
      authenticationBloc = authBloc,
      getGoogleAuth = googleAuth;



  
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonPressed){

      yield LoginLoading();

      final eitherFailureOrAuth = await getUserAuth(paramsAuth.Params(email: event.email, password: event.password));
      event.toString();
      yield eitherFailureOrAuth.fold(
        (failure) => LoginFailure(error: _mapFailureToMessage(failure)), 
        (token){
          
          authenticationBloc.add(LoggedIn(token: token));

          return LoginSuccess();
        } 
      );

      

    }else if(event is SignInButtonPressed){

      yield LoginLoading();

      final eitherFailureOrSign = await getUserRegister(paramsSign.Params(email: event.email, password: event.password ));

      yield eitherFailureOrSign.fold(
        (failure) => LoginFailure(error: _mapFailureToMessage(failure)), 
        (empty) =>  LoginSuccess()
      );


    }else if(event is SignInWithGoogleButtonPressed){
      
      yield LoginLoading();

      final eitherFailureOrSignGoogle = await getGoogleAuth(NoParams());

      yield eitherFailureOrSignGoogle.fold(
        (failure) => LoginFailure(error: _mapFailureToMessage(failure)), 
        (token) {

          authenticationBloc.add(LoggedIn(token: token));   

          return LoginSuccess();
        } 
      ); 

    }
  }

  String _mapFailureToMessage(Failures failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
