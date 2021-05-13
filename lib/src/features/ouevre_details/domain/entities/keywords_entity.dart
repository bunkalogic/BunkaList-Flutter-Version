import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Keywords  extends Equatable{
    final int id;
    final List<Result> results;
    
    Keywords({
        @required this.id,
        @required this.results,
    }) : super([
      id,
      results
    ]);

    
}

class Result extends Equatable {
    final String name;
    final int id;
    
    Result({
        @required this.name,
        @required this.id,
    }) : super([
      name,
      id,
    ]);

    
}