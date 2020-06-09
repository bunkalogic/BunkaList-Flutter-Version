import 'package:bunkalist/src/core/constans/constans_genres_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class ChipsGenresWidget extends StatefulWidget {
  final List<int> genres;
  
  ChipsGenresWidget({@required this.genres});

  @override
  _ChipsGenresWidgetState createState() => _ChipsGenresWidgetState();
}


class _ChipsGenresWidgetState extends State<ChipsGenresWidget> {
  //final double _aspectRatio =  0.9;
  List<String> _listGenres = new List<String>();
  
  @override
  Widget build(BuildContext context) {


    List<String> _listGenres = _getNameGenres(context, widget.genres);

     return Wrap(
       alignment: WrapAlignment.spaceEvenly,
       spacing: 1.0,
       runSpacing: 1.0,
       crossAxisAlignment: WrapCrossAlignment.center,
       
       direction: Axis.horizontal,
       children: _chipsGenres(_listGenres),

     );
  }

  List<String> _getNameGenres(BuildContext context ,List<int> genres){

    final List<String> nameGenres = new List<String>();

    for(int item in genres){

      switch(item){

        case ConstGenres.action:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_action'));
        }
        break;
        case ConstGenres.adventure:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_adventure'));
        }
        break;
        case ConstGenres.animation:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_animation'));
        }
        break;
        case ConstGenres.comedy:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_comedy'));
        }
        break;
        case ConstGenres.crime:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_crime'));
        }
        break;
        case ConstGenres.documentary:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_documentary'));
        }
        break;
        case ConstGenres.drama:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_drama'));
        }
        break;
        case ConstGenres.family:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_family'));
        }
        break;
        case ConstGenres.fantasy:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_fantasy'));
        }
        break;
        case ConstGenres.history:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_history'));
        }
        break;
        case ConstGenres.horror:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_horror'));      
        }
        break;
        case ConstGenres.music:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_musical'));
        }
        break;
        case ConstGenres.mistery:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_mistery'));
        }
        break;
        case ConstGenres.romance:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_romance'));
        }
        break;
        case ConstGenres.sciFi:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_scifi'));
        }
        break;
        case ConstGenres.thriller:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_thriller'));
        }
        break;
        case ConstGenres.war:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_war'));    
        }
        break;
        case ConstGenres.western:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_western'));
        }
        break;
        case ConstGenres.actionAndAveture:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_action_and_adventure')); 
        }
        break;
        case ConstGenres.kids:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_kids'));
        }
        break;
        case ConstGenres.sciFiAndFantasy:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_scifi_fantasy'));
        }
        break;
        case ConstGenres.soap:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_soap'));
        }
        break;
        case ConstGenres.warAndPolitics:{
          nameGenres.add(AppLocalizations.of(context).translate('genre_war_politics'));
        }
        break;
      }
    }

      return nameGenres;
  }


  List<Widget> _chipsGenres(List<String> genres){

    List<Widget> genresChipList = new List();


    genres.forEach((item){
      genresChipList.add(
        Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: ActionChip(
          onPressed: () => null,
          elevation: 4.0,
          labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
          backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
          label: Text(item,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
      );
    });
     
     return genresChipList;
  }

  Widget _fakeChip(String text, Color color) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: text.length.toDouble() + 1, vertical: 40.0 ),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          //overflow: TextOverflow.ellipsis, 
          textAlign: TextAlign.center, 
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600), 
        ),
      ),
    );
  }

  Widget _buttonChip(String title, Color color){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: RaisedButton(
        disabledColor: color,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        onPressed: null,
        color: color,
        child: Text(
          title,
          textAlign: TextAlign.center, 
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),       
        ),
      ),
    );
  }

}