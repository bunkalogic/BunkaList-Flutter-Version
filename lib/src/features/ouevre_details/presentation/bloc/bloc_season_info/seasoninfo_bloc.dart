import 'dart:async';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_season_info_details.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class SeasonInfoBloc extends Bloc<SeasonInfoEvent, SeasonInfoState> {
  
  final GetSeasonInfo getSeasonInfo;

  SeasonInfoBloc({
    @required GetSeasonInfo season
  }) 
  : assert(season != null),
  getSeasonInfo = season;
  
  @override
  SeasonInfoState get initialState => Empty();

  @override
  Stream<SeasonInfoState> mapEventToState(
    SeasonInfoEvent event,
  ) async* {
    if(event is GetInfoSeason){
      final inputEither = GetTopId().getValidateTopId(event.id);
      final int seasonId = event.seasonId;

       yield* inputEither.fold(
        (failures) async* {
          
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);

      }, (id) async*{

        yield Loading();

        final failureOrReview = await getSeasonInfo(Params(id: id, seasonId: seasonId));

        yield* _eitherLoadedOrErrorState(failureOrReview);

      });

    }
  }

  Stream<SeasonInfoState> _eitherLoadedOrErrorState
  (Either<Failures, SeasonEntity> either) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)), 
      (season)  => Loaded(season: season)
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
