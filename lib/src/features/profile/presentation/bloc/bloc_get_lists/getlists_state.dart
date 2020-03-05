part of 'getlists_bloc.dart';

abstract class GetListsState extends Equatable {
  const GetListsState();

  @override
  List<Object> get props => [];
}

class GetListsInitial extends GetListsState {}

class GetListsLoading extends GetListsState {}

class GetListsLoaded extends GetListsState {
  
  final List<OuevreEntity> ouevreList;

  const GetListsLoaded([this.ouevreList = const []]);

  @override
  List<Object> get props => [ouevreList];
  
}

class GetlistsError extends GetListsState {}
