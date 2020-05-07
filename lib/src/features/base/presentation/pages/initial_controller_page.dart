

import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:bunkalist/src/features/base/presentation/bloc/bloc/userdata_bloc.dart';
import 'package:bunkalist/src/features/login/data/datasources/get_guest_sesion_id_data_remote_source.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';

class InitialController extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    // return BlocProvider<AuthenticationBloc>(
    //   builder: (_) => serviceLocator<AuthenticationBloc>(),
    //   child: InitialControllerPage(),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (_) => serviceLocator<AuthenticationBloc>(),
        ),
        BlocProvider<UserdataBloc>(
          builder: (_) => serviceLocator<UserdataBloc>(),
        ),
      ], 
      child: InitialControllerPage(),
    );
  }

}

class InitialControllerPage extends StatefulWidget {
  InitialControllerPage({Key key}) : super(key: key);

  @override
  _InitialControllerPageState createState() => _InitialControllerPageState();
}

class _InitialControllerPageState extends State<InitialControllerPage> {

  
  Preferences prefs = Preferences();
  AppUpdateInfo _updateInfo;
  bool _flexibleUpdateAvailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<AuthenticationBloc>(context)
    ..add(AppStarted());

  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
  }

   void _showError(dynamic exception) {
     FlushbarHelper.createError(message: exception.toString(), title: 'Error');
   }

   startFlexibleUpdate(){
     if(_updateInfo?.updateAvailable == true){

      InAppUpdate.startFlexibleUpdate().then((_) {
        setState(() {
          _flexibleUpdateAvailable = true;
        });
      }).catchError((e) => _showError(e));

     }
   }

   completeFlexibleUpdate(){
     if(_flexibleUpdateAvailable){
        InAppUpdate.completeFlexibleUpdate().then((_) {
          FlushbarHelper.createSuccess(message: 'Success!!!');
        }).catchError((e) => _showError(e));
     }
     
   }

  addUserDataInFirebase(){
    final UserEntity userData = new UserEntity(
      username: prefs.getCurrentUsername,
      photoUrl: prefs.getCurrentUserPhoto
    );

    BlocProvider.of<UserdataBloc>(context).add(
      AddDataUser(userEntity: userData)
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocListener<AuthenticationBloc, AuthenticationState>(

      listener: (context, state) async {
        
        if(state is AuthenticationUninitialized){
          print('login init');
          checkForUpdate();
          startFlexibleUpdate();
          return _splashPage();
        }

        if(state is AuthenticationAuthenticated){
          print('Authenticated');
          addUserDataInFirebase();
          await Future.delayed(Duration(milliseconds: 1500));
          return Navigator.pushReplacementNamed(context, '/Home');
          
        }

        if(state is AuthenticationUnauthenticated){
          print('Unauthenticated');
          await Future.delayed(Duration(milliseconds: 500));
          return Navigator.pushReplacementNamed(context, '/Login');
        }

        if(state is AuthenticationLoading){
          print('loading login');
          completeFlexibleUpdate();
          return _loadingPage();
        }
           
      },
      child:_loadingPage(),
    );
  }
  

  Widget _splashPage(){
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple[700],
            Colors.purple[900],  
            Colors.deepOrangeAccent[400],
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Center(
            child: Image(
              image: AssetImage('assets/bunkalist-banner.png'),
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }

  Widget _loadingPage(){
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple[700],
            Colors.purple[900],  
            Colors.deepOrangeAccent[400],
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 2.0,
          vertical: MediaQuery.of(context).size.height / 2.5
        ),
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage('assets/bunkalist-banner.png'),
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(),
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple,
              )
          )

        ],
      ),
      ),
    );
  }

 
}