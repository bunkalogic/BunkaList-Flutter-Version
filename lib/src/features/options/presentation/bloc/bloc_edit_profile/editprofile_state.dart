part of 'editprofile_bloc.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();

  @override
  List<Object> get props => [];
}

class EditprofileInitial extends EditprofileState {}

class EditprofileLoading extends EditprofileState {}

class EditprofileSuccess extends EditprofileState {}

class EditprofileError extends EditprofileState {}
