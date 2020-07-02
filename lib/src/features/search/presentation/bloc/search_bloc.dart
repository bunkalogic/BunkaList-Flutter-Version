import 'dart:async';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dartz/dartz.dart';
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
Stream<SearchState> transformEvents(
  Stream<SearchEvent> events,
  Stream<SearchState> Function(SearchEvent event) next,
) {
  return super.transformEvents( 
      (events as Observable<SearchEvent>).debounceTime(
        Duration(milliseconds: 300),
      ), 
      next
    );
}

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

  @override
  SearchState get initialState =>  EmptySearch();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is TextSearchChanged){
      List<Result> listResults;
      if(event.text.isEmpty){

        yield EmptySearch();

      }else{
       yield LoadingSearch();
        
      final inputEither = GetValidateQuery().getValidateQuery(event.text);
      

      yield* inputEither.fold(
        (failures) async* {

          yield ErrorSearch();

        }, (query) async*{

          final failureOrResults = await getSearch(Params(query: query));

          yield failureOrResults.fold(
            (failure) => ErrorSearch(),
            (results) {
              if(results.totalResults == 0){
                return ErrorEmptySearch();
              }

              listResults = results.results;

              return LoadedSearch(results: listResults);
            }  
            );
        });

        

      }
      
    }
      
  }


  // String _mapFailureToMessage(Failures failure) {
  // // Instead of a regular 'if (failure is ServerFailure)...'
  //   switch (failure.runtimeType) {
  //     case ServerFailure:
  //       return SERVER_FAILURE_MESSAGE;
  //     default:
  //       return 'Unexpected Error';
  //   }
  // }
}
