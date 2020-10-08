import 'package:bunkalist/src/core/localization/app_delegate_localizations.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuildBottomModalWatching extends StatefulWidget{

  final OuevreEntity newOuevre; 
  
  BuildBottomModalWatching({
    @required this.newOuevre
  });
  
  @override
  _BuildBottomModalWatchingState createState() => _BuildBottomModalWatchingState();
}

class _BuildBottomModalWatchingState extends State<BuildBottomModalWatching> {

  OuevreEntity ouevreFinal;
  int inputSeason = 0;
  int inputEpisode = 0;

  TextEditingController _textSeasonController;
  TextEditingController _textEpisodeController;

  @override
  void initState() {
    super.initState();
    _textSeasonController = TextEditingController();
    _textEpisodeController = TextEditingController();
  }

  @override
  void dispose() {
    _textSeasonController.dispose();
    _textEpisodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom
      ), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 5.0,),
          _labelSeasonInput(),
          SizedBox(height: 10.0,),
          _rowSeasonInput(),
          SizedBox(height: 15.0,),
          _labelEpisodeInput(),
          SizedBox(height: 10.0,),
          _rowEpisodeInput(),
          SizedBox(height: 15.0,),
          _buttonAddedInYourList(),
          SizedBox(height: 5.0,),
        ],
      ),
    );
  }

  Widget _labelSeasonInput(){
    return Text( AppLocalizations.of(context).translate("what_season"), 
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _rowSeasonInput(){
    return Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => setState((){
                  inputSeason++;
                  _textSeasonController.text = inputSeason.toString();
                }),
                backgroundColor: Colors.greenAccent,
                elevation: 5.0,
                mini: true,
                child: Icon(Icons.add),
              ), 
            SizedBox(width: 40.0,),
            Container(
              width: 45.0,
              child: TextField(
                controller: _textSeasonController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(2.0),
                  hintText: '$inputSeason',
                  hintStyle: TextStyle(  
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800
                ),
                ),
                onSubmitted: (value) {
                  _textSeasonController.text = value;
                  inputSeason = int.parse( _textSeasonController.text.toString());
                  setState(() {});
                },
                onChanged: (value) {
                  _textSeasonController.text = value;
                  inputSeason = int.parse( _textSeasonController.text.toString());
                  setState(() {});
                },
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            SizedBox(width: 40.0,),
            FloatingActionButton(
              onPressed: () => setState((){
                (inputSeason <= 1) ? 0  : inputSeason--;
                _textSeasonController.text = inputSeason.toString();
              }),
              backgroundColor: Colors.redAccent,
              elevation: 5.0,
              mini: true,
              child: Icon(Icons.remove),
           ),  
          ],
        ),
      ); 
  }

  Widget _labelEpisodeInput(){
    return Text(AppLocalizations.of(context).translate("what_episode"),
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _rowEpisodeInput(){
    return Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => setState((){
                  inputEpisode++;
                  _textEpisodeController.text = inputEpisode.toString();
                }),
                backgroundColor: Colors.greenAccent,
                elevation: 5.0,
                mini: true,
                child: Icon(Icons.add),
              ),  
            SizedBox(width: 40.0,),
            Container(
              width: 45.0,
              child: TextField(
                controller: _textEpisodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(2.0),
                  hintText: '$inputEpisode',
                  hintStyle: TextStyle(  
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800
                ),
                ),
                onSubmitted: (value) {
                  _textEpisodeController.text = value;
                  inputEpisode = int.parse( _textEpisodeController.text.toString());
                  setState(() {});
                },
                onChanged: (value) {
                  _textEpisodeController.text = value;
                  inputEpisode = int.parse( _textEpisodeController.text.toString());
                  setState(() {});
                },
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            SizedBox(width: 40.0,),
            FloatingActionButton(
              onPressed: () => setState((){
                (inputEpisode <= 1) ? 0  : inputEpisode--;
                _textEpisodeController.text = inputEpisode.toString();
              }),
              backgroundColor: Colors.redAccent,
              elevation: 5.0,
              mini: true,
              child: Icon(Icons.remove),
           ),
          ],
        ),
      ); 
  }

  Widget _buttonAddedInYourList(){

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: FlatButton(
          onPressed:() => _addOuevreInFirebase(),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          color: Colors.deepOrangeAccent[400],  
          child: Container(
            padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 5.0
            ),
            child: Text(AppLocalizations.of(context).translate("add_in_list")),
          )
        ),
      ),
    );

  }

  void _addOuevreInFirebase(){
    ouevreFinal = new OuevreEntity(
      seasons: inputSeason,
      episodes: inputEpisode,
      status: widget.newOuevre.status,
      oeuvreId: widget.newOuevre.oeuvreId,
      oeuvreTitle: widget.newOuevre.oeuvreTitle,
      oeuvrePoster: widget.newOuevre.oeuvrePoster,
      oeuvreRating: widget.newOuevre.oeuvreRating,
      oeuvreReleaseDate:widget.newOuevre.oeuvreReleaseDate,
      oeuvreType:widget.newOuevre.oeuvreType,
      addDate:  widget.newOuevre.addDate,
    );
                    
    BlocProvider.of<AddOuevreBloc>(context)..add(
      ButtonAddPressed(
        ouevreEntity: ouevreFinal, 
        type: ouevreFinal.oeuvreType
      )
    );

    Navigator.pop(context);
    getFlushbarSuccessWatching(context);
  }

  void getFlushbarSuccessWatching(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.blueAccent[700], Colors.blueAccent[400]],),
      backgroundColor: Colors.blue[500],
      boxShadows: [BoxShadow(color: Colors.blue[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("added_success_watching"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    
  }

}