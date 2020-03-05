import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DeleteEvent extends Equatable {
  const DeleteEvent();
  
  @override
  List<Object> get props => [];
}


class ButtonDeletePressed extends DeleteEvent{
  
  final OuevreEntity ouevreEntity;
  final String type; 

  const ButtonDeletePressed({
    @required this.ouevreEntity,
    @required this.type
  });

  @override
  List<Object> get props => [ouevreEntity, type];
}
