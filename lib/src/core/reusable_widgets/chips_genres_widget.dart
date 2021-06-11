import 'package:bunkalist/src/core/constans/constans_genres_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:flutter/material.dart';


class ChipsGenresWidget extends StatefulWidget {
  final String type;
  final List<int> genres;
  final bool isWrap;
  
  ChipsGenresWidget({@required this.genres, @required this.type, @required this.isWrap});

  @override
  _ChipsGenresWidgetState createState() => _ChipsGenresWidgetState();
}


class _ChipsGenresWidgetState extends State<ChipsGenresWidget> {
  //final double _aspectRatio =  0.9;
  List<String> _listGenres = [];
  
  @override
  Widget build(BuildContext context) {

    if(widget.genres.isEmpty) return Container();

    List<String> _listGenres = _getNameGenres(context, widget.genres);

    if(widget.isWrap){

       return Wrap(
       alignment: WrapAlignment.spaceEvenly,
       spacing: 1.0,
       runSpacing: 1.0,
       crossAxisAlignment: WrapCrossAlignment.center,
       
       direction: Axis.horizontal,
       children: _chipsGenres(_listGenres),

     );

    }


    

    return Container(
      height: 35.0,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        itemBuilder: (context, i) =>  _buildChipsGenres(_listGenres[i], i)
      ),
    );

    
  }

  Widget _buildChipsGenres(String genre, int i){

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ActionChip(
          onPressed: () {
            Genres genresData = new Genres(
              id: widget.genres[i].toString(),
              label: genre,
              isKeyword: false,
              type: widget.type
            );

            Navigator.pushNamed(context, '/ExplorerGenre', arguments: genresData);
          },
          elevation: 4.0,
          labelPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          backgroundColor: getBackgroundColorItemTheme(),
          label: Text(genre,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
    );
  }

  List<String> _getNameGenres(BuildContext context ,List<int> genres){

    final List<String> nameGenres = [];

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

    List<Widget> genresChipList = [];

    for (var i = 0; i < genres.length; i++) {
      
      genresChipList.add(
        Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: ActionChip(
          onPressed: () {
            Genres genresData = new Genres(
              id: widget.genres[i].toString(),
              label: genres[i],
              isKeyword: false,
              type: widget.type
            );

            Navigator.pushNamed(context, '/ExplorerGenre', arguments: genresData);
          },
          elevation: 4.0,
          labelPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          backgroundColor: getBackgroundColorItemTheme(),
          label: Text(genres[i],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
      );
    }

    // genres.forEach((item){
    //   genresChipList.add(
    //     Container(
    //   margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
    //   child: ActionChip(
    //       onPressed: () {
    //         Genres genresData = new Genres(
    //           id: ,
    //           label: item,
    //           isKeyword: false,
    //           type: 
    //         );

    //         Navigator.pushNamed(context, '/ExplorerGenre', arguments: genres);
    //       },
    //       elevation: 4.0,
    //       labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
    //       backgroundColor: Colors.blueGrey[500].withOpacity(0.3),
    //       label: Text(item,
    //         style: TextStyle(
    //           fontWeight: FontWeight.w600,
    //           fontSize: 14.0,
    //           fontStyle: FontStyle.italic
    //         ),
    //       ),
    //     ),
    //   ),
    //   );
    // });
     
     return genresChipList;
  }

  

}


class ChipsKeywordsWidget extends StatefulWidget {

  final List<Genres> keywords;

  ChipsKeywordsWidget({@required this.keywords});

  @override
  _ChipsKeywordsWidgetState createState() => _ChipsKeywordsWidgetState();
}

class _ChipsKeywordsWidgetState extends State<ChipsKeywordsWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
       alignment: WrapAlignment.spaceEvenly,
       spacing: 1.5,
       runSpacing: 1.5,
       crossAxisAlignment: WrapCrossAlignment.center,
       
       direction: Axis.horizontal,
       children: _chipsKeyword(),

     );

  }


  List<Widget> _chipsKeyword(){

    List<Widget> keywordChipList = [];

    for (var i = 0; i < widget.keywords.length; i++) {
      
      keywordChipList.add(
        Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      child: ActionChip(
          onPressed: () {

            final Genres keyword = widget.keywords[i];
            
            Navigator.pushNamed(context, '/ExplorerGenre', arguments: keyword);
          },
          elevation: 4.0,
          labelPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          backgroundColor: getBackgroundColorItemTheme(),
          label: Text(
            '#${widget.keywords[i].label}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
      );
    }
     
     return keywordChipList;
  }
}