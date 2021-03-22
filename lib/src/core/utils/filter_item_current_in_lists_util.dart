import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/home_tops/data/models/anime_model.dart';
import 'package:bunkalist/src/features/home_tops/data/models/movie_model.dart';
import 'package:bunkalist/src/features/home_tops/data/models/series_model.dart';


List<MovieModel> filterMovieCurrentInList(List<MovieModel> movies){

  Preferences prefs = Preferences();

  List<String> listMoviesIds = prefs.listMoviesIds;
  
  List<MovieModel> listMoviesFilter = [];
  
  if(listMoviesIds.isEmpty) return movies;



  movies.forEach((element) { 

        bool isInTheList = listMoviesIds.contains(element.id.toString());

        if(isInTheList == false){
          listMoviesFilter.add(element);
        }

  });

  print('item movie total no watched: ${listMoviesFilter.length}');


  return listMoviesFilter;





}


List<SeriesModel> filterSerieCurrentInList(List<SeriesModel> series){

  Preferences prefs = Preferences();

  List<String> listSeriesIds = prefs.listSerieIds;
  
  List<SeriesModel> listSerieFilter = [];
  
  if(listSeriesIds.isEmpty) return series;



  series.forEach((element) { 

        bool isInTheList = listSeriesIds.contains(element.id.toString());

        if(isInTheList == false){
          listSerieFilter.add(element);
        }

  });

  print('item serie total no watched: ${listSerieFilter.length}');


  return listSerieFilter;

}


List<AnimeModel> filterAnimeCurrentInList(List<AnimeModel> animes){

  Preferences prefs = Preferences();

  List<String> listAnimeIds = prefs.listAnimeIds;
  
  List<AnimeModel> listAnimeFilter = [];
  
  if(listAnimeIds.isEmpty) return animes;



  animes.forEach((element) { 

        bool isInTheList = listAnimeIds.contains(element.id.toString());

        if(isInTheList == false){
          listAnimeFilter.add(element);
        }

  });

  print('item anime total no watched: ${listAnimeFilter.length}');


  return listAnimeFilter;

}