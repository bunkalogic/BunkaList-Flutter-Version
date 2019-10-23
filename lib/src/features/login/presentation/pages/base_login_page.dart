import 'package:bunkalist/src/features/login/presentation/widgets/login_widget.dart';
import 'package:bunkalist/src/features/login/presentation/widgets/signup_widget.dart';
import 'package:flutter/material.dart';


class LoginHomePage extends StatefulWidget {

  @override
  _LoginHomePageState createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {

  PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);//!FIXME: initial page : 1

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
        LoginWidget(),
        _baseLogin(context),
        SignUpWidget()
      ],
    );
  }

  _baseLogin(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple[900],
            Colors.purple[800], 
            Colors.purple[700], 
            Colors.purple[600],
            Colors.purple[500], 
            Colors.purple[400],
            Colors.purple[300], 
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: ListView(
        children: <Widget>[
          _logoApp(),
          _nameApp(),
          _buttonSignUp(),
          _buttonLogin(),
          _borderWithConnect(context),
          _buttonConnectWithGoogle(context)
        ],
      ),
    );
  }

  Container _buttonConnectWithGoogle(BuildContext context) {
    return new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(left: 8.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            color: Color(0Xffdb3236),
                            onPressed: () => {},
                            child: new Container(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: new FlatButton(
                                      onPressed: ()=> Navigator.pushNamed(context, '/'),
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(
                                            const IconData(0xea88,
                                                fontFamily: 'icomoon'),
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                          Text(
                                            "WITH GOOGLE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  "OR CONNECT WITH",
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

  Container _buttonLogin() {
    return new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
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
                            "LOGIN",
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

  Container _buttonSignUp() {
    return new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
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

  Container _nameApp() {
    return Container(
          padding: EdgeInsets.only(top: 5.0),
          child: Center(
            child: Image(
              image: AssetImage('assets/bunkalist-banner.png'),
              height: 140.0,
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