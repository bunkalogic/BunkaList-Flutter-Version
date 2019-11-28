import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart'  as movieParams;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart'  as animeParams;
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart' as serieParams;
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';


class OuevreDetailsBloc extends Bloc<OuevreDetailsEvent, OuevreDetailsState> {
  
  final GetMovieDetails getMovieDetails;
  final GetSerieDetails getSerieDetails;
  final GetAnimeDetails getAnimeDetails;

  OuevreDetailsBloc({ 
    @required GetMovieDetails movie,
    @required GetSerieDetails serie,
    @required GetAnimeDetails anime, 
   }) : assert(movie != null),
        assert(serie != null),
        assert(anime != null),
   getMovieDetails = movie,
   getSerieDetails = serie,
   getAnimeDetails = anime;
  
  
  
  @override
  OuevreDetailsState get initialState => Empty();

  @override
  Stream<OuevreDetailsState> mapEventToState(
    OuevreDetailsEvent event,
  ) async* {
    if(event is GetDetailsOuevre){
      switch(event.type){
        case 'movie': {

          final inputEither = GetTopId().getValidateTopId(event.id);
          yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrMovie = await getMovieDetails(movieParams.Params(movieId: id));

              yield failureOrMovie.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (movie)  => LoadedMovie(movie: movie)
              );

            }
          );

        }
          break;

        case 'tv': {

          final inputEither = GetTopId().getValidateTopId(event.id);
          yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrSerie = await getSerieDetails(serieParams.Params(serieId: id));

              yield failureOrSerie.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (serie)  => LoadedSerie(serie: serie)
              );

            }
          );
          
        }
          break;

        case 'anime': {

          final inputEither = GetTopId().getValidateTopId(event.id);
          yield* inputEither.fold(
            (failures) async*{

              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE );

            }, (id) async*{

              yield Loading();

              final failureOrAnime = await getAnimeDetails(animeParams.Params(animeId: id));

              yield failureOrAnime.fold(
                (failure) => Error(message: _mapFailureToMessage(failure)), 
                (anime)  => LoadedAnime(anime: anime)
              );

            }
          );
          
        }
        break;
      }
    }
    
    
    
    // if(event is GetDetailsMovie){

    //   final inputEither = GetTopId().getValidateTopId(event.id);
    //   //!Add the logic

    // }else if(event is GetDetailsSerie){

    //   final inputEither = GetTopId().getValidateTopId(event.id);
    //   //!Add the logic

    // }else if(event is GetDetailsAnime){

    //   final inputEither = GetTopId().getValidateTopId(event.id);
    //   //!Add the logic

    // }
    

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
