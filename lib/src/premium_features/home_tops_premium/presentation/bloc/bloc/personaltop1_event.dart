part of 'personaltop1_bloc.dart';

abstract class Personaltop1Event extends Equatable {
  const Personaltop1Event([List props = const <dynamic>[]]) : super(props);
}


class GetPersonalTop1 extends Personaltop1Event{

 final FilterParams filterParams;
 final int page;

 GetPersonalTop1({
   @required this.filterParams,
   @required this.page
 }) : super([
   filterParams,
   page
 ]);
}
