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
