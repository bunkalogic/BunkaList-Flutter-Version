import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_add_ouevre.dart';
import 'package:equatable/equatable.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:meta/meta.dart';


part 'addouevre_event.dart';
part 'addouevre_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';


class AddOuevreBloc extends Bloc<AddOuevreEvent, AddOuevreState> {

  final GetAddOuevre getAddOuevre;


  AddOuevreBloc({
    @required GetAddOuevre addOuevre
  })
  : assert(addOuevre != null),
  getAddOuevre = addOuevre;


  @override
  AddOuevreState get initialState => AddOuevreInitial();

  @override
  Stream<AddOuevreState> mapEventToState(
    AddOuevreEvent event,
  ) async* {
    
    if(event is ButtonAddPressed){
      
      yield AddOuevreLoading();

      final eitherFailureOrAdd = await 
      getAddOuevre(Params(ouevreEntity: event.ouevreEntity, type: event.type));

      yield eitherFailureOrAdd.fold(
        (failure) => AddOuevreError(error: _mapFailureToMessage(failure) ), 
        (add) => AddOuevreSuccess()
      );
    }
  }

  String _mapFailureToMessage(Failures failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
