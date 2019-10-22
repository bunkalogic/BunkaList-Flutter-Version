import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange[300],
              Colors.orange[400], 
              Colors.orange[500], 
              Colors.orange[600],
              Colors.orange[700], 
              Colors.orange[800],
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
          _buttonSignUp(context),
        ],
      ),
    );
  }

  Container _buttonSignUp(BuildContext context) {
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
                    onPressed: () => {},
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
                              "SIGN UP",
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
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent[700],
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
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
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
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
                    "CONFIRM PASSWORD",
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
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey[300]),
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
                    "PASSWORD",
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
                    "EMAIL",
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
              image: AssetImage('assets/launcher-trans-purple.png'),
              height: 140.0,
              fit: BoxFit.cover,
              width: 100.0,
              ),
            ),
          );
  }
}