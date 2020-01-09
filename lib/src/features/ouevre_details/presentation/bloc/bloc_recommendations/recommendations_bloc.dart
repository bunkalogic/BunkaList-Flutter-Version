import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_recommedation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_recommendations.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart' as paramsAR;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_recommedation.dart'  as paramsMR;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_recommendations.dart'as paramsSR;
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class RecommendationsBloc extends Bloc<RecommendationsEvent, RecommendationsState> {
  
  //? Instantiating the Usescases
  final GetMoviesRecommedations getMoviesRecommedations;
  final GetSeriesRecommedations getSeriesRecommedations;
  final GetAnimeRecommendation getAnimeRecommendation;

  RecommendationsBloc({
  @required GetMoviesRecommedations moviesRecom,
  @required GetSeriesRecommedations seriesRecom,
  @required GetAnimeRecommendation  animeRecom,
  }) :  assert(moviesRecom   != null),
        assert(seriesRecom   != null),
        assert(animeRecom    != null),
    getMoviesRecommedations = moviesRecom,
    getSeriesRecommedations = seriesRecom,
    getAnimeRecommendation  = animeRecom;
  
  @override
  RecommendationsState get initialState => Empty();

  @override
  Stream<RecommendationsState> mapEventToState(
    RecommendationsEvent event,
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
