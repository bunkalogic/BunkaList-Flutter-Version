part of 'selectionanimes_bloc.dart';

abstract class SelectionanimesEvent extends Equatable {
  const SelectionanimesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetSelectionAnime extends SelectionanimesEvent {
  final int topId;
  final int page;
  GetSelectionAnime(this.topId, this.page) : super([topId, page]);
}
