
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_login/bloc.dart';
import 'package:bunkalist/src/features/login/presentation/widgets/forgot_password_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      
      listener: (context, state){
        if(state.isFailure){
          print('login failure');
          _flushbarLoginError();
        }
        
        if(state.isSubmitting){
          print('login is loading');
          _flushbarLoginSubmitting();
        }
        
        if(state.isSuccess){
          print('login success');
          //Navigator.of(context).pushReplacementNamed('/Home');
          //Navigator.pushReplacementNamed(context, '/Home');
          _navigateToHome(context);
        }
      },


      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
          return Form(
            key: _formKey,
            child: new Container(        
      height: MediaQuery.of(context).size.height,
      decoration:  new BoxDecoration(
        gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
      child: ListView(
        children: <Widget>[
            SizedBox(height: 40.0,),          
            _iconApp(),
            _labelEmail(),
            _emailTextField(context, state),
            Divider(height: 16.0, color: Colors.transparent,),
            _labelPassword(),
            _passwordTextField(context, state),
            Divider(height: 16.0, color: Colors.transparent,),
            _buttonForGotPassword(),
            _buttonLogin(context, state),
            SizedBox(height: 6.0,),
        ],
      ),
    ),
          );
        },
      ),
    );


    
  }

   void _navigateToHome(BuildContext context){
     Navigator.pushNamedAndRemoveUntil(context, '/Home', (_) => false);
   } 

  Container _buttonLogin(BuildContext context, LoginState state) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new RaisedButton(
                    disabledColor: Colors.pinkAccent[700],
                    elevation: 10.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    color: Colors.pinkAccent[400],

                    onPressed: isLoginButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,

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

  Row _buttonForGotPassword() {
    return new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    AppLocalizations.of(context).translate("forgot_password"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent[400],
                      fontSize: 14.0,
                      shadows: [
                        Shadow(
                          color: Colors.blueGrey[900],
                          blurRadius: 0.5, 
                        )
                      ]
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => DialogForGotPassword().openDialog(context)

                    );
                  }               
                ),
              ),
            ],
          );
  }

  Container _passwordTextField(BuildContext context, LoginState state) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.pinkAccent,
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
                    validator: (String value) {
                       return !state.isPasswordValid ? AppLocalizations.of(context).translate("empty_password") : null;
                    },
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white, fontSize: 14.0 ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Row _labelPassword() {
    return new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    AppLocalizations.of(context).translate("password"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Container _emailTextField(BuildContext context, LoginState state) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.pinkAccent,
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
                      return !state.isEmailValid ? AppLocalizations.of(context).translate("empty_email") : null;
                    },
                    controller: _emailController,
                    obscureText: false,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 14.0 ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'something@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Row _labelEmail() {
    return new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    AppLocalizations.of(context).translate("email"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Container _iconApp() {
  
    return Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Image(
            image: AssetImage('assets/bunkalist-banner.png'),
            height: 55.0,
            fit: BoxFit.cover,
            
            ),
          ),
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


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

   void _onEmailChanged() {
    BlocProvider.of<LoginBloc>(context)..add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    BlocProvider.of<LoginBloc>(context)..add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    BlocProvider.of<LoginBloc>(context)..add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
  

  
}