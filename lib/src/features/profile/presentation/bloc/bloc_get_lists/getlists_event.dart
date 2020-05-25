part of 'getlists_bloc.dart';

abstract class GetListsEvent extends Equatable {
  const GetListsEvent();

  @override
  List<Object> get props => [];
}

class GetYourLists extends GetListsEvent{
  final String type; 
  final String status;

  const GetYourLists({
    @required this.type,
    @required this.status
  });

  @override
  List<Object> get props => [type, status];
}

class GetTotalByStatusEvent extends GetListsEvent{
  final String type;

  const GetTotalByStatusEvent({
    @required this.type,
  });

  @override
  List<Object> get props => [type];
  
}


class GetYourListsUpdated extends GetListsEvent{
  final List<OuevreEntity> ouevreList;

  const GetYourListsUpdated(
    this.ouevreList,
  );

  @override
  List<Object> get props => [ouevreList];
}

