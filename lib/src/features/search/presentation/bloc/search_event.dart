
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{
  const SearchEvent();
}

class TextSearchChanged extends SearchEvent {
  final String text;

  const TextSearchChanged({this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextSearchChanged { text: $text }';
}



