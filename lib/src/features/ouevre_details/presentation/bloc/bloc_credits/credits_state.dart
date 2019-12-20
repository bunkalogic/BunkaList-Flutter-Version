import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CreditsState extends Equatable {
  const CreditsState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends CreditsState{}

class Loading extends CreditsState{}

class Loaded extends CreditsState{
  final CreditsEntity credits;
  Loaded({ @required this.credits }) : super([credits]);
}

class Error extends CreditsState{
  final String message;
  Error({@required this.message}) : super ([message]);
}
