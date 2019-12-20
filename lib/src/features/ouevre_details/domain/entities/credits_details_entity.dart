import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CreditsEntity extends Equatable {
    final List<dynamic> cast;
    final List<dynamic> crew;
    final int id;

    CreditsEntity({
        @required this.cast,
        @required this.crew,
        @required this.id,
    }) : super ([
        cast,
        crew,
        id,
    ]);
}

class Cast extends Equatable {
    final String character;
    final String creditId;
    final int gender;
    final int id;
    final String name;
    final int order;
    final String profilePath;

    Cast({
        @required this.character,
        @required this.creditId,
        @required this.gender,
        @required this.id,
        @required this.name,
        @required this.order,
        @required this.profilePath,
    }) : super([
      character,
      creditId,
      gender,
      id,
      name,
      order,
      profilePath,
    ]);
}

class Crew extends Equatable {
    final String creditId;
    final String department;
    final int gender;
    final int id;
    final String job;
    final String name;
    final String profilePath;

    Crew({
        @required this.creditId,
        @required this.department,
        @required this.gender,
        @required this.id,
        @required this.job,
        @required this.name,
        @required this.profilePath,
    }) : super([
        creditId,
        department,
        gender,
        id,
        job,
        name,
        profilePath,
    ]);
}
