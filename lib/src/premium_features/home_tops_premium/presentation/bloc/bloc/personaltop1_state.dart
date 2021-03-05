part of 'personaltop1_bloc.dart';

abstract class Personaltop1State extends Equatable {
  const Personaltop1State([List props = const []]) : super(props);
  
}

class Personaltop1Initial extends Personaltop1State {}


class Personaltop1Loading extends Personaltop1State {}


class Personaltop1LoadedMovies extends Personaltop1State{
  final List<MovieEntity> movies;
  final bool hasReachedMax;
  final int latestPage;
  final String latestSortBy;
  final int latestYear;

     Personaltop1LoadedMovies({
    this.movies,
    this.hasReachedMax,
    this.latestPage,
    this.latestSortBy,
    this.latestYear

  }): super([movies, hasReachedMax, latestPage, latestSortBy, latestYear]);

  Personaltop1LoadedMovies copyWith({
    List<MovieEntity> movies,
    bool hasReachedMax,
    int latestPage,
    String latestSortBy,
    int latestYear,
  }) {
    return Personaltop1LoadedMovies(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestSortBy: this.latestSortBy,
      latestYear: this.latestYear
    );
  }  
}


class Personaltop1LoadedSeries extends Personaltop1State{
  final List<SeriesEntity> series;
  final bool hasReachedMax;
  final int latestPage;
  final String latestSortBy;
  final int latestYear;

     Personaltop1LoadedSeries({
    this.series,
    this.hasReachedMax,
    this.latestPage,
    this.latestSortBy,
    this.latestYear
  }): super([series, hasReachedMax, latestPage, latestSortBy, latestYear]);

  Personaltop1LoadedSeries copyWith({
    List<SeriesEntity> series,
    bool hasReachedMax,
    int latestPage,
    String latestSortBy,
    int latestYear,
  }) {
    return Personaltop1LoadedSeries(
      series: series ?? this.series,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestSortBy: this.latestSortBy,
      latestYear: this.latestYear
    );
  }  
}


class Personaltop1LoadedAnimes extends Personaltop1State{
  final List<AnimeEntity> animes;
  final bool hasReachedMax;
  final int latestPage;
  final String latestSortBy;
  final int latestYear;

     Personaltop1LoadedAnimes({
    this.animes,
    this.hasReachedMax,
    this.latestPage,
    this.latestSortBy,
    this.latestYear
  }): super([animes, hasReachedMax, latestPage, latestSortBy, latestYear]);

  Personaltop1LoadedAnimes copyWith({
    List<AnimeEntity> animes,
    bool hasReachedMax,
    int latestPage,
    String latestSortBy,
    int latestYear,
  }) {
    return Personaltop1LoadedAnimes(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestSortBy: this.latestSortBy,
      latestYear: this.latestYear
    );
  }  
}




class ErrorPersonaltop1 extends Personaltop1State{
  final String message;
  ErrorPersonaltop1({@required this.message});

  @override
  List<Object> get props => [message];
}