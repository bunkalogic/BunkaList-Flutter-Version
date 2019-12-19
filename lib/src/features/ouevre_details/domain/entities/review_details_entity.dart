import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ReviewEntity extends Equatable {
    final String author;
    final String content;
    final String id;
    final String url;

    ReviewEntity({
        @required this.author,
        @required this.content,
        @required this.id,
        @required this.url,
    }) : super([
      author,
      content,
      id,
      url
    ]);
}