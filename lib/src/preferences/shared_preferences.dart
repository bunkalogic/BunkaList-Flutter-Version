import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static final  Preferences _instance = new Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  //? se en encarga de guardar el modo de tema 
  get whatModeIs {
    return _prefs.getBool('whatModeIs') ?? false;
  }

  set whatModeIs (bool value) {
    _prefs.setBool('whatModeIs', value);
  }



}