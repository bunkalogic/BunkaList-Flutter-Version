import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class WatchProvider extends Equatable {
    
    final int id;
    final Results results;

    
    WatchProvider({
      @required this.id,
      @required this.results,
    }) : super([
      id,
      results
    ]);

    
}

class Results extends Equatable {
    
    final Ar ar;
    final Ar at;
    final Ar au;
    final Ar be;
    final Ar br;
    final Ar ca;
    final Ar ch;
    final Ar cl;
    final Ar co;
    final Ar cz;
    final Ar de;
    final Ar dk;
    final Ar ec;
    final Ar ee;
    final Ar es;
    final Ar fi;
    final Ar fr;
    final Ar gb;
    final Ar gr;
    final Ar hu;
    final Ar id;
    final Ar ie;
    final Ar en;
    final Ar it;
    final Ar jp;
    final Ar kr;
    final Ar lt;
    final Ar lv;
    final Ar mx;
    final Ar my;
    final Ar nl;
    final Ar no;
    final Ar nz;
    final Ar pe;
    final Ar ph;
    final Ar pl;
    final Ar pt;
    final Ar ro;
    final Ar ru;
    final Ar se;
    final Ar sg;
    final Ar th;
    final Ar tr;
    final Ar us;
    final Ar ve;
    final Ar za;
    
    Results({
        @required this.ar,
        @required this.at,
        @required this.au,
        @required this.be,
        @required this.br,
        @required this.ca,
        @required this.ch,
        @required this.cl,
        @required this.co,
        @required this.cz,
        @required this.de,
        @required this.dk,
        @required this.ec,
        @required this.ee,
        @required this.es,
        @required this.fi,
        @required this.fr,
        @required this.gb,
        @required this.gr,
        @required this.hu,
        @required this.id,
        @required this.ie,
        @required this.en,
        @required this.it,
        @required this.jp,
        @required this.kr,
        @required this.lt,
        @required this.lv,
        @required this.mx,
        @required this.my,
        @required this.nl,
        @required this.no,
        @required this.nz,
        @required this.pe,
        @required this.ph,
        @required this.pl,
        @required this.pt,
        @required this.ro,
        @required this.ru,
        @required this.se,
        @required this.sg,
        @required this.th,
        @required this.tr,
        @required this.us,
        @required this.ve,
        @required this.za,
    }) : super([
      ar,
      at,
      au,
      be,
      br,
      ca,
      ch,
      cl,
      co,
      cz,
      de,
      dk,
      ec,
      ee,
      es,
      fi,
      fr,
      gb,
      gr,
      hu,
      id,
      ie,
      en,
      it,
      jp,
      kr,
      lt,
      lv,
      mx,
      my,
      nl,
      no,
      nz,
      pe,
      ph,
      pl,
      pt,
      ro,
      ru,
      se,
      sg,
      th,
      tr,
      us,
      ve,
      za,
    ]);

    
}

class Ar extends Equatable {
    
    final String link;
    final List<Buy> flatrate;
    final List<Buy> rent;
    final List<Buy> buy;
    
    Ar({
        @required this.link,
        @required this.flatrate,
        @required this.rent,
        @required this.buy,
    }) : super([
      link,
      flatrate,
      rent,
      buy,
    ]);

    
}

class Buy extends Equatable {

  final int displayPriority;
  final String logoPath;
  final int providerId;
  final String providerName;

    Buy({
        @required this.displayPriority,
        @required this.logoPath,
        @required this.providerId,
        @required this.providerName,
    }): super([
      displayPriority,
      logoPath,
      providerId,
      providerName,
    ]);

   
}


