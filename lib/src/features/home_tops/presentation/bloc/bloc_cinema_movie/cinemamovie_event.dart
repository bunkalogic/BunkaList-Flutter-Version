part of 'cinemamovie_bloc.dart';

abstract class CinemaMovieEvent extends Equatable {

  const CinemaMovieEvent([List props = const <dynamic>[]]) : super(props);

}


class GetMoviesCinema extends CinemaMovieEvent {
  
  final int page;
  GetMoviesCinema(this.page) : super([page]);
  
}