part of 'animeseason_bloc.dart';

abstract class AnimeSeasonEvent extends Equatable {
  const AnimeSeasonEvent([List props = const <dynamic>[]]) : super(props);
}


class GetSeasonAnime extends AnimeSeasonEvent {
  final int topId;
  final int page;
  GetSeasonAnime(this.topId, this.page) : super([topId, page]);
}
