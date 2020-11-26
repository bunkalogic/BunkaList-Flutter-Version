import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class EmptyLastAddedIconWidget extends StatelessWidget {

  final String typeOuevre;

  const EmptyLastAddedIconWidget({ @required this.typeOuevre });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _iconEmptyLastAdded(),
          _labelEmptyLastAdded(context),
          _buttonGoToListHomeTops(context)
        ],
      ),
    );
  }

  Widget _iconEmptyLastAdded() {
    return Icon(
      Icons.add_to_photos,
      color: Colors.pinkAccent[400],
      size: 40.0,
    );
  }

  Widget _labelEmptyLastAdded(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        AppLocalizations.of(context).translate("empty_last_added_label"),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }

  _buttonGoToListHomeTops(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, '/TopList', arguments: _fixArgument(typeOuevre));
      },
      elevation: 10.0,
      heroTag: null,
      backgroundColor: Colors.deepPurpleAccent[400],
      child: Icon(Icons.arrow_forward, color: Colors.pinkAccent[400],),
    );
  }

  String _fixArgument( String type ){
    if(type == "movie") type = "movies";
    if(type == "tv") type = "tv";
    if(type == "anime") type = "animes";

    return type;
  }
}