

import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_auth/bloc.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';

class InitialController extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      builder: (_) => serviceLocator<AuthenticationBloc>(),
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
          await Future.delayed(Duration(seconds: 1));
          return Navigator.pushReplacementNamed(context, '/Home');
          
        }

        if(state is AuthenticationUnauthenticated){
          print('Unauthenticated');
          await Future.delayed(Duration(seconds: 1));
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