import 'dart:async';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_validate_query.dart';
import 'package:bunkalist/src/features/search/domain/usescases/get_search.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Id';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  
  final GetSearch getSearch;

  SearchBloc({
    @required GetSearch search
  })
    : assert(search != null),
    getSearch = search;
  
  @override
  SearchState get initialState => Empty();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is GetResults){
      final inputEither = GetValidateQuery().getValidateQuery(event.query);

      yield* inputEither.fold(
        (failures) async* {

          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);

        }, (query) async*{

          yield Loading();

          final failureOrResults = await getSearch(Params(query: query));

          failureOrResults.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)), 
            (results){

                final List<Result> listResults = new List<Result>.from(results.results);

                 List<Result> moviesFinal = new List();
                 List<Result> serieFinal = new List();
                 List<Result> animeFinal = new List();
                 List<Result> personFinal = new List();

                

                for(Result movie in listResults){
                    List<Result> movies = new List();
                    if(movie.mediaType == 'movie'){
                      movies.add(movie);
                    }
                    moviesFinal.addAll(movies);
                }

                LoadedMovie(results: moviesFinal);

                for(Result serie in listResults){
                    List<Result> series = new List();
                    if(serie.mediaType == 'tv'){
                      series.add(serie);
                    }
                    serieFinal.addAll(series);
                }

                LoadedSerie(results: serieFinal);

                for(Result anime in listResults){
                    List<Result> animes = new List();
                    if(anime.mediaType == 'anime'){
                      animes.add(anime);
                    }
                    animeFinal.addAll(animes);
                }

                LoadedAnime(results: animeFinal);

                for(Result person in listResults){
                    List<Result> people = new List();
                    if(person.mediaType == 'person'){
                      people.add(person);
                    }
                    personFinal.addAll(people);
                }

                LoadedPerson(results: personFinal);
            });

        });
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
