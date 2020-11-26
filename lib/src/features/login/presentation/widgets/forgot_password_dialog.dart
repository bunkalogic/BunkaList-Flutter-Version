import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DialogForGotPassword{

  final emailController = TextEditingController();

  Widget openDialog(BuildContext context){
    return SimpleDialog(
      backgroundColor: Colors.deepPurpleAccent[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 5.0,
      contentPadding: EdgeInsets.all(10.0),
      title: Text(
        AppLocalizations.of(context).translate("reset_password"), 
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      titlePadding: EdgeInsets.all(5.0),
      children: <Widget>[
        _labelEmail(context),
        _emailTextField(),
        _buttonLogin(context)
      ],
    );
  }

  Container _emailTextField() {
    return new Container(
            width: 20.0,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
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
                  child: TextField(
                    controller: emailController,
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

  Row _labelEmail(BuildContext context) {
    return new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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

  Container _buttonLogin(BuildContext context) {
    return new Container(
            width: 15.0,
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    color: Colors.pinkAccent[400],
                    onPressed: () => _buttonPressedResetPassword(context, emailController.text),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 15.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              AppLocalizations.of(context).translate("reset_password"),
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

  void _buttonPressedResetPassword(BuildContext context, String email) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if(email.isNotEmpty){
      await _auth.sendPasswordResetEmail(email: email);
    }
    

    Navigator.pop(context);  
  }

}