import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_credits_details.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class CreditsBloc extends Bloc<CreditsEvent, CreditsState> {
  
  final GetCreditsDetails getCreditsDetails;

  CreditsBloc({
    @required GetCreditsDetails credits
  }) :
  assert(credits != null),
  getCreditsDetails = credits;
  
  @override
  CreditsState get initialState => Empty();

  @override
  Stream<CreditsState> mapEventToState(
    CreditsEvent event,
  ) async* {
    if(event is GetDetailsCredits){
      final inputEither = GetTopId().getValidateTopId(event.id);
      final String type = event.type;

       yield* inputEither.fold(
        (failures) async* {
          
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);

      }, (id) async*{

        yield Loading();

        final failureOrCredits = await getCreditsDetails(Params(id: id, type: type));

        yield* _eitherLoadedOrErrorState(failureOrCredits);

      });
    }
  }

  Stream<CreditsState> _eitherLoadedOrErrorState
  (Either<Failures, CreditsEntity> either) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)), 
      (credits)  => Loaded(credits: credits)
    );
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
