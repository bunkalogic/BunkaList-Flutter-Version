import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SimilarState extends Equatable {
  const SimilarState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends SimilarState{}

class Loading extends SimilarState{}

class LoadedMovie extends SimilarState{
  final List<MovieEntityRS> movie;
  LoadedMovie({@required this.movie }) : super([movie]);
}

class LoadedSerie extends SimilarState{
  final List<SeriesEntityRS> serie;
  LoadedSerie({@required this.serie }) : super([serie]);
}

class LoadedAnime extends SimilarState{
  final List<AnimeEntityRS> anime;
  LoadedAnime({@required this.anime }) : super([anime]);
}

class Error extends SimilarState{
  final String message;
  Error({@required this.message}) : super ([message]);
}

