
Map<String, dynamic> getIdAndType(int id , String type){

  final Map<String, dynamic> mapIdAndType = new Map();

    mapIdAndType.addAll({
      'id'  : id,
      'type': type
    });

    return mapIdAndType;

}