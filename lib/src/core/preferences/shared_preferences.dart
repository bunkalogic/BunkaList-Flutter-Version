import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:enum_to_string/enum_to_string.dart';
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
  get isOpenFirstTime {
    return _prefs.getBool('isOpenFirstTime') ?? true;
  }
  
  set isOpenFirstTime (bool value) {
    _prefs.setBool('isOpenFirstTime', value);
  }

  //? se en encarga de guardar el modo de tema 
  get whatModeIs {
    return _prefs.getBool('whatModeIs') ?? false;
  }

  set whatModeIs (bool value) {
    _prefs.setBool('whatModeIs', value);
  }

  //? se en encarga de guardar el modo de tema oscuro
  get whatDarkIs {
    return _prefs.getBool('whatDarkIs') ?? false;
  }

  set whatDarkIs (bool value) {
    _prefs.setBool('whatDarkIs', value);
  }

  //? se en encarga de guardar el modo de tema 
  get isNotAds {
    return _prefs.getBool('isNotAds') ?? false;
  }

  set isNotAds (bool value) {
    _prefs.setBool('isNotAds', value);
  }

  //? se en encarga de guardar el language code 
  get getLanguage {
    return _prefs.getString('language') ?? 'en';
  }

  set getLanguage (String value) {
    _prefs.setString('language', value);
  }

  
  //? se en encarga de guardar el language code 
  get getCountryCode {
    return _prefs.getString('countryCode') ?? 'US';
  }

  set getCountryCode (String value) {
    _prefs.setString('countryCode', value);
  }

  //? se en encarga de guardar el language code 
  get getLanguageOfDevice {
    return _prefs.getString('languageOfDevice') ?? 'en';
  }

  set getLanguageOfDevice (String value) {
    _prefs.setString('languageOfDevice', value);
  }

  
  //? se en encarga de guardar el language code 
  get getCountryCodeOfDevice  {
    return _prefs.getString('countryCodeOfDevice') ?? 'US';
  }

  set getCountryCodeOfDevice (String value) {
    _prefs.setString('countryCodeOfDevice', value);
  }

  //? se encarga de guardar current User Id

  get getCurrentUserUid {
    return _prefs.getString('currentUserUid') ?? '';
  }

  set getCurrentUserUid  (String value) {
    _prefs.setString('currentUserUid', value);
  }

  //? se encarga de guardar la guest session id de TMDb

  get getGuestSessionId {
    return _prefs.getString('guestSessionId') ?? '';
  }

  set getGuestSessionId  (String value) {
    _prefs.setString('guestSessionId', value);
  }

  //? se encarga de guardar current Username

  get getCurrentUsername {
    return _prefs.getString('currentUsername') ?? '';
  }

  set getCurrentUsername  (String value) {
    _prefs.setString('currentUsername', value);
  }

  //? se encarga de guardar current Username

  get getCurrentUserPhoto {
    return _prefs.getString('currentUserPhoto') ?? '';
  }

  set getCurrentUserPhoto  (String value) {
    _prefs.setString('currentUserPhoto', value);
  }

  //? se en encarga de saber si tiene token el usuario 
  get currentUserHasToken {
    return _prefs.getBool('hasToken') ?? false;
  }

  set currentUserHasToken (bool value) {
    _prefs.setBool('hasToken', value);
  }

  //? se encarga de guardar el Enum filterListCompleted

  get getfilterListCompleted {
    
    return EnumToString.fromString(ListProfileQuery.values, _prefs.getString('filterListCompleted') ?? EnumToString.convertToString(ListProfileQuery.Completed) );
    // return _prefs.getString('filterListCompleted') ?? '';
  }

  set getfilterListCompleted  (ListProfileQuery value) {
    _prefs.setString('filterListCompleted', EnumToString.convertToString(value));
  }
}