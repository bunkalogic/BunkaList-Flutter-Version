import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class DeleteState extends Equatable {
  const DeleteState();
  
  @override
  List<Object> get props => [];
}

class DeleteInitial extends DeleteState {}

class DeleteLoading extends DeleteState {}

class DeleteSuccess extends DeleteState {}

class DeleteError extends DeleteState {
  final String error;

  const DeleteError({@required this.error});

  @override
  List<Object> get props => [error];
}
