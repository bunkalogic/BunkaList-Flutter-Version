import 'package:flutter/material.dart';

class DialogForGotPassword{

  Widget openDialog(){
    return SimpleDialog(
      backgroundColor: Colors.purpleAccent[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      elevation: 5.0,
      contentPadding: EdgeInsets.all(10.0),
      title: Text('Restore Password', textAlign: TextAlign.center,),
      titlePadding: EdgeInsets.all(5.0),
      children: <Widget>[
        _labelEmail(),
        _emailTextField(),
        _buttonLogin()
      ],
    );
  }

  Container _emailTextField() {
    return new Container(
            width: 20.0,
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
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
                      color: Colors.deepOrangeAccent,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Container _buttonLogin() {
    return new Container(
            width: 20.0,
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    color: Colors.orange[900],
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
                              "RESTORE PASSWORD",
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

}