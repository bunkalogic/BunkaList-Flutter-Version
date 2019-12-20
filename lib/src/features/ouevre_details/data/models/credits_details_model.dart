import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/credits_details_entity.dart';

class CreditsDetailsModel extends CreditsEntity{

    CreditsDetailsModel({
      @required List<dynamic> cast,
      @required List<dynamic> crew,
      @required int id,
    }): super(
      cast : cast,
      crew : crew,
      id   : id,
    );

    factory CreditsDetailsModel.fromJson(Map<String, dynamic> json){

      var listCast = json['cast'] as List;
      List<CastModel> castList = listCast.map((i) => CastModel.fromJson(i)).toList();

      var listCrew = json['crew'] as List;
      List<CrewModel> crewList = listCrew.map((i) => CrewModel.fromJson(i)).toList();

      return CreditsDetailsModel(
        cast: castList,
        crew: crewList,
        id: json['id'],
      );

    }

    Map<String, dynamic> toJson(){
      return {
        'cast' : cast,
        'crew' : crew,
        'id'   : id
      };
    }

}

class CastModel extends Cast{


    CastModel({
      @required String character,
      @required String creditId,
      @required int gender,
      @required int id,
      @required String name,
      @required int order,
      @required String profilePath,
    }) : super(
      character   : character,
      creditId    : creditId,
      gender      : gender,
      id          : id,
      name        : name,
      order       : order,
      profilePath : profilePath,
    );

    factory CastModel.fromJson(Map<String, dynamic> json){

      return CastModel(
        character   : json['character'],
        creditId    : json['credit_id'],
        gender      : json['gender'],
        id          : json['id'],
        name        : json['name'],
        order       : json['order'],
        profilePath : json['profile_path'],
      );
    }

    Map<String, dynamic> toJson(){
      return{
        'character'   : character,
        'credit_id'   : creditId,
        'gender'      : gender,
        'id'          : id,
        'name'        : name,
        'order'       : order,
        'profile_path': profilePath,
      };
    }
    
}


class CrewModel extends Crew {

    CrewModel({
      @required String creditId,
      @required String department,
      @required int gender,
      @required int id,
      @required String job,
      @required String name,
      @required String profilePath,
    }) : super(
      creditId    : creditId,
      department  : department,
      gender      : gender,  
      id          : id,
      job         : job,
      name        : name,
      profilePath : profilePath,        
    );

    factory CrewModel.fromJson(Map<String, dynamic> json){
       return CrewModel(
          creditId    : json['credit_id'],
          department  : json['department'],
          gender      : json['gender'],  
          id          : json['id'],
          job         : json['job'],
          name        : json['name'],
          profilePath : json['profile_path'],
       );
    }

    Map<String, dynamic> toJson(){
      return {
        'credit_id'  : creditId,
        'department' : department,
        'gender'     : gender,  
        'id'         : id,
        'job'        : job,
        'name'       : name,
        'profile_path': profilePath,
      };
    }


}