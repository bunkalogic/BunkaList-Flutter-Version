import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:meta/meta.dart';

class PosterImagesModel extends PosterImages {
    
    final List<BackdropModel> backdrops;
    final int id;
    final List<BackdropModel> posters;
    
    PosterImagesModel({
        @required this.backdrops,
        @required this.id,
        @required this.posters,
    });

    

    factory PosterImagesModel.fromJson(Map<String, dynamic> json) => PosterImagesModel(
        backdrops: List<BackdropModel>.from(json["backdrops"].map((x) => BackdropModel.fromJson(x))),
        id: json["id"],
        posters: List<BackdropModel>.from(json["posters"].map((x) => BackdropModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
        "id": id,
        "posters": List<dynamic>.from(posters.map((x) => x.toJson())),
    };
}

class BackdropModel extends Backdrop {
    BackdropModel({
        @required this.aspectRatio,
        @required this.filePath,
        @required this.height,
        @required this.iso6391,
        @required this.voteAverage,
        @required this.voteCount,
        @required this.width,
    });

    final double aspectRatio;
    final String filePath;
    final int height;
    final String iso6391;
    final double voteAverage;
    final int voteCount;
    final int width;

    factory BackdropModel.fromJson(Map<String, dynamic> json) => BackdropModel(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "file_path": filePath,
        "height": height,
        "iso_639_1": iso6391,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
    };
}
