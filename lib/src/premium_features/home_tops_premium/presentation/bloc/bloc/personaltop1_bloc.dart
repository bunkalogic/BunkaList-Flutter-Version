import 'dart:async';

import 'package:bunkalist/src/core/constans/constans_sort_by.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_tops_id.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/data/models/movie_details_rs_model.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/usescases/get_personal_top_anime.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/usescases/get_personal_top_movies.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/usescases/get_personal_top_series.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';


part 'personaltop1_event.dart';
part 'personaltop1_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Personal Top ';

class Personaltop1Bloc extends Bloc<Personaltop1Event, Personaltop1State> {
  
  final GetPersonalTopsMovies getPersonalTopsMovies;
  final GetPersonalTopsSeries getPersonalTopsSeries;
  final GetPersonalTopsAnime getPersonalTopsAnime;
  
  Personaltop1Bloc({
    @required GetPersonalTopsMovies personalTopsMovies,
    @required GetPersonalTopsSeries personalTopsSeries,
    @required GetPersonalTopsAnime personalTopsAnime
  })
  : assert(personalTopsMovies != null),
    assert(personalTopsSeries != null),
    assert(personalTopsAnime != null),
    getPersonalTopsMovies = personalTopsMovies,
    getPersonalTopsSeries = personalTopsSeries,
    getPersonalTopsAnime = personalTopsAnime;

  @override
  Personaltop1State get initialState => Personaltop1Initial();


  


  @override
  Stream<Transition<Personaltop1Event, Personaltop1State>>  transformEvents(
    Stream<Personaltop1Event> events, 
    Stream<Transition<Personaltop1Event, Personaltop1State>>  Function(Personaltop1Event event) transitionFn) {
    
    return events
    .debounceTime(const Duration(milliseconds: 300))
    .switchMap(transitionFn);
    
    // return super.transformEvents( 
    //   (events as Observable<Personaltop1Event>).debounceTime(
    //     Duration(milliseconds: 500),
    //   ), 
    //   next
    // );
  }

 

  @override
  Stream<Personaltop1State> mapEventToState(
    Personaltop1Event event,
  ) async* {
    
    final currentState = state;

    if(event is GetPersonalTop1){


      if(event.filterParams.type == 'movie' && !_hasReachedMaxMovies(currentState) ){

        final inputEither = GetTopId().getValidateTopId(event.page);

      if(currentState is Personaltop1Initial){
        yield* inputEither.fold(
          (failures) async* {
            yield ErrorPersonaltop1(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          
          final failureOrMovies = await getPersonalTopsMovies(MovieParams( 
            page: page,
            genre: event.filterParams.genre,
            sortBy: event.filterParams.sortBy,
            voteCountGte: event.filterParams.voteCountGte,
            withKeywords: event.filterParams.withKeywords,
            year: event.filterParams.year,
            withOriginalLanguage: event.filterParams.withOriginalLanguage

          ));
          
          yield* _eitherLoadedMovieOrErrorState(failureOrMovies, event.filterParams);
          return; 
        });
      }
       


        if(currentState is Personaltop1LoadedMovies){
        final inputEither = GetTopId().getValidateTopId(event.page);


       yield* inputEither.fold(
          (failures) async* {
            yield ErrorPersonaltop1(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {

          final failureOrMovie = await getPersonalTopsMovies(MovieParams( 
            page: page,
            genre: event.filterParams.genre,
            sortBy: event.filterParams.sortBy,
            voteCountGte: event.filterParams.voteCountGte,
            withKeywords: event.filterParams.withKeywords,
            year: event.filterParams.year,
            withOriginalLanguage: event.filterParams.withOriginalLanguage

          ));
          
           yield failureOrMovie.fold(
            (failure) => ErrorPersonaltop1(message: _mapFailureToMessage(failure)), 
            (movies)  {

              if (movies.isEmpty) {
                return currentState.copyWith(
                  hasReachedMax: true, 
                  latestPage: event.page,
                  filterParams: event.filterParams
                );
              } else {

                 final allMovies = currentState.movies + movies;

        
                return Personaltop1LoadedMovies(
                  movies: (currentState.filterParams == event.filterParams) 
                  ? allMovies
                  : movies, 
                  hasReachedMax: false, 
                  latestPage: event.page,
                  filterParams: event.filterParams
                );

              }
            });

          
        });


      }



      }else if(event.filterParams.type == 'tv' && !_hasReachedMaxSeries(currentState) ){


        final inputEither = GetTopId().getValidateTopId(event.page);

      if(currentState is Personaltop1Initial){
        yield* inputEither.fold(
          (failures) async* {
            yield ErrorPersonaltop1(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          
          final failureOrSeries = await getPersonalTopsSeries(SerieParams( 
            page: page,
            genre: event.filterParams.genre,
            sortBy: event.filterParams.sortBy,
            voteCountGte: event.filterParams.voteCountGte,
            withKeywords: event.filterParams.withKeywords,
            withNetwork: event.filterParams.withNetwork,
            year: event.filterParams.year,
            withOriginalLanguage: event.filterParams.withOriginalLanguage

          ));
          
          yield* _eitherLoadedSerieOrErrorState(failureOrSeries, event.filterParams);
          return; 
        });
      }
       


        if(currentState is Personaltop1LoadedSeries){
        final inputEither = GetTopId().getValidateTopId(event.page);


       yield* inputEither.fold(
          (failures) async* {
            yield ErrorPersonaltop1(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {

          final failureOrSeries = await getPersonalTopsSeries(SerieParams( 
            page: page,
            genre: event.filterParams.genre,
            sortBy: event.filterParams.sortBy,
            voteCountGte: event.filterParams.voteCountGte,
            withKeywords: event.filterParams.withKeywords,
            withNetwork: event.filterParams.withNetwork,
            year: event.filterParams.year,
            withOriginalLanguage: event.filterParams.withOriginalLanguage

          ));
          
           yield failureOrSeries.fold(
            (failure) => ErrorPersonaltop1(message: _mapFailureToMessage(failure)), 
            (series)  {

              if (series.isEmpty) {
                return currentState.copyWith(
                  hasReachedMax: true, 
                  latestPage: event.page,
                  filterParams: event.filterParams
                );
              } else {

                 final allSeries = currentState.series + series;

        
                return Personaltop1LoadedSeries(
                  series: (currentState.filterParams == event.filterParams) 
                  ? allSeries
                  : series, 
                  hasReachedMax: false, 
                  latestPage: event.page,
                  filterParams: event.filterParams
                  
                );

              }
            });

          
        });


      }



      }else if(event.filterParams.type == 'anime' && !_hasReachedMaxAnimes(currentState) ){

      final inputEither = GetTopId().getValidateTopId(event.page);

      if(currentState is Personaltop1Initial){
        yield* inputEither.fold(
          (failures) async* {
            yield ErrorPersonaltop1(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingAnimes();
          final failureOrAnimes = await getPersonalTopsAnime(AnimeParams( 
            page: page,
            genre: event.filterParams.genre,
            sortBy: event.filterParams.sortBy,
            voteCountGte: event.filterParams.voteCountGte,
            withKeywords: event.filterParams.withKeywords,
            withNetwork: event.filterParams.withNetwork,
            year: event.filterParams.year

          ));
          
          yield* _eitherLoadedAnimeOrErrorState(failureOrAnimes, event.filterParams);
          return; 
        });
      }
       


        if(currentState is Personaltop1LoadedAnimes){
        final inputEither = GetTopId().getValidateTopId(event.page);


       yield* inputEither.fold(
          (failures) async* {
            yield ErrorPersonaltop1(message: INVALID_INPUT_FAILURE_MESSAGE );

          },(page) async* {
          //yield LoadingAnimes();
          final failureOrAnimes = await getPersonalTopsAnime(AnimeParams( 
            page: page,
            genre: event.filterParams.genre,
            sortBy: event.filterParams.sortBy,
            voteCountGte: event.filterParams.voteCountGte,
            withKeywords: event.filterParams.withKeywords,
            withNetwork: event.filterParams.withNetwork,
            year: event.filterParams.year

          ));
          
           yield failureOrAnimes.fold(
            (failure) => ErrorPersonaltop1(message: _mapFailureToMessage(failure)), 
            (animes)  {

              if (animes.isEmpty) {
                return currentState.copyWith(
                  hasReachedMax: true, 
                  latestPage: event.page,
                  filterParams: event.filterParams
                );
              } else {

                 final allAnimes = currentState.animes + animes;

        
                return Personaltop1LoadedAnimes(
                  animes: (currentState.filterParams == event.filterParams) 
                  ? allAnimes
                  : animes, 
                  hasReachedMax: false, 
                  latestPage: event.page,
                  filterParams: event.filterParams
                );

              }
            });

          
        });


      }


      }


    }



  }



  Stream<Personaltop1State> _eitherLoadedMovieOrErrorState
  (Either<Failures, List<MovieEntity>> either, FilterParams filterParams) async* {
    yield either.fold(
      (failure) => ErrorPersonaltop1(message: _mapFailureToMessage(failure)), 
      (movies)  => Personaltop1LoadedMovies(movies: movies, hasReachedMax: false, latestPage: 1, filterParams: filterParams )
    );
  }

  Stream<Personaltop1State> _eitherLoadedSerieOrErrorState
  (Either<Failures, List<SeriesEntity>> either, FilterParams filterParams) async* {
    yield either.fold(
      (failure) => ErrorPersonaltop1(message: _mapFailureToMessage(failure)), 
      (series)  => Personaltop1LoadedSeries(series: series, hasReachedMax: false, latestPage: 1, filterParams: filterParams)
    );
  }



  Stream<Personaltop1State> _eitherLoadedAnimeOrErrorState
  (Either<Failures, List<AnimeEntity>> either, FilterParams filterParams) async* {
    yield either.fold(
      (failure) => ErrorPersonaltop1(message: _mapFailureToMessage(failure)), 
      (animes)  => Personaltop1LoadedAnimes(animes: animes, hasReachedMax: false, latestPage: 1, filterParams: filterParams )
    );
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


  bool _hasReachedMaxMovies(Personaltop1State state) =>
      state is Personaltop1LoadedMovies && state.hasReachedMax;

  bool _hasReachedMaxSeries(Personaltop1State state) =>
      state is Personaltop1LoadedSeries && state.hasReachedMax;

  bool _hasReachedMaxAnimes(Personaltop1State state) =>
      state is Personaltop1LoadedAnimes && state.hasReachedMax;

}
