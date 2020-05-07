part of 'userdata_bloc.dart';

abstract class UserdataState extends Equatable {
  const UserdataState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserdataState {}

class UserDataLoading extends UserdataState {}

class UserDataSuccess extends UserdataState {}

class UserDataLoaded extends UserdataState {
  final UserEntity userEntity;

  const UserDataLoaded([this.userEntity]);

  @override
  List<Object> get props => [userEntity];  
}

class UserDataError extends UserdataState {
  final String error;

  const UserDataError({@required this.error});

  @override
  List<Object> get props => [error];
}
