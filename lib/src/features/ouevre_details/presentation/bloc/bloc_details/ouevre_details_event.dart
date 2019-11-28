import 'package:equatable/equatable.dart';

abstract class OuevreDetailsEvent extends Equatable {
  OuevreDetailsEvent([List props = const <dynamic>[]]) : super (props);
}


class GetDetailsOuevre extends OuevreDetailsEvent{

  final int id;
  final String type;
  GetDetailsOuevre(this.id, this.type) : super ([id, type]);

}

// class GetDetailsMovie extends OuevreDetailsEvent{

//   final int id;
//   GetDetailsMovie(this.id) : super ([id]);

// }

// class GetDetailsSerie extends OuevreDetailsEvent{

//   final int id;
//   GetDetailsSerie(this.id) : super ([id]);

// }

// class GetDetailsAnime extends OuevreDetailsEvent{

//   final int id;
//   GetDetailsAnime(this.id) : super ([id]);

// }


