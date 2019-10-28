import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:bunkalist/src/core/error/failures.dart';


//Los parámetros deben colocarse en un objeto contenedor para que puedan ser
//incluido en esta definición de método de clase base abstracta
abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

//Esto será utilizado por el código que llama al caso de uso siempre que el caso de uso
//no acepta ningún parámetro. 
class NoParams extends Equatable {}