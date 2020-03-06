part of 'update_bloc.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();
  
  @override
  List<Object> get props => [];
}


class UpdateInitial extends UpdateState {}

class UpdateLoading extends UpdateState {}

class UpdateSuccess extends UpdateState {}

class UpdateError extends UpdateState {
  final String error;

  const UpdateError({@required this.error});

  @override
  List<Object> get props => [error];
}
