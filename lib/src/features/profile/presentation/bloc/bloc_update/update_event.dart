part of 'update_bloc.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}


class ButtonUpdatePressed extends UpdateEvent{
  
  final OuevreEntity ouevreEntity;
  final String type; 

  const ButtonUpdatePressed({
    @required this.ouevreEntity,
    @required this.type
  });

  @override
  List<Object> get props => [ouevreEntity, type];
}