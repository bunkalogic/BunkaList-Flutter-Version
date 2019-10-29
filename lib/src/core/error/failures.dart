import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  //Si las subclases tienen algunas propiedades, se pasarán a este constructor
  //para que Equatable pueda realizar una comparación de valores.
  Failures([List properties = const <dynamic>[]]) : super(properties);
}

// General failures
class ServerFailure extends Failures {}

class CacheFailure extends Failures {}