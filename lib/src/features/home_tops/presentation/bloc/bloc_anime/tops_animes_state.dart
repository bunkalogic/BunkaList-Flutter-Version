import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TopsAnimesState extends Equatable {
TopsAnimesState([List props = const <dynamic>[]]) : super(props);
}

class EmptyAnimes extends TopsAnimesState{}

class LoadingAnimes extends TopsAnimesState{}

class LoadedAnimes extends TopsAnimesState{
  final List<AnimeEntity> animes;
  final bool hasReachedMax;
  final int latestPage;
  final int latestTopId;

  LoadedAnimes({
    this.animes,
    this.hasReachedMax,
    this.latestPage,
    this.latestTopId
  }) : super([animes, hasReachedMax, latestPage, latestTopId]);

  LoadedAnimes copyWith({
    List<AnimeEntity> animes,
    bool hasReachedMax,
    int latestPage,
    int latestTopId
  }) {
    return LoadedAnimes(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      latestPage: this.latestPage,
      latestTopId: this.latestTopId
    );
  }  
}

class ErrorAnimes extends TopsAnimesState{
  final String message;
  ErrorAnimes({@required this.message}) : super([message]);
}
