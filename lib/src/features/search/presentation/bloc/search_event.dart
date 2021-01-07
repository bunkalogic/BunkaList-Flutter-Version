
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStarted extends SearchEvent {
  final String query;

  const SearchStarted(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() {
    return 'SearchStarted { query: $query }';
  }
}

class SearchPageRequested extends SearchEvent {
  final int page;

  const SearchPageRequested(this.page);

  @override
  List<Object> get props => [page];

  @override
  String toString() {
    return 'SearchPageRequested { page: $page }';
  }
}

class SearchCleared extends SearchEvent {}



