part of 'addouevre_bloc.dart';

abstract class AddOuevreState extends Equatable {
  const AddOuevreState();

  @override
  List<Object> get props => [];
}


class AddOuevreInitial extends AddOuevreState {}

class AddOuevreLoading extends AddOuevreState {}

class AddOuevreSuccess extends AddOuevreState {}

class AddOuevreError extends AddOuevreState {
  final String error;

  const AddOuevreError({@required this.error});

  @override
  List<Object> get props => [error];
}
