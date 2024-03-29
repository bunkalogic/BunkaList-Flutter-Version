
Map<String, dynamic> getIdAndType(int id , String type, String title){

  final Map<String, dynamic> mapIdAndType = new Map();

    mapIdAndType.addAll({
      'id'  : id,
      'type': type,
      'title': title
    });

    return mapIdAndType;

}

Map<String, dynamic> getIdAndSeasonId(int id , int seasonId, String title){

  final Map<String, dynamic> mapIdAndType = new Map();

    mapIdAndType.addAll({
      'id'  : id,
      'seasonId': seasonId,
      'title' : title
    });

    return mapIdAndType;

}

Map<String, dynamic> getIdAndNameCast(int id , String name){

  final Map<String, dynamic> mapIdAndType = new Map();

    mapIdAndType.addAll({
      'id'  : id,
      'name': name
    });

    return mapIdAndType;

}

Map<String, dynamic> getTypeAndMaxSelected(int maxSelected , String type){

  final Map<String, dynamic> mapIdAndType = new Map();

    mapIdAndType.addAll({
      'maxSelected'  : maxSelected,
      'type': type
    });

    return mapIdAndType;

}