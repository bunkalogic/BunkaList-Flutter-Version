part of 'editprofile_bloc.dart';

abstract class EditprofileEvent extends Equatable {
  const EditprofileEvent();

   @override
  List<Object> get props => [];
}

class UpdateUsername extends EditprofileEvent {
  final String username;

  const UpdateUsername({
    @required this.username
  });

  @override
  List<Object> get props => [username,];
}


class UpdateProfilePhoto extends EditprofileEvent {
  final File photo;

  const UpdateProfilePhoto({
    @required this.photo
  });

  @override
  List<Object> get props => [photo];

}
