import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RecomAndSimilarState extends Equatable {
  RecomAndSimilarState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends RecomAndSimilarState{}

class Loading extends RecomAndSimilarState{}

class LoadedMovie extends RecomAndSimilarState{
  final List<MovieEntityRS> movie;
  LoadedMovie({@required this.movie }) : super([movie]);
}

class LoadedSerie extends RecomAndSimilarState{
  final List<SeriesEntityRS> serie;
  LoadedSerie({@required this.serie }) : super([serie]);
}

class LoadedAnime extends RecomAndSimilarState{
  final List<AnimeEntityRS> anime;
  LoadedAnime({@required this.anime }) : super([anime]);
}

class Error extends RecomAndSimilarState{
  final String message;
  Error({@required this.message}) : super ([message]);
}
