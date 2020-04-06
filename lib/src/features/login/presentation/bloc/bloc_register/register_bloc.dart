import 'dart:async';

import 'package:bunkalist/src/core/utils/validator_email_and_password.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_register.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  
  final GetUserRegister getUserRegister;

  RegisterBloc({
    @required GetUserRegister userRegister,
  }) 
   :  assert(userRegister != null), 
      getUserRegister = userRegister;

  
  @override
  RegisterState get initialState => RegisterState.empty();



  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    
    final eitherFailureOrSign = await getUserRegister(Params(email: email, password: password ));

      yield eitherFailureOrSign.fold(
        (failure) => RegisterState.failure(), 
        (empty) =>   RegisterState.success()
      );
  }
}

