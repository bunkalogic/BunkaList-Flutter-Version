import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_anime.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:equatable/equatable.dart';

part 'selectionanimes_event.dart';
part 'selectionanimes_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Top Id Movie';

class SelectionanimesBloc extends Bloc<SelectionanimesEvent, SelectionanimesState> {
  
  final GetTopsAnime getTopsAnimes;

  SelectionanimesBloc
  ({@required GetTopsAnime animes}) 
  : assert(animes != null),
  getTopsAnimes = animes;
  
  @override
  SelectionanimesState get initialState => SelectionanimesInitial();

  @override
  Stream<SelectionanimesState> mapEventToState(
    SelectionanimesEvent event,
  ) async* {
    if(event is  GetSelectionAnime){
      final inputEither = GetTopId().getValidateTopId(event.topId);

      yield* inputEither.fold(
        (failures) async* {
          yield ErrorSelectionanimesBlocAnimes(message: INVALID_INPUT_FAILURE_MESSAGE );

        },(topId) async* {
          yield LoadingSelectionanimesBlocAnimes();
          final failureOrAnimes = await getTopsAnimes(Params(topTypeId: topId, page: event.page));
          
          yield* _eitherLoadedOrErrorState(failureOrAnimes); 
        });
    }
  }

  Stream<SelectionanimesState> _eitherLoadedOrErrorState
  (Either<Failures, List<AnimeEntity>> either) async* {
    yield either.fold(
      (failure) => ErrorSelectionanimesBlocAnimes(message: _mapFailureToMessage(failure)), 
      (animes)  => LoadedSelectionanimesBlocAnimes(animes: animes)
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
