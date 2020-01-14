
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/people_details_entity.dart';

class PeopleModel extends PeopleEntity {
  
  PeopleModel({

    @required String birthday,
    @required String knownForDepartment,
    @required dynamic deathday,
    @required int id,
    @required String name,
    @required List<String> alsoKnownAs,
    @required int gender,
    @required String biography,
    @required double popularity,
    @required String placeOfBirth,
    @required String profilePath,
    @required bool adult,
    @required String imdbId,
    @required String homepage,

  }): super (
  birthday           : birthday,
  knownForDepartment : knownForDepartment,
  deathday           : deathday,
  id                 : id,
  name               : name,
  alsoKnownAs        : alsoKnownAs,
  gender             : gender,
  biography          : biography,
  popularity         : popularity,
  placeOfBirth       : placeOfBirth,
  profilePath        : profilePath,
  adult              : adult,
  imdbId             : imdbId,
  homepage           : homepage,
  );


  factory PeopleModel.fromJson(Map<String, dynamic> json){
    return PeopleModel(
      birthday           : json['birthday'],
      knownForDepartment : json['known_for_department'],
      deathday           : json['deathday'],
      id                 : json['id'],
      name               : json['name'],
      alsoKnownAs        : json['also_known_as'],
      gender             : json['gender'],
      biography          : json['biography'],
      popularity         : json['popularity'],
      placeOfBirth       : json['place_of_birth'],
      profilePath        : json['profile_path'],
      adult              : json['adult'],
      imdbId             : json['imdb_id'],
      homepage           : json['homepage'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'birthday          ' : birthday,
      'knownForDepartment' : knownForDepartment,
      'deathday          ' : deathday,
      'id                ' : id,
      'name              ' : name,
      'alsoKnownAs       ' : alsoKnownAs,
      'gender            ' : gender,
      'biography         ' : biography,
      'popularity        ' : popularity,
      'placeOfBirth      ' : placeOfBirth,
      'profilePath       ' : profilePath,
      'adult             ' : adult,
      'imdbId            ' : imdbId,
      'homepage          ' : homepage,
    };
  }

}