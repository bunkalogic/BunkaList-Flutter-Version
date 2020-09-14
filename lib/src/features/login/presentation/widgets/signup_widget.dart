import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_register/register_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  
  final TextEditingController  _emailController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();
  var passKey = GlobalKey<FormFieldState>();


   bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
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
    

    return BlocListener<RegisterBloc, RegisterState>(
      
      listener: (context, state){
        if(state.isFailure){
         _flushbarRegisterError();
        }

        if(state.isSubmitting){
          print('Register is loading');
          _flushbarRegisterSubmitting();
        }
        
        if(state.isSuccess){
           _getFlushbarSuccessRegister(context);
          
        }
      },

      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state){

          return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.amberAccent[400],
              Colors.orangeAccent[700],
              Colors.pinkAccent
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
      child: ListView(
        children: <Widget>[
          _iconApp(),
          _labelEmail(),
          _emailTextField(context, state),
          Divider(
            height: 24.0, color: Colors.transparent,
          ),
          _labelPassword(),
          _passwordTextField(context, state),
          Divider(
            height: 24.0, color: Colors.transparent,
          ),
          _labelConfirmPassword(),
          _confirmPasswordTextField(context),
          Divider(
            height: 24.0, color: Colors.transparent,
          ),
          //_buttonHaveAccount(),
          _buttonSignUp(context, state),
          SizedBox(height: 6.0,),
        ],
      ),
    );
        },
      ),
    );

    
  }


  Container _buttonSignUp(BuildContext context, RegisterState state) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    color: Colors.purpleAccent[700],
                    onPressed: isRegisterButtonEnabled(state)
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

  Row _buttonHaveAccount() {
    return new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    AppLocalizations.of(context).translate("have_account"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent[700],
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed:(){
                    // TODO: ir al Register widget 
                  },
                ),
              ),
            ],
          );
  }

  Container _confirmPasswordTextField(BuildContext context) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.purpleAccent[700],
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
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
                    validator: (confirmation){
                      var password = passKey.currentState.value;
                      return (confirmation == password) ? null : AppLocalizations.of(context).translate("password_error");
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Row _labelConfirmPassword() {
    return new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    AppLocalizations.of(context).translate("confirm_password"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent[700],
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Container _passwordTextField(BuildContext context, RegisterState state) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.purpleAccent[700],
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
                    controller: _passwordController,
                    key: passKey,
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
                    validator:  (password){
                      var result =  !state.isPasswordValid ? AppLocalizations.of(context).translate("password_lenght") : null;
                      return result;
                    },
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
                      color: Colors.purpleAccent[700],
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Container _emailTextField(BuildContext context, RegisterState state) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.purpleAccent[700],
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
                    controller: _emailController,
                    obscureText: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'something@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    }
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
                      color: Colors.purpleAccent[700],
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
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Image(
              image: AssetImage('assets/bunkalist-banner-purple.png'),
              height: 100.0,
              fit: BoxFit.cover,
              
              ),
            ),
          );
  }

  void _flushbarRegisterError(){
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

  void _flushbarRegisterSubmitting(){
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

   void _getFlushbarSuccessRegister(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 100.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.greenAccent[700], Colors.greenAccent[400]],),
      backgroundColor: Colors.green[500],
      boxShadows: [BoxShadow(color: Colors.green[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("email_verification"),
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
    BlocProvider.of<RegisterBloc>(context)..add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    BlocProvider.of<RegisterBloc>(context)..add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    BlocProvider.of<RegisterBloc>(context)..add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}