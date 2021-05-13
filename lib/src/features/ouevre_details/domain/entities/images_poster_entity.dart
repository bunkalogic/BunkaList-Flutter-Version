import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


class PosterImages extends Equatable {
    
    final List<Backdrop> backdrops;
    final int id;
    final List<Backdrop> posters;
    
    PosterImages({
        @required this.backdrops,
        @required this.id,
        @required this.posters,
    }) : super([
      backdrops,
      id,
      posters,
    ]);


    
}

class Backdrop  extends Equatable{
  
  final double aspectRatio;
    final String filePath;
    final int height;
    final String iso6391;
    final double voteAverage;
    final int voteCount;
    final int width;


    Backdrop({
        @required this.aspectRatio,
        @required this.filePath,
        @required this.height,
        @required this.iso6391,
        @required this.voteAverage,
        @required this.voteCount,
        @required this.width,
    }) : super([
      aspectRatio,
      filePath,
      height,
      iso6391,
      voteAverage,
      voteCount,
      width,
    ]);

    
}