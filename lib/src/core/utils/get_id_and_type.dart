
Map<String, dynamic> getIdAndType(int id , String type,String title){

  final Map<String, dynamic> mapIdAndType = new Map();

    mapIdAndType.addAll({
      'id'  : id,
      'type': type,
      'title': title
    });

    return mapIdAndType;

}