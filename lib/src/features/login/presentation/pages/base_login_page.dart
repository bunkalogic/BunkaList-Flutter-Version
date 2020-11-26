import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_login/bloc.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_register/register_bloc.dart';
import 'package:bunkalist/src/features/login/presentation/widgets/login_widget.dart';
import 'package:bunkalist/src/features/login/presentation/widgets/signup_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginHomePage extends StatefulWidget {

  @override
  _LoginHomePageState createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {

  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: _pageViewController(context),
      ),
    );
  }

  Widget _pageViewController(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: new AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
       BlocProvider<LoginBloc>(
      builder: (_) => serviceLocator<LoginBloc>(),
      child: LoginWidget(),
      ),
      _baseLogin(context),
       BlocProvider<RegisterBloc>(
      builder: (_) => serviceLocator<RegisterBloc>(),
      child: SignUpWidget(),
      ),
      ],
    );
  }

  _baseLogin(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blueAccent,
            Colors.deepPurpleAccent,
            Colors.deepPurpleAccent,
            Colors.deepPurpleAccent,
            Colors.pinkAccent, 
            Colors.pinkAccent, 
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //_logoApp(),
          _nameApp(),
          _buttonSignUp(),
          _buttonLogin(),
          _borderWithConnect(context),
          BlocProvider<LoginBloc>(
            builder: (_) => serviceLocator<LoginBloc>(),
            child: ButtonSignInWithGoogle(),
          ),
        ],
      ),
    );
  }

  

  Container _borderWithConnect(BuildContext context) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate("or_connect"),
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buttonLogin() {
    return new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  color: Colors.white,
                  onPressed: () => goToLogin(),
                  child: new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: Text(
                            AppLocalizations.of(context).translate("login"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepPurpleAccent[400],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }

  Widget _buttonSignUp() {
    return new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  color: Colors.redAccent,
                  highlightedBorderColor: Colors.white,
                  onPressed: () => goToSignup(),
                  child: new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: Text(
                            AppLocalizations.of(context).translate("sign_up"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }

  Container _nameApp() {
    return Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Center(
            child: Image(
              image: AssetImage('assets/bunkalist-banner.png'),
              height: 65.0,
              fit: BoxFit.cover,
            ),
          ),
        );
  }

  Container _logoApp() {
    return Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Center(
            child: Image(
              image: AssetImage('assets/bunkalist-icon-trans.png'),
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
        );
  }



  goToLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.decelerate,
    );
  }

  goToSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.decelerate,
    );
  }
}



class ButtonSignInWithGoogle extends StatefulWidget {

  @override
  _ButtonSignInWithGoogleState createState() => _ButtonSignInWithGoogleState();
}

class _ButtonSignInWithGoogleState extends State<ButtonSignInWithGoogle> {
  @override
  Widget build(BuildContext context) {

    _pressedButtonSignInWithGoogle(){

      BlocProvider.of<LoginBloc>(context)..add(
         LoginWithGooglePressed(),
      );
       print('button sign with google pressed');
      
    }

     return BlocListener<LoginBloc, LoginState>(
      
      listener: (context, state){
        if(state.isSuccess){
          print('login success');
          _navigateToHome(context);
        }
      },


      child: Container(
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      width: MediaQuery.of(context).size.width,
      child: new RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0)),
        padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 1.0),
        color: const Color(0xFF4285F4),
        onPressed: () => _pressedButtonSignInWithGoogle(),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(
                'assets/btn_google.png',
                height: 48.0,
              ),
              SizedBox(width: 40.0,),
              new Container(
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                child: new Text(
                  AppLocalizations.of(context).translate("sign_with_google"),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                     fontSize: 16.0,
                     fontWeight: FontWeight.w700,
                     color: Colors.white 
                    )
                  ),
                )
              ),
              Spacer(),
            ],
          )
        ),
      )
     );
   
  }

  void _flushbarLoginError(){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.redAccent[700], Colors.redAccent[400]],),
      backgroundColor: Colors.red[500],
      boxShadows: [BoxShadow(color: Colors.red[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("email_or_password_empty"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
  }

  void _flushbarLoginSubmitting(){
     Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.blueAccent[700], Colors.blueAccent[400]],),
      backgroundColor: Colors.blue[500],
      boxShadows: [BoxShadow(color: Colors.blue[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("login_submitted"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
  }

  void _navigateToHome(BuildContext context){
     Navigator.pushNamedAndRemoveUntil(context, '/Home', (_) => false);
   } 
}