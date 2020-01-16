import 'package:equatable/equatable.dart';

abstract class PeopleInfoEvent extends Equatable {
  const PeopleInfoEvent([List props = const <dynamic>[]]) : super (props);
}


class GetDetailsPeople extends PeopleInfoEvent{

  final int id;

  GetDetailsPeople(this.id) : super([id]);

}

class GetSocialMediaPeople extends PeopleInfoEvent{

  final int id;

  GetSocialMediaPeople(this.id) : super([id]);

}


class GetCreditsPeople extends PeopleInfoEvent{

  final int id;
  
  GetCreditsPeople(this.id) : super([id]);

}
