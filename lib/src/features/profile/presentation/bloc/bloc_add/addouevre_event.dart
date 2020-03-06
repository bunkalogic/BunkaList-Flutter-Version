part of 'addouevre_bloc.dart';

abstract class AddOuevreEvent extends Equatable {
  const AddOuevreEvent();

  @override
  List<Object> get props => [];
}


class ButtonAddPressed extends AddOuevreEvent{
  
  final OuevreEntity ouevreEntity;
  final String type; 

  const ButtonAddPressed({
    @required this.ouevreEntity,
    @required this.type
  });

  @override
  List<Object> get props => [ouevreEntity, type];
}
