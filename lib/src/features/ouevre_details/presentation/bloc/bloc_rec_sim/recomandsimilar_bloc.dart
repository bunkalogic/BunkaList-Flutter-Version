import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_recommedation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_recommendations.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart' as paramsAR;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart'        as paramsAS;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_recommedation.dart'  as paramsMR;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_similar.dart'        as paramsMS;   
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_recommendations.dart'as paramsSR;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_similar.dart'        as paramsSS;
import './bloc.dart';
import 'package:meta/meta.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class RecomAndSimilarBloc extends Bloc<RecomAndSimilarEvent, RecomAndSimilarState> {
  
  //? Instantiating the Usescases
  final GetMoviesRecommedations getMoviesRecommedations;
  final GetMoviesSimilar getMoviesSimilar;
  
  final GetSeriesRecommedations getSeriesRecommedations;
  final GetSeriesSimilar getSeriesSimilar;

  final GetAnimeRecommendation getAnimeRecommendation;
  final GetAnimeSimilar getAnimeSimilar;

  
  RecomAndSimilarBloc({
  @required GetMoviesRecommedations moviesRecom,
  @required GetMoviesSimilar        moviesSimilar,
  @required GetSeriesRecommedations seriesRecom,
  @required GetSeriesSimilar        seriesSimilar,
  @required GetAnimeRecommendation  animeRecom,
  @required GetAnimeSimilar         animeSimilar,
  }) :  assert(moviesRecom   != null),
        assert(moviesSimilar != null),
        assert(seriesRecom   != null),
        assert(seriesSimilar != null),
        assert(animeRecom    != null),
        assert(animeSimilar  != null),
    getMoviesRecommedations = moviesRecom,
    getMoviesSimilar        = moviesSimilar,
    getSeriesRecommedations = seriesRecom,
    getSeriesSimilar        = seriesSimilar,
    getAnimeRecommendation  = animeRecom,
    getAnimeSimilar         = animeSimilar;    



  
  @override
  RecomAndSimilarState get initialState => Empty();

  @override
  Stream<RecomAndSimilarState> mapEventToState(
    RecomAndSimilarEvent event,
  ) async* {
    if(event is GetRecommendations){

      switch(event.type){
        
        case 'movie':{
          final inputEither = GetTopId().getValidateTopId(event.id);

           yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrMovie = await getMoviesRecommedations(paramsMR.Params(id: id));

              yield failureOrMovie.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (movies)  => LoadedMovie(movie: movies)
              );

            }
          );
        } 
          break;

        case 'tv':{
          final inputEither = GetTopId().getValidateTopId(event.id);

           yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrSerie = await getSeriesRecommedations(paramsSR.Params(id: id));

              yield failureOrSerie.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (series)  => LoadedSerie(serie: series)
              );

            }
          );

        }
          break;

        case 'anime':{
          final inputEither = GetTopId().getValidateTopId(event.id);

           yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrAnime = await getAnimeRecommendation(paramsAR.Params(id: id));

              yield failureOrAnime.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (animes)  => LoadedAnime(anime: animes)
              );

            }
          );

        } 
          break;
      }

    }else if(event is GetSimilar){

      switch(event.type){
        
        case 'movie':{
          final inputEither = GetTopId().getValidateTopId(event.id);

           yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrMovie = await getMoviesSimilar(paramsMS.Params(id: id));

              yield failureOrMovie.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (movies)  => LoadedMovie(movie: movies)
              );

            }
          );
        } 
          break;

        case 'tv':{
          final inputEither = GetTopId().getValidateTopId(event.id);

           yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrSerie = await getSeriesSimilar(paramsSS.Params(id: id));

              yield failureOrSerie.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (series)  => LoadedSerie(serie: series)
              );

            }
          );


        } 
          break;

        case 'anime':{
          final inputEither = GetTopId().getValidateTopId(event.id);

           yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrAnime = await getAnimeSimilar(paramsAS.Params(id: id));

              yield failureOrAnime.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (animes)  => LoadedAnime(anime: animes)
              );

            }
          );
        } 
          break;
      }

    }
  }

  String _mapFailureToMessage(Failures failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
