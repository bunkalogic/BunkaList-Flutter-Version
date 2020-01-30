
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class SearchState extends Equatable {
  
  const SearchState([List props = const <dynamic>[]]) : super(props);

}

class Empty extends SearchState{}

class Loading extends SearchState{}

class LoadedMovie extends SearchState{
  final List<Result> results;
  LoadedMovie({ @required this.results }) : super([results]);
}

class LoadedSerie extends SearchState{
  final List<Result> results;
  LoadedSerie({ @required this.results }) : super([results]);
}

class LoadedAnime extends SearchState{
  final List<Result> results;
  LoadedAnime({ @required this.results }) : super([results]);
}

class LoadedPerson extends SearchState{
  final List<Result> results;
  LoadedPerson({ @required this.results }) : super([results]);
}

class Error extends SearchState{
  final String message;
  Error({@required this.message}) : super ([message]);
}
