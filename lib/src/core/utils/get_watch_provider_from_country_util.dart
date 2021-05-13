import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';


Ar getWatchProviderFromCountry({Results results}){


  final Preferences prefs = new Preferences();

  final String countryCode = prefs.getCountryCode;

  switch (countryCode) {
    
    case "AR": return results.ar;

    break;

    case "AT": return results.at;

    break;

    case "AU": return results.au;

    break;

    case "BE": return results.be;

    break;

    case "BR": return results.br;

    break;

    case "CA": return results.ca;

    break;

    case "CH": return results.ch;

    break;

    case "CL": return results.cl;

    break;

    case "CO": return results.co;

    break;

    case "CZ": return results.cz;

    break;

    case "DE": return results.de;

    break;

    case "DK": return results.dk;

    break;

    case "EC": return results.ec;

    break;

    case "EE": return results.ee;

    break;

    case "ES": return results.es;

    break;

    case "FI": return results.fi;

    break;

    case "FR": return results.fr;

    break;

    case "GB": return results.gb;

    break;

    case "GR": return results.gr;

    break;

    case "HU": return results.hu;

    break;

    case "ID": return results.id;

    break;

    case "IE": return results.ie;

    break;

    case "IN": return results.en;

    break;

    case "IT": return results.it;

    break;

    case "JP": return results.jp;

    break;

    case "KR": return results.kr;

    break;

    case "LT": return results.lt;

    break;

    case "LV": return results.lv;

    break;

    case "MX": return results.mx;

    break;

    case "MY": return results.my;

    break;

    case "NL": return results.nl;

    break;

    case "NO": return results.no;

    break;

    case "NZ": return results.nz;

    break;

    case "PE": return results.pe;

    break;

    case "PH": return results.ph;

    break;

    case "PL": return results.pl;

    break;

    case "PT": return results.pt;

    break;

    case "RO": return results.ro;

    break;

    case "RU": return results.ru;

    break;

    case "SE": return results.se;

    break;

    case "SG": return results.sg;

    break;

    case "TH": return results.th;

    break;

    case "TR": return results.tr;

    break;

    case "US": return results.us;

    break;

    case "VE": return results.za;

    break;

    case "ZA": return results.za;

    break;

    default: return results.us;
  }


}