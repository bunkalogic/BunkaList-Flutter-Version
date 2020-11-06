part of 'getlists_bloc.dart';

abstract class GetListsState extends Equatable {
  const GetListsState();

  @override
  List<Object> get props => [];
}


class GetListsLoading extends GetListsState {}

class GetNewListsLoading extends GetListsState {}

class GetListsLoaded extends GetListsState {
  
  final List<OuevreEntity> ouevreList;

  const GetListsLoaded([this.ouevreList = const []]);

  @override
  List<Object> get props => [ouevreList];
  
}

class GetTotalByStatusLoaded extends GetListsState {
  
  final List<int> listTotalByStatus;

  const GetTotalByStatusLoaded([this.listTotalByStatus = const []]);

  @override
  List<Object> get props => [listTotalByStatus];
  
}



class GetlistsError extends GetListsState {}
