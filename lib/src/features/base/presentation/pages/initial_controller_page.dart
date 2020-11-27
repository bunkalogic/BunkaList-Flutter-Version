

import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/base/domain/entities/user_entity.dart';
import 'package:bunkalist/src/features/base/presentation/bloc/bloc/userdata_bloc.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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

class _InitialControllerPageState extends State<InitialControllerPage> with SingleTickerProviderStateMixin {

  
  Preferences prefs = Preferences();
  AppUpdateInfo _updateInfo;
  bool _flexibleUpdateAvailable = false;

  AnimationController _animationController;
  Animation<Color> _colorAnimation;

  

   @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _colorAnimation = _animationController.drive(
      ColorTween(
        begin: Colors.pinkAccent[400],
        end: Colors.pinkAccent[700]
      )
    );
    _animationController.repeat();
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }


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

    // Later log in provided user Id
    Purchases.identify(prefs.getCurrentUserUid);

  }

  @override
  Widget build(BuildContext context) {
    
    return BlocListener<AuthenticationBloc, AuthenticationState>(

      listener: (context, state) async {

        if(state is AuthenticationFirstTimeOpen){
          return Navigator.pushReplacementNamed(context, '/Intro');
        }
        
        if(state is AuthenticationUninitialized){
          print('login init');
          // checkForUpdate();
          // startFlexibleUpdate();
          return _splashPage();
        }

        if(state is AuthenticationAuthenticated){
          print('Authenticated');
          addUserDataInFirebase();
          await Future.delayed(Duration(seconds: 2));
          return Navigator.pushReplacementNamed(context, '/Home');
          
        }

        if(state is AuthenticationUnauthenticated){
          print('Unauthenticated');
          await Future.delayed(Duration(seconds: 1));
          return Navigator.pushReplacementNamed(context, '/Login');
        }

        if(state is AuthenticationLoading){
          print('loading login');
          // completeFlexibleUpdate();
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
            Colors.pinkAccent[400],
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Center(
            child: Image(
              image: AssetImage('assets/bunkalist-banner.png'),
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }
  

  Widget _loadingPage(){

    return Container(
      height: MediaQuery.of(context).size.height,
      // color: Colors.deepPurpleAccent[700],
    decoration: new BoxDecoration(
      // gradient: new LinearGradient(
      //   begin: Alignment.topCenter,
      //   end: Alignment.bottomCenter,
      //   colors: [
      //     Colors.blueAccent,
      //     Colors.deepPurpleAccent, 
      //     Colors.pinkAccent,
      //   ], // whitish to gray
      //   tileMode: TileMode.repeated, // repeats the gradient over the canvas
      // ),
      color: Colors.blueGrey[900]
    ),
    child: Column(
      
      children: <Widget>[
        Spacer(),
        Align(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage('assets/banner-icon.png'),
            height: 40.0,
            fit: BoxFit.cover,
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1.0,
              horizontal: 2.0
            ),
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: _colorAnimation,
            ),
          )
        )

      ],
    ),
    );
  }

 
}