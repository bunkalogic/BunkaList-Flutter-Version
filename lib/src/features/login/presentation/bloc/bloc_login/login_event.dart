import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}

class SignInButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const SignInButtonPressed ({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'SignInButtonPressed  { email: $email, password: $password }';
}


class SignInWithGoogleButtonPressed extends LoginEvent {
  

  const SignInWithGoogleButtonPressed ();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'SignInWithGoogleButtonPressed';
}