import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_credits_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_social_media_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeopleInfoState extends Equatable {
  const PeopleInfoState([List props = const <dynamic>[]]) : super(props);
}


class Empty extends PeopleInfoState{}

class Loading extends PeopleInfoState{}

class LoadedDetailsPeople extends PeopleInfoState{
  
  final PeopleEntity people;
  LoadedDetailsPeople({@required this.people}) : super ([people]);

}

class LoadedCreditsPeople extends PeopleInfoState{
  
  final PeopleCreditsEntity people;
  LoadedCreditsPeople({@required this.people}) : super ([people]);

}

class LoadedSocialMediaPeople extends PeopleInfoState{

  final PeopleSocialMediaEntity peopleSocialMedia;
  LoadedSocialMediaPeople({@required this.peopleSocialMedia}) : super ([peopleSocialMedia]); 
}

class Error extends PeopleInfoState{
  final String message;
  Error({@required this.message}) : super ([message]);
}