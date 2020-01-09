import 'dart:async';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart'        as paramsAS;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_similar.dart'        as paramsMS;   
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_similar.dart'        as paramsSS;
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class SimilarBloc extends Bloc<SimilarEvent, SimilarState> {
  
  //? Instantiating the Usescases
  final GetMoviesSimilar getMoviesSimilar;
  final GetSeriesSimilar getSeriesSimilar;
  final GetAnimeSimilar getAnimeSimilar;

  SimilarBloc({
  @required GetMoviesSimilar        moviesSimilar,
  @required GetSeriesSimilar        seriesSimilar,
  @required GetAnimeSimilar         animeSimilar,
  }) :  assert(moviesSimilar != null),
        assert(seriesSimilar != null),
        assert(animeSimilar  != null),
    getMoviesSimilar        = moviesSimilar,
    getSeriesSimilar        = seriesSimilar,
    getAnimeSimilar         = animeSimilar; 

  
  @override
  SimilarState get initialState => Empty();

  @override
  Stream<SimilarState> mapEventToState(
    SimilarEvent event,
  ) async* {
    if(event is GetSimilar){

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
