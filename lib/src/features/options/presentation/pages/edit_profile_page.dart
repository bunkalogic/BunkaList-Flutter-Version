import 'dart:io';

import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/features/options/presentation/bloc/bloc_edit_profile/editprofile_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';


class EditProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditprofileBloc>(
      builder: (BuildContext context) => serviceLocator<EditprofileBloc>(),
      child: BuildEditProfilePage(),
    );
  }
}


class BuildEditProfilePage extends StatefulWidget {
  BuildEditProfilePage({Key key}) : super(key: key);

  @override
  _BuildEditProfilePageState createState() => _BuildEditProfilePageState();
}

class _BuildEditProfilePageState extends State<BuildEditProfilePage> {
  
  Preferences prefs = new Preferences();
  TextEditingController _usernameController = new TextEditingController();


  File _image;


  

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

     return BlocListener<EditprofileBloc, EditprofileState>(
      listener: (context, state) {
       
        if( state is EditprofileError){
          _flushbarEditProfileError();
        }

        if(state is EditprofileSuccess){
          setState(() {});
          _flushbarEditProfileSuccess();
        }

      },

      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_edit_profile")),
          leading: AppBarButtonBack(),
        ),
        body: _buildBuildEditProfilePage(context),
      )
    );

   
  }

  Widget _buildBuildEditProfilePage(BuildContext context) {
    return ListView(
      children: <Widget>[
        // _labelEditProfile(AppLocalizations.of(context).translate("label_change_profile_image")),
        // Divider(),
        // _profileImage(),
        // _buttonChangeImage(),
        _labelEditProfile(AppLocalizations.of(context).translate("label_change_username")),
        Divider(),
        _changeUsernameTextField(),
        SizedBox(height: 20.0,),
        _buttonChangeUsername(context)
      ],
    );
  }

  Widget _labelEditProfile(String title) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, top: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold ),
      ),
    );   
  }

  Widget _profileImage() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 120.0,
        height: 120.0,
        child: CircleAvatar(
          backgroundImage: NetworkImage(prefs.getCurrentUserPhoto),
        )
      ),
    );
  }

  // Widget _buttonChangeImage() {
  //   return Center(
  //     child: FlatButton(
  //       onPressed: _getImagefromGallery,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       color: Colors.pinkAccent[400],
  //       child: Text(
  //         AppLocalizations.of(context).translate("button_change_profile_image"),
  //         style: TextStyle(color: Colors.white, fontSize: 14.0),
  //       ),
  //     ),
  //   );
  // }


  Widget _changeUsernameTextField(){
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.pinkAccent[400],
              width: 0.5,
              style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextFormField(
              validator: (_) {
               return  (_usernameController.text == '')  ? AppLocalizations.of(context).translate("validate_username")  : null;
              },
              controller: _usernameController,
              obscureText: false,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontSize: 14.0 ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: prefs.getCurrentUsername,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonChangeUsername(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: (){

          BlocProvider.of<EditprofileBloc>(context)..add(
            UpdateUsername(username: _usernameController.text),
          );

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.pinkAccent[400],
        child: Text(
          AppLocalizations.of(context).translate("button_change_username"),
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }
  

  // Future _getImagefromGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });

  //   BlocProvider.of<EditprofileBloc>(context)..add(
  //     UpdateProfilePhoto(photo: _image),
  //   );
    
  // }

  void _flushbarEditProfileError(){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.redAccent[700], Colors.redAccent[400]],),
      backgroundColor: Colors.red[500],
      boxShadows: [BoxShadow(color: Colors.red[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("edit_profile_error"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
  }

  void _flushbarEditProfileSuccess(){
     Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.greenAccent[700], Colors.greenAccent[400]],),
      backgroundColor: Colors.green[500],
      boxShadows: [BoxShadow(color: Colors.green[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("edit_profile_success"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
  }

}