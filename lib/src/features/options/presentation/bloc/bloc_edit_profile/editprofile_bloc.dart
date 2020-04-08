import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/features/options/domain/usescases/get_changed_profile_image.dart';
import 'package:bunkalist/src/features/options/domain/usescases/get_changed_username.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  
  final GetChangedUsername getChangedUsername;
  final GetChangedProfileImage getChangedProfileImage;

  EditprofileBloc({
    @required GetChangedUsername changedUsername,
    @required GetChangedProfileImage changedProfileImage
  }) 
  : assert(changedUsername != null),
    assert(changedProfileImage != null),
    getChangedUsername = changedUsername,
    getChangedProfileImage = changedProfileImage;
  
  
  @override
  EditprofileState get initialState => EditprofileInitial();

  @override
  Stream<EditprofileState> mapEventToState(
    EditprofileEvent event,
  ) async* {
    if(event is UpdateUsername){

      yield EditprofileInitial();

      final eitherFailOrSucess = await getChangedUsername(ParamsUP(newUsername: event.username ));

      yield  eitherFailOrSucess.fold(
        (failure) => EditprofileError(), 
        (success) => EditprofileSuccess()
      );      

    }else if(event is UpdateProfilePhoto){

      yield EditprofileInitial();

      final eitherFailOrSucess = await getChangedProfileImage(ParamsPi(image: event.photo ));

      yield  eitherFailOrSucess.fold(
        (failure) => EditprofileError(), 
        (success) => EditprofileSuccess()
      );      


    }
  }
}
