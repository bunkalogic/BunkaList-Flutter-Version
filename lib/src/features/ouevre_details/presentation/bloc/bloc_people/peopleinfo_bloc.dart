import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_credits.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_social_media.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_credits.dart' as paramsCredits;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_details.dart' as paramsDetails;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_social_media.dart' as paramsSM;
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class PeopleInfoBloc extends Bloc<PeopleInfoEvent, PeopleInfoState> {
  
  //? Instantiating the Usescases
  final GetPeopleDetails getPeopleDetails;
  final GetPeopleSocialMedia getPeopleSocialMedia;
  final GetPeopleCredits getPeopleCredits;

  PeopleInfoBloc({
    @required GetPeopleDetails peopleDetails,
    @required GetPeopleSocialMedia peopleSocialMedia,
    @required GetPeopleCredits peopleCredits,
  }) :  assert(peopleDetails != null),
        assert(peopleSocialMedia != null),
        assert(peopleCredits != null),
        getPeopleDetails = peopleDetails,
        getPeopleSocialMedia = peopleSocialMedia,
        getPeopleCredits = peopleCredits; 

  
  @override
  PeopleInfoState get initialState => Empty();

  @override
  Stream<PeopleInfoState> mapEventToState(
    PeopleInfoEvent event,
  ) async* {
    if(event is GetDetailsPeople){
      final inputEither = GetTopId().getValidateTopId(event.id);

      yield* inputEither.fold(
        (failures) async*{

          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

        }, (id) async*{

          yield Loading();

          final failureOrPeopleDetails = await getPeopleDetails(paramsDetails.Params(id: id));

          yield failureOrPeopleDetails.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)), 
            (people) => LoadedDetailsPeople(people: people)
          );

        }
      );

    }else if (event is GetSocialMediaPeople){
      final inputEither = GetTopId().getValidateTopId(event.id);

      yield* inputEither.fold(
        (failures) async*{

          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

        }, (id) async*{

          yield Loading();

          final failureOrPeopleSocialMedia = await getPeopleSocialMedia(paramsSM.Params(id: id));

          yield failureOrPeopleSocialMedia.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)), 
            (people) => LoadedSocialMediaPeople(peopleSocialMedia: people)
          );

        }
      );

    }else if (event is GetCreditsPeople){
      final inputEither = GetTopId().getValidateTopId(event.id);

      yield* inputEither.fold(
        (failures) async*{

          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

        }, (id) async*{

          yield Loading();

          final failureOrPeopleCredits = await getPeopleCredits(paramsCredits.Params(id: id));

          yield failureOrPeopleCredits.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)), 
            (people) => LoadedCreditsPeople(people: people)
          ); 

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
