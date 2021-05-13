import 'package:bunkalist/src/features/ouevre_details/domain/entities/keywords_entity.dart';
import 'package:meta/meta.dart';


class KeywordsModel extends Keywords {
    KeywordsModel({
        @required this.id,
        @required this.results,
    });

    final int id;
    final List<ResultsModel> results;

    factory KeywordsModel.fromJson(Map<String, dynamic> json) => KeywordsModel(
        id: json["id"],
        results: List<ResultsModel>.from( json["keywords"] == null ? json["results"].map((x) => ResultsModel.fromJson(x)) : json["keywords"].map((x) => ResultsModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "keywords": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class ResultsModel extends Result {
    ResultsModel({
        @required this.name,
        @required this.id,
    });

    final String name;
    final int id;

    factory ResultsModel.fromJson(Map<String, dynamic> json) => ResultsModel(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}