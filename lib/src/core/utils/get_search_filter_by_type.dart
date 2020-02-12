

import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';

List<Result> getSearchResultsByType(List<Result> listResults,String mediaType){

  switch (mediaType) {
    case 'movie': return _getResultsMovies(listResults);
      
    case 'tv': return _getResultsSeries(listResults);

    case 'anime': return _getResultsAnimes(listResults);

    case 'person': return _getResultsPeople(listResults);

    default: return listResults;  
  }

                

}


List<Result> _getResultsMovies(List<Result> listResults){

  print(listResults.length);
  List<Result> moviesFinal = new List();

  for(Result movie in listResults){
    List<Result> movies = new List();
    if(movie.mediaType == 'movie'){
      movies.add(movie);
    }
    moviesFinal.addAll(movies);
  }

  return moviesFinal; 
}

List<Result> _getResultsSeries(List<Result> listResults){

  List<Result> serieFinal = new List();

  for(Result serie in listResults){
      List<Result> series = new List();
      if(serie.mediaType == 'tv'){
        series.add(serie);
      }
      serieFinal.addAll(series);
  }

  return serieFinal;
}

List<Result> _getResultsAnimes(List<Result> listResults){
  List<Result> animeFinal = new List();

  for(Result anime in listResults){
    List<Result> animes = new List();
    if(anime.mediaType == 'anime'){
      animes.add(anime);
    }
    animeFinal.addAll(animes);
  }

  return animeFinal;

}

List<Result> _getResultsPeople(List<Result> listResults){
  List<Result> personFinal = new List();

  for(Result person in listResults){
    List<Result> people = new List();
    if(person.mediaType == 'person'){
      people.add(person);
    }
    personFinal.addAll(people);
  }

  return personFinal;
}

