import 'dart:async';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_anime.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:equatable/equatable.dart';

part 'animeseason_event.dart';
part 'animeseason_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class AnimeSeasonBloc extends Bloc<AnimeSeasonEvent, AnimeSeasonState> {
  
  final GetTopsAnime getTopsAnimes;

  AnimeSeasonBloc
  ({@required GetTopsAnime animes}) 
  : assert(animes != null),
  getTopsAnimes = animes;
  
  @override
  AnimeSeasonState get initialState => AnimeSeasonInitial();

  @override
  Stream<AnimeSeasonState> mapEventToState(
    AnimeSeasonEvent event,
  ) async* {
    if(event is GetSeasonAnime){
      final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failures) async* {
          yield ErrorAnimes(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          yield LoadingAnimes();
          final failureOrAnimes = await getTopsAnimes(Params(topTypeId: topId, page: event.page));
          
          yield* _eitherLoadedOrErrorState(failureOrAnimes); 
        });
    }
  }

  Stream<AnimeSeasonState> _eitherLoadedOrErrorState
  (Either<Failures, List<AnimeEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorAnimes(message: _mapFailureToMessage(failure)), 
      (animes)  => LoadedAnimes(animes: animes)
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
