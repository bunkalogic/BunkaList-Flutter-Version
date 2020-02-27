import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_login/bloc.dart';
import 'package:bunkalist/src/features/login/presentation/pages/base_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var passKey = GlobalKey<FormFieldState>();
  
  @override
  Widget build(BuildContext context) {

    

    return BlocListener<LoginBloc, LoginState>(
      
      listener: (context, state){
        if(state is LoginFailure){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if(state is LoginLoading){
          print('login is loading');
        }
        
        if(state is LoginSuccess){
           Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).translate("email_verification")),
              backgroundColor: Colors.greenAccent[400],
            ),
          );
          
        }
      },

      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){

          return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              //Colors.orange[300],
              //Colors.orange[400], 
              //Colors.orange[500], 
              //Colors.orange[600],
              Colors.orange[500], 
              Colors.orange[700],
              Colors.orange[900], 
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
      child: ListView(
        children: <Widget>[
          _iconApp(),
          _labelEmail(),
          _emailTextField(context),
          Divider(
            height: 24.0, color: Colors.transparent,
          ),
          _labelPassword(),
          _passwordTextField(context),
          Divider(
            height: 24.0, color: Colors.transparent,
          ),
          _labelConfirmPassword(),
          _confirmPasswordTextField(context),
          Divider(
            height: 24.0, color: Colors.transparent,
          ),
          _buttonHaveAccount(),
          _buttonSignUp(context, state),
          SizedBox(height: 6.0,),
          Container(
            child: Center(
              child: state is LoginLoading
              ? CircularProgressIndicator()
              : null,
            ),
          ),
        ],
      ),
    );
        },
      ),
    );

    
  }

  _onSignUpButtonPressed(){

    if(passKey.currentState.validate() != true){

        Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).translate("password_error")),
              backgroundColor: Colors.redAccent[700],
            ),
          );
      }

    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && passKey.currentState.validate()){
      
      BlocProvider.of<LoginBloc>(context)..add(
        SignInButtonPressed(
          email: _emailController.text, 
          password: _passwordController.text
        )
      );

    }else{

        Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).translate("email_or_password_empty")),
              backgroundColor: Colors.redAccent[400],
            ),
          );
      }
      
      
    }

  Container _buttonSignUp(BuildContext context, LoginState state) {
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
                    onPressed: state is! LoginLoading ? _onSignUpButtonPressed: null,
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
                    // TODO: ir al login widget 
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

  Container _passwordTextField(BuildContext context) {
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
                      var result = password.length < 8 ? AppLocalizations.of(context).translate("password_lenght") : null;
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

  Container _emailTextField(BuildContext context) {
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
                  child: TextField(
                    controller: _emailController,
                    obscureText: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'something@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey[300]),
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
}