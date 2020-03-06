import 'dart:async';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_update_ouevre.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_event.dart';
part 'update_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {

  final GetUpdateOuevre getUpdateOuevre;


  UpdateBloc({
    @required GetUpdateOuevre updateOuevre
  })
  : assert(updateOuevre != null),
  getUpdateOuevre = updateOuevre;


  @override
  UpdateState get initialState => UpdateInitial();

  @override
  Stream<UpdateState> mapEventToState(
    UpdateEvent event,
  ) async* {
    if(event is  ButtonUpdatePressed){
      
      yield UpdateLoading();

      final eitherFailureOrUpdate = await 
      getUpdateOuevre(Params(ouevreEntity: event.ouevreEntity, type: event.type));

      yield eitherFailureOrUpdate.fold(
        (failure) => UpdateError(error: _mapFailureToMessage(failure) ), 
        (update) => UpdateSuccess()
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
