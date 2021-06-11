import 'dart:convert';

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

  //? se en encarga de guardar el modo de tema blue oscuro
  get whatDarkBlue {
    return _prefs.getBool('whatDarkBlue') ?? false;
  }

  set whatDarkBlue (bool value) {
    _prefs.setBool('whatDarkBlue', value);
  }


  //? se en encarga de guardar el modo de tema oscuro
  get whatSepia {
    return _prefs.getBool('whatSepia') ?? false;
  }

  set whatSepia (bool value) {
    _prefs.setBool('whatSepia', value);
  }

  

  //? se en encarga de guardar el modo de tema 
  get isNotAds {
    return _prefs.getBool('isNotAds') ?? false;
  }

  set isNotAds (bool value) {
    _prefs.setBool('isNotAds', value);
  }

  //? se en encarga de guardar el modo de tema 
  get isNewUserPremium {
    return _prefs.getBool('isNewUserPremium') ?? true;
  }

  set isNewUserPremium (bool value) {
    _prefs.setBool('isNewUserPremium', value);
  }

  //? se en encarga de guardar el modo de tema 
  get isLanguageChanged {
    return _prefs.getBool('isLanguageChanged') ?? true;
  }

  set isLanguageChanged (bool value) {
    _prefs.setBool('isLanguageChanged', value);
  }


  //? se en encarga de guardar el language code 
  get getLanguage {
    return _prefs.getString('language') ?? 'en-US';
  }

  set getLanguage (String value) {
    _prefs.setString('language', value);
  }

  //? se en encarga de guardar el language code 
  get getLanguageCode {
    return _prefs.getString('languageCode') ?? 'en';
  }

  set getLanguageCode (String value) {
    _prefs.setString('languageCode', value);
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


  //? se en encarga de guradar el total de peliculas favoritas
  get totalMoviesFav {
    return _prefs.getInt('totalMoviesFav') ?? 0;
  }

  set totalMoviesFav (int value) {
    _prefs.setInt('totalMoviesFav', value);
  }

  //? se en encarga de guradar el total de series favoritas
  get totalSeriesFav {
    return _prefs.getInt('totalSeriesFav') ?? 0;
  }

  set totalSeriesFav (int value) {
    _prefs.setInt('totalSeriesFav', value);
  }

  //? se en encarga de guradar el total de animes favoritos
  get totalAnimesFav {
    return _prefs.getInt('totalAnimesFav') ?? 0;
  }

  set totalAnimesFav (int value) {
    _prefs.setInt('totalAnimesFav', value);
  }

  //? decide el diseño del watching
  get currentDesignWatching {
    return _prefs.getBool('DesignWatching') ?? false;
  }

  set currentDesignWatching (bool value) {
    _prefs.setBool('DesignWatching', value);
  }

  //? decide el diseño del historial
  get currentDesignHistory {
    return _prefs.getBool('DesignHistory') ?? false;
  }

  set currentDesignHistory (bool value) {
    _prefs.setBool('DesignHistory', value);
  }

  //? decide el diseño del wishlist
  get currentDesignWishlist {
    return _prefs.getBool('DesignWishlist') ?? false;
  }

  set currentDesignWishlist (bool value) {
    _prefs.setBool('DesignWishlist', value);
  }


  //? se en encarga de guardar los ids de las movies
  List<String> get listMoviesIds  {
    return _prefs.getStringList('listMoviesIds') ?? [];
  }

  set listMoviesIds (List<String> value) {
    _prefs.setStringList('listMoviesIds', value.toSet().toList());
  }

  //? se en encarga de guardar los ids de las series
  List<String> get listSerieIds  {
    return _prefs.getStringList('listSerieIds') ?? [];
  }

  set listSerieIds (List<String> value) {
    _prefs.setStringList('listSerieIds', value.toSet().toList());
  }

  //? se en encarga de guardar los ids de las animes
  List<String> get listAnimeIds  {
    return _prefs.getStringList('listAnimeIds') ?? [];
  }

  set listAnimeIds (List<String> value) {
    _prefs.setStringList('listAnimeIds', value.toSet().toList());
  }

  //? oculta las peliculas que tengas incluidas en tus listas
  get hideMoviesInList {
    return _prefs.getBool('hideMoviesInList') ?? true;
  }

  set hideMoviesInList (bool value) {
    _prefs.setBool('hideMoviesInList', value);
  }

  //? oculta las series que tengas incluidas en tus listas
  get hideSeriesInList {
    return _prefs.getBool('hideSeriesInList') ?? true;
  }

  set hideSeriesInList (bool value) {
    _prefs.setBool('hideSeriesInList', value);
  }

  //? oculta las animes que tengas incluidas en tus listas
  get hideAnimeInList {
    return _prefs.getBool('hideAnimeInList') ?? true;
  }

  set hideAnimeInList (bool value) {
    _prefs.setBool('hideAnimeInList', value);
  }
  

  //? se en encarga de guardar las veces que visita el perfil
  get totalVisitProfile {
    return _prefs.getInt('totalVisitProfile') ?? 0;
  }

  set totalVisitProfile (int value) {
    _prefs.setInt('totalVisitProfile', value);
  }

  //? se encarga de guardar object filter para home tops 1

  get getHomeTops1 {
    return json.decode(_prefs.getString('getHomeTops1')) ?? '';
  }

  set getHomeTops1  (dynamic value) {
    _prefs.setString('getHomeTops1', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 2

  get getHomeTops2 {
    return json.decode(_prefs.getString('getHomeTops2')) ?? '';
  }

  set getHomeTops2  (dynamic value) {
    _prefs.setString('getHomeTops2', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 3

  get getHomeTops3 {
    return json.decode(_prefs.getString('getHomeTops3')) ?? '';
  }

  set getHomeTops3  (dynamic value) {
    _prefs.setString('getHomeTops3', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 4

  get getHomeTops4 {
    return json.decode(_prefs.getString('getHomeTops4')) ?? '';
  }

  set getHomeTops4  (dynamic value) {
    _prefs.setString('getHomeTops4', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 5

  get getHomeTops5 {
    return json.decode(_prefs.getString('getHomeTops5')) ?? '';
  }

  set getHomeTops5  (dynamic value) {
    _prefs.setString('getHomeTops5', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 1

  get getHomeTops6 {
    return json.decode(_prefs.getString('getHomeTops6')) ?? '';
  }

  set getHomeTops6  (dynamic value) {
    _prefs.setString('getHomeTops6', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 7

  get getHomeTops7 {
    return json.decode(_prefs.getString('getHomeTops7')) ?? '';
  }

  set getHomeTops7  (dynamic value) {
    _prefs.setString('getHomeTops7', json.encode(value));
  }


  //? se encarga de guardar object filter para home tops 8

  get getHomeTops8 {
    return json.decode(_prefs.getString('getHomeTops8')) ?? '';
  }

  set getHomeTops8  (dynamic value) {
    _prefs.setString('getHomeTops8', json.encode(value));
  }

  //? se encarga de guardar object filter para home tops 9

  get getHomeTops9 {
    return json.decode(_prefs.getString('getHomeTops9')) ?? '';
  }

  set getHomeTops9  (dynamic value) {
    _prefs.setString('getHomeTops9', json.encode(value));
  }

  
  //? se en encarga de guardar cuantas columnas tienes en cuando se muestra la lista
  get totalColumnList {
    return _prefs.getInt('totalColumnList') ?? 3;
  }

  set totalColumnList (int value) {
    _prefs.setInt('totalColumnList', value);
  }


}