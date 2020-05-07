part of 'userdata_bloc.dart';

abstract class UserdataEvent extends Equatable {
  const UserdataEvent();

   @override
  List<Object> get props => [];
}


class AddDataUser extends UserdataEvent{
  
  final UserEntity userEntity;

  const AddDataUser({
    @required this.userEntity,
  });

   @override
  List<Object> get props => [userEntity];  

}

class UpdateDataUser extends UserdataEvent{
  
  final UserEntity userEntity;

  const UpdateDataUser({
    @required this.userEntity,
  });

   @override
  List<Object> get props => [userEntity];  

}

class GetDataUser extends UserdataEvent{}

class GetDataUserUpdated extends UserdataEvent{
  final UserEntity userEntity;
  
  const GetDataUserUpdated(
    this.userEntity
  );

   @override
  List<Object> get props => [userEntity];
}

