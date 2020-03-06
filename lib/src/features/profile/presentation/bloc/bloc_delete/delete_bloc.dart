import 'dart:async';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_delete_ouevre.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_delete/bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  
  final GetDeleteOuevre getDeleteOuevre;


  DeleteBloc({
    @required GetDeleteOuevre deleteOuevre
  })
  : assert(deleteOuevre != null),
  getDeleteOuevre = deleteOuevre;
  
  
  @override
  DeleteState get initialState => DeleteInitial();

  @override
  Stream<DeleteState> mapEventToState(
    DeleteEvent event,
  ) async* {
    if(event is  ButtonDeletePressed){
      
      yield DeleteLoading();

      final eitherFailureOrDelete = await 
      getDeleteOuevre(Params(ouevreEntity: event.ouevreEntity, type: event.type));

      yield eitherFailureOrDelete.fold(
        (failure) => DeleteError(error: _mapFailureToMessage(failure) ), 
        (delete) => DeleteSuccess()
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
