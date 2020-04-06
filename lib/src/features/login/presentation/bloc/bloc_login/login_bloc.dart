import 'dart:async';

import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/core/utils/validator_email_and_password.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth_with_google.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth.dart' as paramsAuth;
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  final GetUserAuth getUserAuth;
  final AuthenticationBloc authenticationBloc;
  final GetUserWithGoogleAuth getGoogleAuth;

  LoginBloc({
    @required GetUserAuth userAuth,
    @required AuthenticationBloc authBloc,
    @required GetUserWithGoogleAuth googleAuth
  }) 
   :  assert(userAuth != null),
      assert(authBloc != null),
      assert(googleAuth != null),
      getUserAuth = userAuth,
      authenticationBloc = authBloc,
      getGoogleAuth = googleAuth;



  
  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

   Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    final eitherFailureOrSignGoogle = await getGoogleAuth(NoParams());

    yield eitherFailureOrSignGoogle.fold(
        (failure) => LoginState.failure(), 
        (token)  {
          authenticationBloc.add(LoggedIn(token: token)); 
          return LoginState.success();
        } ,
      ); 
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    
    final eitherFailureOrAuth = await getUserAuth(paramsAuth.Params(email: email, password: password));

     yield eitherFailureOrAuth.fold(
        (failure) => LoginState.failure(), 
        (token){
          
          authenticationBloc.add(LoggedIn(token: token));

          return LoginState.success();
        } 
      ); 

  }

}
