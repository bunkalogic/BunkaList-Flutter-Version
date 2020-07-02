
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchState extends Equatable{
  SearchState([List props = const <dynamic>[]]) : super(props);
}

class EmptySearch extends SearchState{}

class LoadingSearch extends SearchState{}

class LoadedSearch extends SearchState{
  final List<Result> results;

  LoadedSearch({@required this.results}) : super([results]);
}

class ErrorSearch extends SearchState{}

class ErrorEmptySearch extends SearchState{}


// class SearchState {
  
//   final bool isLoading;
//   final List<Result> results;
//   final bool hasError;
  
//   const SearchState({
//   this.isLoading, 
//   this.results,  
//   this.hasError,
//   });


//   factory SearchState.initial(){
    
//     return SearchState(
//       results: [],
//       isLoading: false,
//       hasError: false,
//     );
//   }

//   factory SearchState.loading(){

//     return SearchState(
//       results: [],
//       isLoading: true,
//       hasError: false,
//     );
//   }

//   factory SearchState.success(List<Result> results){
    
//     return SearchState(
//       results: results,
//       isLoading: false,
//       hasError: false,
//     );
//   }


//   factory SearchState.error(){
    
//     return SearchState(
//       results: [],
//       isLoading: false,
//       hasError: true,
//     );
//   }

  
//    @override
//   String toString() =>
//       'SearchState { results: ${results.toString()}, isLoading: $isLoading, hasError: $hasError }';

// }


