import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent([List props = const <dynamic>[]]) : super (props);
}



class GetResults extends SearchEvent{
  
  final String query;
  
  GetResults(this.query) : super ([query]);
  
}