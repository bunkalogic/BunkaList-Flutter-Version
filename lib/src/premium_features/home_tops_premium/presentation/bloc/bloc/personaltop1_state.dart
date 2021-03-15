part of 'personaltop1_bloc.dart';

abstract class Personaltop1State extends Equatable {
  const Personaltop1State([List props = const []]) : super(props);
  
}

class Personaltop1Initial extends Personaltop1State {}


class Personaltop1Loading extends Personaltop1State {}


class Personaltop1LoadedMovies extends Personaltop1State{
  final List<MovieEntity> movies;
  final FilterParams filterParams;
  final int latestPage;
  final bool hasReachedMax;

     Personaltop1LoadedMovies({
    this.movies,
    this.hasReachedMax,
    this.filterParams,
    this.latestPage

  }): super([movies, hasReachedMax, latestPage, filterParams]);

  Personaltop1LoadedMovies copyWith({
    List<MovieEntity> movies,
    bool hasReachedMax,
    FilterParams filterParams,
    int latestPage
  }) {
    return Personaltop1LoadedMovies(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filterParams: filterParams,
      latestPage: latestPage
    );
  }  
}


class Personaltop1LoadedSeries extends Personaltop1State{
  final List<SeriesEntity> series;
  final bool hasReachedMax;
  final int latestPage;
  final FilterParams filterParams;

     Personaltop1LoadedSeries({
    this.series,
    this.hasReachedMax,
    this.filterParams,
    this.latestPage
  }): super([series, hasReachedMax, filterParams, latestPage]);

  Personaltop1LoadedSeries copyWith({
    List<SeriesEntity> series,
    bool hasReachedMax,
    FilterParams filterParams,
    int latestPage
  }) {
    return Personaltop1LoadedSeries(
      series: series ?? this.series,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filterParams: filterParams,
      latestPage: latestPage
    );
  }  
}


class Personaltop1LoadedAnimes extends Personaltop1State{
  final List<AnimeEntity> animes;
  final bool hasReachedMax;
  final int latestPage;
  final FilterParams filterParams;

     Personaltop1LoadedAnimes({
    this.animes,
    this.hasReachedMax,
    this.latestPage,
    this.filterParams
  }): super([animes, hasReachedMax, latestPage, filterParams]);

  Personaltop1LoadedAnimes copyWith({
    List<AnimeEntity> animes,
    bool hasReachedMax,
    int latestPage,
    FilterParams filterParams,
  }) {
    return Personaltop1LoadedAnimes(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: latestPage,
      filterParams: filterParams
    );
  }  
}




class ErrorPersonaltop1 extends Personaltop1State{
  final String message;
  ErrorPersonaltop1({@required this.message});

  @override
  List<Object> get props => [message];
}