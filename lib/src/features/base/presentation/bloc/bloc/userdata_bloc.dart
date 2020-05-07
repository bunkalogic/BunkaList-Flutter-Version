import 'dart:async';

import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/usescases/usescase.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:bunkalist/src/features/base/domain/usescases/add_user_data.dart';
import 'package:bunkalist/src/features/base/domain/usescases/get_user_data.dart';
import 'package:bunkalist/src/features/base/domain/usescases/update_user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class UserdataBloc extends Bloc<UserdataEvent, UserdataState> {
  
  StreamSubscription _userDataSubscription;

  final AddUserData addUserData;
  final UpdateUserData updateUserData;
  final GetUserData getUserData;

  UserdataBloc({
    @required AddUserData addUser,
    @required UpdateUserData updateUser,
    @required GetUserData getUser,
  })
    :
    assert(addUser != null),
    assert(updateUser != null),
    assert(getUser != null),
    addUserData = addUser,
    updateUserData = updateUser,
    getUserData = getUser;

  
  @override
  UserdataState get initialState => UserDataInitial();

  @override
  Stream<UserdataState> mapEventToState(
    UserdataEvent event,
  ) async* {
    if(event is AddDataUser){

      yield UserDataLoading();

      final eitherFailureOrAdd = await 
      addUserData(AddParams(userEntity: event.userEntity));

      yield eitherFailureOrAdd.fold(
        (failure) => UserDataError(error: _mapFailureToMessage(failure) ),
        (add) => UserDataSuccess()
      );

    }else if(event is UpdateDataUser){
      
      yield UserDataLoading();

      final eitherFailureOrAdd = await 
      updateUserData(UpdateParams(userEntity: event.userEntity));

      yield eitherFailureOrAdd.fold(
        (failure) => UserDataError(error: _mapFailureToMessage(failure) ),
        (add) => UserDataSuccess()
      );

    }else if(event is GetDataUser){
      
      final eitherFailureOrData = await
      getUserData(NoParams());

      eitherFailureOrData.fold(
        (failure) => UserDataError(error: _mapFailureToMessage(failure) ),
        (data) {
          _userDataSubscription?.cancel();
          _userDataSubscription = data.listen(
            (user) => add(GetDataUserUpdated(user))
          );
        }
      );
    }else if(event is GetDataUserUpdated){
      yield* _getUserDataUpdated(event);
    }
  }

  Stream<UserdataState> _getUserDataUpdated(GetDataUserUpdated event) async*{
    /// Motivo por el que no paso directamente la lista desde el bloc ver en el enlace:
    /// https://github.com/felangel/bloc/issues/253
    /// y el ejemplo:
    /// https://github.com/felangel/bloc/tree/master/examples/flutter_bloc_with_stream
     
    yield UserDataLoaded(event.userEntity);

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
