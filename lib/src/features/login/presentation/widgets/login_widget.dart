import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_login/bloc.dart';
import 'package:bunkalist/src/features/login/presentation/widgets/forgot_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    

    return BlocListener<LoginBloc, LoginState>(
      
      listener: (context, state){
        if(state is LoginFailure){
          print('login failure');
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.redAccent[400],
            ),
          );
        }
        
        if(state is LoginLoading){
          print('login is loading');
        }
        
        if(state is LoginSuccess){
          print('login success');
          Navigator.pushReplacementNamed(context, '/Home');
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              //Colors.purple[300],
              //Colors.purple[400], 
              //Colors.purple[500], 
              //Colors.purple[600],
              Colors.purple[900], 
              Colors.purple[700],
              Colors.purple[500], 
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: ListView(
        children: <Widget>[
            _iconApp(),
            _labelEmail(),
            _emailTextField(context),
            Divider(height: 16.0, color: Colors.transparent,),
            _labelPassword(),
            _passwordTextField(context),
            Divider(height: 16.0, color: Colors.transparent,),
            _buttonForGotPassword(),
            _buttonLogin(context, state),
            SizedBox(height: 6.0,),
             Container( 
              child: Center(
                child: state is LoginLoading
              ? CircularProgressIndicator()
              : null,
              )
            ),
        ],
      ),
    ),
          );
        },
      ),
    );


    
  }


  void _onLoginButtonPressed(){

      if(!_formKey.currentState.validate()){
        Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).translate("email_or_password_empty")),
              backgroundColor: Colors.deepOrangeAccent[400],
            ),
          );
      }
    
      if(_emailController.text.isNotEmpty &&  _passwordController.text.isNotEmpty && _formKey.currentState.validate()){
  
        BlocProvider.of<LoginBloc>(context)..add(
        LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text)
      );
       print('button login pressed');
      }
      
    }

  Container _buttonLogin(BuildContext context, LoginState state) {
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
                    color: Colors.orange[900],
                    onPressed: state is! LoginLoading ? _onLoginButtonPressed: null,
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
                      color: Colors.deepOrangeAccent[400],
                      fontSize: 14.0,
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

  Container _passwordTextField(BuildContext context) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
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
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).translate("empty_password");
                      }
                        return null;
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
                      color: Colors.deepOrangeAccent,
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
                    color: Colors.deepOrangeAccent,
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
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).translate("empty_email");
                      }
                        return null;
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
                      color: Colors.deepOrangeAccent,
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
            height: 100.0,
            fit: BoxFit.cover,
            
            ),
          ),
          );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  

  
}