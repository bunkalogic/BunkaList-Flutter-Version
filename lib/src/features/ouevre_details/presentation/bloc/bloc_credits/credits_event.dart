import 'package:equatable/equatable.dart';

abstract class CreditsEvent extends Equatable {
  const CreditsEvent([List props = const <dynamic>[]]) : super (props);
}

class GetDetailsCredits extends CreditsEvent{

  final int id;
  final String type;
  GetDetailsCredits(this.id, this.type) : super ([id, type]);
}