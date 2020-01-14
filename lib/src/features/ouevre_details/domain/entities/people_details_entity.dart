import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class PeopleEntity extends Equatable {
    final String birthday;
    final String knownForDepartment;
    final dynamic deathday;
    final int id;
    final String name;
    final List<String> alsoKnownAs;
    final int gender;
    final String biography;
    final double popularity;
    final String placeOfBirth;
    final String profilePath;
    final bool adult;
    final String imdbId;
    final String homepage;

    PeopleEntity({
        @required this.birthday,
        @required this.knownForDepartment,
        @required this.deathday,
        @required this.id,
        @required this.name,
        @required this.alsoKnownAs,
        @required this.gender,
        @required this.biography,
        @required this.popularity,
        @required this.placeOfBirth,
        @required this.profilePath,
        @required this.adult,
        @required this.imdbId,
        @required this.homepage,
    }) : super ([
      birthday,
      knownForDepartment,
      deathday,
      id,
      name,
      alsoKnownAs,
      gender,
      biography,
      popularity,
      placeOfBirth,
      profilePath,
      adult,
      imdbId,
      homepage,
    ]);
}