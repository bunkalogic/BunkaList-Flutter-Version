import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:flutter/material.dart';


class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key key}) : super(key: key);

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {

  Preferences prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_edit_profile")),
          leading: AppBarButtonBack(),
      ),
      body: _buildListOfItemLanguage(),
    );
  }

  Widget _buildListOfItemLanguage() {
    return ListView(
      children: [
        itemLanguage("Device Language", prefs.getLanguageOfDevice, prefs.getCountryCodeOfDevice),
        itemLanguage("English", "en", "US"),
        itemLanguage("Spanish", "es", "ES"),
        itemLanguage("Italian", "it", "IT"),
        itemLanguage("German", "de", "DE"),
        itemLanguage("French", "fr", "FR"),
        itemLanguage("Hindi", "hi", "IN"),
        itemLanguage("Japanase", "ja", "JP"),
        itemLanguage("Korean", "ko", "KR"),
        itemLanguage("Portuguese", "pt", "PT"),
        // itemLanguage("Indonesian", "id", "ID"),
        // itemLanguage("Russian", "ru", "RU"),
      ],
    );
  }

  Widget itemLanguage(String title, String codeLang, String codeCountry){
    final String theLanguage = '$codeLang-$codeCountry';

    return ListTile(
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.deepPurpleAccent[400],
        size: 28.0,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: (prefs.getLanguage == theLanguage) ? FontWeight.w800 : FontWeight.w400,
        ),
      ),
      selected: (prefs.getLanguage == theLanguage) ? true : false,
      onTap: (){
        Locale locale = new Locale(
          '$codeLang',
          '$codeCountry'
        );

        AppLocalizations.of(context).changeLang(locale);

        prefs.getLanguage = theLanguage;
        prefs.getCountryCode = codeCountry;

        setState(() {});

        Navigator.pop(context, true);
      },
    );
  }
}