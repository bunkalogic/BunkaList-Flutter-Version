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
        Duration(milliseconds: 200),
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
    // SearchState newLoading = LoadingSearch();

    
    if(event is TextSearchChanged){
      print('----- is text search changed event -----');
      // List<Result> listResults;
      
      // yield LoadingSearch();

      if(event.text.isEmpty){

        print('----- is empty search -----');
        yield new EmptySearch();

      }
      
      print('-----is loading search -----');
      yield new LoadingSearch();
        
      Either<Failures, String> inputEither = GetValidateQuery().getValidateQuery(event.text);  

      yield*  inputEither.fold(
        (failures) async* {

          print('-----is error search 1------');
          yield new ErrorSearch();

        }, (query) async*{
          print('----- is get search ------');

          final failureOrResults = await getSearch(Params(query: query));


          yield failureOrResults.fold(
            (failure) {
              print('------is error search 2 ------');
              return new ErrorSearch();
            },
            (results) {

              List<Result> listResults = results.results;

              SearchState newLoaded = new LoadedSearch(results: listResults);  
              print('------is search loaded!!! ------');
              return newLoaded;
            }  
            );
        });

        

      
      
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
