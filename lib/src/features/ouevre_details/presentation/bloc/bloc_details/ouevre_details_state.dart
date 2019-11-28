import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OuevreDetailsState extends Equatable {
  OuevreDetailsState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends OuevreDetailsState{}

class Loading extends OuevreDetailsState{}

class LoadedMovie extends OuevreDetailsState{
  final MovieDetailsEntity movie;
  LoadedMovie({@required this.movie }) : super([movie]);
}

class LoadedSerie extends OuevreDetailsState{
  final SerieDetailsEntity serie;
  LoadedSerie({@required this.serie }) : super([serie]);
}

class LoadedAnime extends OuevreDetailsState{
  final AnimeDetailsEntity anime;
  LoadedAnime({@required this.anime }) : super([anime]);
}

class Error extends OuevreDetailsState{
  final String message;
  Error({@required this.message}) : super ([message]);
}

