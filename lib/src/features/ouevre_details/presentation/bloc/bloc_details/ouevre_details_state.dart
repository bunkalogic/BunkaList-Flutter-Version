import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/keywords_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OuevreDetailsState extends Equatable {
  OuevreDetailsState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends OuevreDetailsState{}

class Loading extends OuevreDetailsState{}

class LoadedMovie extends OuevreDetailsState{
  final MovieDetailsEntity movie;
  

  LoadedMovie({
    @required this.movie, 
    }) 
    : super([
      movie,
      ]);
}

class LoadedSerie extends OuevreDetailsState{
  final SerieDetailsEntity serie;

  LoadedSerie({
    @required this.serie,
  }) : super([
    serie, 
  ]);
}

class LoadedAnime extends OuevreDetailsState{
  final AnimeDetailsEntity anime;

  LoadedAnime({
    @required this.anime, 
    }) : super([
    anime,
    ]);
}

class LoadedKeywords extends OuevreDetailsState{
  final Keywords keywords;

  LoadedKeywords({
    @required this.keywords,
  }) : super([
    keywords
  ]);
}

class LoadedImages extends OuevreDetailsState{
  final PosterImages posterImages;

  LoadedImages({
    @required this.posterImages,
  }) : super([
    posterImages
  ]);
}

class LoadedWatchProvider extends OuevreDetailsState{
  final WatchProvider watchProvider;

  LoadedWatchProvider({
    @required this.watchProvider,
  }) : super([
    watchProvider 
  ]);
}

class Error extends OuevreDetailsState{
  final String message;
  Error({@required this.message}) : super ([message]);
}

