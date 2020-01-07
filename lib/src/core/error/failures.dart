import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  //Si las subclases tienen algunas propiedades, se pasarán a este constructor
  //para que Equatable pueda realizar una comparación de valores.
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failures {}

class CacheFailure extends Failures {}

//class CacheFailure extends Failures {}