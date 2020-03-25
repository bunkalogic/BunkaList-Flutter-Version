import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/movie_details_rs_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_rs_entity.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:meta/meta.dart';

class FirebaseFillOuevreObject{

  final Object ouevre;
  final String type;
  final int typeObject;
  final int status;

  FirebaseFillOuevreObject({
    @required this.ouevre,
    @required this.type,
    @required this.status,
    @required this.typeObject
  });

  OuevreEntity detectTypeObjectAndFill(){
    //? Todos los tipos de object a rellenar
    MovieEntity movie;
    SeriesEntity serie;
    AnimeEntity anime;
    AnimeDetailsEntity animeDetailsEntity;
    MovieDetailsEntity movieDetailsEntity;
    SerieDetailsEntity serieDetailsEntity;
    MovieEntityRS movieEntityRS;
    SeriesEntityRS seriesEntityRS;
    AnimeEntityRS animeEntityRS;
    Result result;
    OuevreEntity ouevreEntity;

    switch (typeObject) {
      case ConstantsTypeObject.movieEntity:{
        movie = ouevre as MovieEntity;
        return _fillObjectOuevreOfMovie(movie);
      }

      case ConstantsTypeObject.serieEntity:{
        serie = ouevre as SeriesEntity;
        return _fillObjectOuevreOfSerie(serie);
      }

      case ConstantsTypeObject.animeEntity: {
        anime = ouevre as AnimeEntity;
        return _fillObjectOuevreOfAnime(anime);
      }

      case ConstantsTypeObject.movieEntityRS:{
        movieEntityRS = ouevre as MovieEntityRS;
        return _fillObjectOuevreOfMovieRS(movieEntityRS);
      }

      case ConstantsTypeObject.serieEntityRS:{
        seriesEntityRS = ouevre as SeriesEntityRS;
        return _fillObjectOuevreOfSerieRS(seriesEntityRS);
      }

      case ConstantsTypeObject.animeEntityRS: {
        animeEntityRS = ouevre as AnimeEntityRS;
        return _fillObjectOuevreOfAnimeRS(animeEntityRS);
      } 

      case ConstantsTypeObject.movieDetailsEntity:{
        movieDetailsEntity = ouevre as MovieDetailsEntity;
        return _fillObjectOuevreOfMovieDetails(movieDetailsEntity);
      }

      case ConstantsTypeObject.serieDetailsEntity:{
        serieDetailsEntity = ouevre as SerieDetailsEntity;
        return _fillObjectOuevreOfSerieDetails(serieDetailsEntity);
      }

      case ConstantsTypeObject.animeDetailsEntity: {
        animeDetailsEntity = ouevre as AnimeDetailsEntity;
        return _fillObjectOuevreOfAnimeDetails(animeDetailsEntity);
      }

      case ConstantsTypeObject.searchResult:{
        result = ouevre as Result;
        return _fillObjectOuevreOfSearchResult(result);
      }
      
      case ConstantsTypeObject.ouevreEntity: {
        ouevreEntity = ouevre as OuevreEntity;

        return _fillObjectOuevreOfOldOuevre(ouevreEntity);
      }

        
      default: return _fillObjectOuevreOfOldOuevre(ouevreEntity);
    }

  }

  OuevreEntity _fillObjectOuevreOfMovie(MovieEntity movie){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: movie.id,
     oeuvreTitle: movie.title,
     oeuvrePoster: (movie.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ movie.backdropPath }' : 'https://image.tmdb.org/t/p/original${ movie.posterPath }',
     oeuvreRating: movie.voteAverage,
     oeuvreReleaseDate: movie.releaseDate,
     oeuvreType: movie.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfSerie(SeriesEntity serie){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: serie.id ,
     oeuvreTitle: serie.name,
     oeuvrePoster: (serie.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ serie.backdropPath }' : 'https://image.tmdb.org/t/p/original${ serie.posterPath }',
     oeuvreRating: serie.voteAverage,
     oeuvreReleaseDate: serie.firstAirDate,
     oeuvreType: serie.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfAnime(AnimeEntity anime){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: anime.id,
     oeuvreTitle: anime.name,
     oeuvrePoster: (anime.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ anime.backdropPath }' : 'https://image.tmdb.org/t/p/original${ anime.posterPath }',
     oeuvreRating: anime.voteAverage,
     oeuvreReleaseDate: anime.firstAirDate,
     oeuvreType:  anime.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }


  OuevreEntity _fillObjectOuevreOfMovieRS(MovieEntityRS movie){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: movie.id,
     oeuvreTitle: movie.title,
     oeuvrePoster: (movie.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ movie.backdropPath }' : 'https://image.tmdb.org/t/p/original${ movie.posterPath }',
     oeuvreRating: movie.voteAverage,
     oeuvreReleaseDate: movie.releaseDate,
     oeuvreType: movie.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfSerieRS(SeriesEntityRS serie){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: serie.id ,
     oeuvreTitle: serie.name,
     oeuvrePoster: (serie.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ serie.backdropPath }' : 'https://image.tmdb.org/t/p/original${ serie.posterPath }',
     oeuvreRating: serie.voteAverage,
     oeuvreReleaseDate: serie.firstAirDate,
     oeuvreType: serie.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfAnimeRS(AnimeEntityRS anime){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: anime.id,
     oeuvreTitle: anime.name,
     oeuvrePoster: (anime.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ anime.backdropPath }' : 'https://image.tmdb.org/t/p/original${ anime.posterPath }',
     oeuvreRating: anime.voteAverage,
     oeuvreReleaseDate: anime.firstAirDate,
     oeuvreType:  anime.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }


  OuevreEntity _fillObjectOuevreOfMovieDetails(MovieDetailsEntity movie){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: movie.id,
     oeuvreTitle: movie.title,
     oeuvrePoster: (movie.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ movie.backdropPath }' : 'https://image.tmdb.org/t/p/original${ movie.posterPath }',
     oeuvreRating: movie.voteAverage,
     oeuvreReleaseDate: movie.releaseDate,
     oeuvreType: movie.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfSerieDetails(SerieDetailsEntity serie){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: serie.id ,
     oeuvreTitle: serie.name,
     oeuvrePoster: (serie.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ serie.backdropPath }' : 'https://image.tmdb.org/t/p/original${ serie.posterPath }',
     oeuvreRating: serie.voteAverage,
     oeuvreReleaseDate: serie.firstAirDate,
     oeuvreType: serie.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfAnimeDetails(AnimeDetailsEntity anime){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: anime.id,
     oeuvreTitle: anime.name,
     oeuvrePoster: (anime.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ anime.backdropPath }' : 'https://image.tmdb.org/t/p/original${ anime.posterPath }',
     oeuvreRating: anime.voteAverage,
     oeuvreReleaseDate: anime.firstAirDate,
     oeuvreType:  anime.type,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfSearchResult(Result result){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: result.id,
     oeuvreTitle: (result.title != null) ? result.title : result.name,
     oeuvrePoster: (result.backdropPath != null) ? 'https://image.tmdb.org/t/p/original${ result.backdropPath }' : 'https://image.tmdb.org/t/p/original${ result.posterPath }',
     oeuvreRating: result.voteAverage,
     oeuvreReleaseDate: (result.releaseDate != null) ? result.releaseDate : result.firstAirDate,
     oeuvreType: result.mediaType,
     addDate: DateTime.now(),
     status: status,
    );

    return ouevreEntity;
  }

  OuevreEntity _fillObjectOuevreOfOldOuevre(OuevreEntity oldOuevre){
    final ouevreEntity = new OuevreEntity(
     oeuvreId: oldOuevre.oeuvreId,
     oeuvreTitle: oldOuevre.oeuvreTitle,
     oeuvrePoster: oldOuevre.oeuvrePoster,
     oeuvreRating: oldOuevre.oeuvreRating,
     oeuvreReleaseDate: oldOuevre.oeuvreReleaseDate,
     oeuvreType: oldOuevre.oeuvreType,
     addDate: oldOuevre.addDate,
     status: status,
     episodes: oldOuevre.episodes,
     seasons: oldOuevre.seasons
    );

    return ouevreEntity;
  }
  
}