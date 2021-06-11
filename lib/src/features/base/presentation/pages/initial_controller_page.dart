

import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
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
    //   create: (_) => serviceLocator<AuthenticationBloc>(),
    //   child: InitialControllerPage(),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => serviceLocator<AuthenticationBloc>(),
        ),
        BlocProvider<UserdataBloc>(
          create: (_) => serviceLocator<UserdataBloc>(),
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
  // AppUpdateInfo _updateInfo;
  // bool _flexibleUpdateAvailable = false;

  // AnimationController _animationController;
  // // Animation<Color> _colorAnimation;
  // Animation<double> _animation;
  

   @override
  void initState() {

    BlocProvider.of<AuthenticationBloc>(context)
    ..add(AppStarted());


    // _animationController = AnimationController(vsync: this, duration: Duration(seconds:  3));
    // // _colorAnimation = _animationController.drive(
    // //   ColorTween(
    // //     begin: Colors.pinkAccent[400],
    // //     end: Colors.pinkAccent[700]
    // //   )
    // // );
    // _animationController.repeat(reverse: true);

    // _animation = CurvedAnimation(
    // parent: _animationController,
    // curve: Curves.fastOutSlowIn,
    // );
    super.initState();
  }


  

  // @override
  // dispose() {
  
  //   _animationController.dispose(); // you need this
  //   super.dispose();
  // }


  

  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) => _showError(e));
  // }

  //  void _showError(dynamic exception) {
  //    FlushbarHelper.createError(message: exception.toString(), title: 'Error');
  //  }

  //  startFlexibleUpdate(){
  //    if(_updateInfo?.updateAvailable == true){

  //     InAppUpdate.startFlexibleUpdate().then((_) {
  //       setState(() {
  //         _flexibleUpdateAvailable = true;
  //       });
  //     }).catchError((e) => _showError(e));

  //    }
  //  }

  //  completeFlexibleUpdate(){
  //    if(_flexibleUpdateAvailable){
  //       InAppUpdate.completeFlexibleUpdate().then((_) {
  //         FlushbarHelper.createSuccess(message: 'Success!!!');
  //       }).catchError((e) => _showError(e));
  //    }
     
  //  }

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

    print('----intial controller Language & Country code: ${prefs.getLanguage} ----');
    print('----intial controller Language code: ${prefs.getLanguageCode} ----');
    print('----intial controller Country code: ${prefs.getCountryCode} ----');

    Locale locale = new Locale(
      '${prefs.getLanguageCode}',
      '${prefs.getCountryCode}'
    );

    AppLocalizations.of(context).changeLang(locale);
    
    return BlocListener<AuthenticationBloc, AuthenticationState>(

      listener: (context, state){

         if(state is AuthenticationLoading){
          print('loading login');
          // completeFlexibleUpdate();
          return _loadingPage();
        }
        
        if(state is AuthenticationFirstTimeOpen){
          return Navigator.pushReplacementNamed(context, '/Intro');
        }
        
        if(state is AuthenticationUninitialized){
          print('login init');
          // checkForUpdate();
          // startFlexibleUpdate();

          return _loadingPage();
        }

        if(state is AuthenticationAuthenticated){
          print('Authenticated');
          addUserDataInFirebase();
          // await Future.delayed(Duration(seconds: 2));
          Navigator.pushReplacementNamed(context, '/Home');
          
        }

        if(state is AuthenticationUnauthenticated){
          print('Unauthenticated');
          // await Future.delayed(Duration(seconds: 2));
          Navigator.pushReplacementNamed(context, '/NewUserHome');
        }

       
           
      },
      child:_loadingPage(),
    );
  }
  

  
  

  Widget _loadingPage(){

    return Container(
      height: MediaQuery.of(context).size.height,
      color: getBackgroundColorTheme(),
    // decoration: new BoxDecoration(
    //   // gradient: new LinearGradient(
    //   //   begin: Alignment.topCenter,
    //   //   end: Alignment.bottomCenter,
    //   //   colors: [
    //   //     Colors.blueAccent,
    //   //     Colors.deepPurpleAccent, 
    //   //     Colors.pinkAccent,
    //   //   ], // whitish to gray
    //   //   tileMode: TileMode.repeated, // repeats the gradient over the canvas
    //   // ),
    //   color: Colors.blueGrey[900]
    // ),
    child: Column(
      
      children: <Widget>[
        Spacer(),
        Align(
          alignment: Alignment.center,
          child: Image(
          image: AssetImage('assets/bunkalist-icon.png'),
          height: 100.0,
          fit: BoxFit.cover,
        ),
        ),
        Spacer(),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       vertical: 1.0,
        //       horizontal: 2.0
        //     ),
        //     child: LinearProgressIndicator(
        //       backgroundColor: Colors.transparent,
        //       valueColor: _colorAnimation,
        //     ),
        //   )
        // )

      ],
    ),
    );
  }

  // Widget _animationImage(){
  //   return new ScaleTransition(
  //       scale: _animation,
  //       child: Image(
  //         image: AssetImage('assets/banner-icon.png'),
  //         height: 50.0,
  //         fit: BoxFit.cover,
  //       ),
        
  //     );
  // }

  


 
}