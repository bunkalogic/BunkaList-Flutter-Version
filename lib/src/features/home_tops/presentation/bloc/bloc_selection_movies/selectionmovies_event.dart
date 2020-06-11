part of 'selectionmovies_bloc.dart';

abstract class SelectionmoviesEvent extends Equatable {
  const SelectionmoviesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetSelectionMovies extends SelectionmoviesEvent {
  final int topId;
  final int page;
  GetSelectionMovies(this.topId, this.page) : super([topId, page]);
}
