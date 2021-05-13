
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';
import 'package:meta/meta.dart';



class WatchProviderModel extends WatchProvider {
    WatchProviderModel({
        @required this.id,
        @required this.results,
    });

    final int id;
    final ResultsModel results;

    factory WatchProviderModel.fromJson(Map<String, dynamic> json) => WatchProviderModel(
        id: json["id"],
        results: ResultsModel.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": results.toJson(),
    };
}

class ResultsModel extends Results {
    ResultsModel({
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
    });

    final ArModel ar;
    final ArModel at;
    final ArModel au;
    final ArModel be;
    final ArModel br;
    final ArModel ca;
    final ArModel ch;
    final ArModel cl;
    final ArModel co;
    final ArModel cz;
    final ArModel de;
    final ArModel dk;
    final ArModel ec;
    final ArModel ee;
    final ArModel es;
    final ArModel fi;
    final ArModel fr;
    final ArModel gb;
    final ArModel gr;
    final ArModel hu;
    final ArModel id;
    final ArModel ie;
    final ArModel en;
    final ArModel it;
    final ArModel jp;
    final ArModel kr;
    final ArModel lt;
    final ArModel lv;
    final ArModel mx;
    final ArModel my;
    final ArModel nl;
    final ArModel no;
    final ArModel nz;
    final ArModel pe;
    final ArModel ph;
    final ArModel pl;
    final ArModel pt;
    final ArModel ro;
    final ArModel ru;
    final ArModel se;
    final ArModel sg;
    final ArModel th;
    final ArModel tr;
    final ArModel us;
    final ArModel ve;
    final ArModel za;

    factory ResultsModel.fromJson(Map<String, dynamic> json) => ResultsModel(
        ar: json["AR"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["AR"]),
        at: json["AT"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["AT"]),
        au: json["AU"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["AU"]),
        be: json["BE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["BE"]),
        br: json["BR"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["BR"]),
        ca: json["CA"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["CA"]),
        ch: json["CH"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["CH"]),
        cl: json["CL"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["CL"]),
        co: json["CO"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["CO"]),
        cz: json["CZ"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["CZ"]),
        de: json["DE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["DE"]),
        dk: json["DK"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["DK"]),
        ec: json["EC"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["EC"]),
        ee: json["EE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["EE"]),
        es: json["ES"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["ES"]),
        fi: json["FI"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["FI"]),
        fr: json["FR"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["FR"]),
        gb: json["GB"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["GB"]),
        gr: json["GR"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["GR"]),
        hu: json["HU"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["HU"]),
        id: json["ID"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["ID"]),
        ie: json["IE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["IE"]),
        en: json["IN"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["IN"]),
        it: json["IT"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["IT"]),
        jp: json["JP"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["JP"]),
        kr: json["KR"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["KR"]),
        lt: json["LT"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["LT"]),
        lv: json["LV"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["LV"]),
        mx: json["MX"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["MX"]),
        my: json["MY"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["MY"]),
        nl: json["NL"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["NL"]),
        no: json["NO"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["NO"]),
        nz: json["NZ"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["NZ"]),
        pe: json["PE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["PE"]),
        ph: json["PH"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["PH"]),
        pl: json["PL"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["PL"]),
        pt: json["PT"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["PT"]),
        ro: json["RO"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["RO"]),
        ru: json["RU"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["RU"]),
        se: json["SE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["SE"]),
        sg: json["SG"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["SG"]),
        th: json["TH"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["TH"]),
        tr: json["TR"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["TR"]),
        us: json["US"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["US"]),
        ve: json["VE"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["VE"]),
        za: json["ZA"] == null ? ArModel(link: '', buyModel: [], flatrate: [], rent: []) : ArModel.fromJson(json["ZA"]),
    );

    Map<String, dynamic> toJson() => {
        "AR": ar.toJson(),
        "AT": at.toJson(),
        "AU": au.toJson(),
        "BE": be.toJson(),
        "BR": br.toJson(),
        "CA": ca.toJson(),
        "CH": ch.toJson(),
        "CL": cl.toJson(),
        "CO": co.toJson(),
        "CZ": cz.toJson(),
        "DE": de.toJson(),
        "DK": dk.toJson(),
        "EC": ec.toJson(),
        "EE": ee.toJson(),
        "ES": es.toJson(),
        "FI": fi.toJson(),
        "FR": fr.toJson(),
        "GB": gb.toJson(),
        "GR": gr.toJson(),
        "HU": hu.toJson(),
        "ID": id.toJson(),
        "IE": ie.toJson(),
        "IN": en.toJson(),
        "IT": it.toJson(),
        "JP": jp.toJson(),
        "KR": kr.toJson(),
        "LT": lt.toJson(),
        "LV": lv.toJson(),
        "MX": mx.toJson(),
        "MY": my.toJson(),
        "NL": nl.toJson(),
        "NO": no.toJson(),
        "NZ": nz.toJson(),
        "PE": pe.toJson(),
        "PH": ph.toJson(),
        "PL": pl.toJson(),
        "PT": pt.toJson(),
        "RO": ro.toJson(),
        "RU": ru.toJson(),
        "SE": se.toJson(),
        "SG": sg.toJson(),
        "TH": th.toJson(),
        "TR": tr.toJson(),
        "US": us.toJson(),
        "VE": ve.toJson(),
        "ZA": za.toJson(),
    };
}

class ArModel extends Ar {
    ArModel({
        @required this.link,
        @required this.flatrate,
        @required this.rent,
        @required this.buyModel,
    });

    final String link;
    final List<BuyModel> flatrate;
    final List<BuyModel> rent;
    final List<BuyModel> buyModel;

    factory ArModel.fromJson(Map<String, dynamic> json) => ArModel(
        flatrate: json["flatrate"] == null ? [] : List<BuyModel>.from(json["flatrate"].map((x) => BuyModel.fromJson(x))),
        rent:     json["rent"] == null ? [] : List<BuyModel>.from(json["rent"].map((x) => BuyModel.fromJson(x))),
        buyModel: json["buy"] == null ? [] : List<BuyModel>.from(json["buy"].map((x) => BuyModel.fromJson(x))),
        link:     json["link"],
    );

    Map<String, dynamic> toJson() => {
        "link": link,
        "flatrate": flatrate == null ? null : List<dynamic>.from(flatrate.map((x) => x.toJson())),
        "rent": rent == null ? null : List<dynamic>.from(rent.map((x) => x.toJson())),
        "buy": List<dynamic>.from(buyModel.map((x) => x.toJson())),
    };
}

class BuyModel extends Buy {
    BuyModel({
        @required this.displayPriority,
        @required this.logoPath,
        @required this.providerId,
        @required this.providerName,
    });

    final int displayPriority;
    final String logoPath;
    final int providerId;
    final String providerName;

    factory BuyModel.fromJson(Map<String, dynamic> json) => BuyModel(
        displayPriority: json["display_priority"],
        logoPath: json["logo_path"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
    );

    Map<String, dynamic> toJson() => {
        "display_priority": displayPriority,
        "logo_path": logoPath,
        "provider_id": providerId,
        "provider_name": providerName,
    };
}



