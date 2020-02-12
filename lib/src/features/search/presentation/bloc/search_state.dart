
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';



class SearchState {
  
  final bool isLoading;
  final List<Result> results;
  final bool hasError;
  final String errorMessage;
  
  const SearchState({
  this.isLoading, 
  this.results,  
  this.hasError,
  this.errorMessage
  });


  factory SearchState.initial(){
    
    return SearchState(
      results: [],
      isLoading: false,
      hasError: false,
      errorMessage: ''
    );
  }

  factory SearchState.loading(){
    
    return SearchState(
      results: [],
      isLoading: true,
      hasError: false,
      errorMessage: ''
    );
  }

  factory SearchState.success(List<Result> results){
    
    return SearchState(
      results: results,
      isLoading: false,
      hasError: false,
      errorMessage: ''
    );
  }


  factory SearchState.error(String message){
    
    return SearchState(
      results: [],
      isLoading: false,
      hasError: true,
      errorMessage: message
    );
  }

  
   @override
  String toString() =>
      'SearchState {results: ${results.toString()}, isLoading: $isLoading, hasError: $hasError , errorMessage: $errorMessage }';

}


