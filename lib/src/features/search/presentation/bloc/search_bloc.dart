import 'dart:async';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_validate_query.dart';
import 'package:bunkalist/src/features/search/domain/usescases/get_search.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  
  final GetSearch getSearch;

  SearchBloc({
    @required GetSearch search
  }) 
    : assert(search != null),
     getSearch = search;
  
  @override
  SearchState get initialState => SearchState.initial();


  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    print(transition.toString());
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is GetResults){
      final inputEither = GetValidateQuery().getValidateQuery(event.query);

      yield SearchState.loading();

      yield* inputEither.fold(
        (failures) async* {

          yield SearchState.error(_mapFailureToMessage(failures));

        }, (query) async*{

          final failureOrResults = await getSearch(Params(query: query));

          yield failureOrResults.fold(
            (failure) => SearchState.error(_mapFailureToMessage(failure)), 
            (results) => SearchState.success(results.results)
            );

        });
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
