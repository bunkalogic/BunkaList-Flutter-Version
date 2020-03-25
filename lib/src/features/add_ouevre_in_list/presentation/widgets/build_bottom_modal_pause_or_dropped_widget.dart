import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuildBottomModalPauseOrDropped extends StatefulWidget{
  
  final OuevreEntity newOuevre; 
  
  BuildBottomModalPauseOrDropped ({
    @required this.newOuevre
  });

  @override
  _BuildBottomModalPauseOrDroppedState createState() => _BuildBottomModalPauseOrDroppedState();
}

class _BuildBottomModalPauseOrDroppedState extends State<BuildBottomModalPauseOrDropped> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _commentController  = TextEditingController();
  
  OuevreEntity ouevreFinal;
  int inputSeason = 0;
  int inputEpisode = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 5.0,),
            _commentField(),
            _labelSeasonInput(),
            _rowSeasonInput(),
            _labelEpisodeInput(),
            _rowEpisodeInput(),
            _buttonAddedInYourList(),
            SizedBox(height: 8.0,),
          ],
        )
      ),
    );
  }

  Widget _commentField(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _commentController,
        style: TextStyle(color: Colors.white),
        maxLength: 180,
        maxLines: 2,
        maxLengthEnforced: true,
        decoration: InputDecoration(
            fillColor: Colors.grey[400].withOpacity(0.2),
            filled: true,
            icon: Icon(
              Icons.label,
              color: Colors.grey[500],
            ),
            border: UnderlineInputBorder(),
            helperText: AppLocalizations.of(context).translate("helper_comment"),
            helperStyle: TextStyle(color: Colors.grey[400]),
            labelText: AppLocalizations.of(context).translate("label_comment_pause"),
            labelStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }

  Widget _labelSeasonInput(){
    if(widget.newOuevre.oeuvreType == 'movie') return Container();

    return Container(
      margin: EdgeInsets.all(2.0),
      child: Text( AppLocalizations.of(context).translate("what_season"), 
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _rowSeasonInput(){
    if(widget.newOuevre.oeuvreType == 'movie') return Container();

    return Container(
          margin: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => setState(()=> inputSeason++),
                backgroundColor: Colors.greenAccent,
                elevation: 5.0,
                mini: true,
                child: Icon(Icons.add),
              ),
            SizedBox(width: 40.0,),
            Text(
              '$inputSeason',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(width: 40.0,),
            FloatingActionButton(
              onPressed: () => setState(()=> (inputSeason <= 1) ? 0  : inputSeason--),
              backgroundColor: Colors.redAccent,
              elevation: 5.0,
              mini: true,
              child: Icon(Icons.remove),
           )  
          ],
        ),
      ); 
  }

  Widget _labelEpisodeInput(){
    if(widget.newOuevre.oeuvreType == 'movie') return Container();

    return Container(
      margin: EdgeInsets.all(2.0),
      child: Text(AppLocalizations.of(context).translate("what_episode"),
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _rowEpisodeInput(){
    if(widget.newOuevre.oeuvreType == 'movie') return Container();

    return Container(
          margin: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => setState(()=> inputEpisode++),
                backgroundColor: Colors.greenAccent,
                elevation: 5.0,
                mini: true,
                child: Icon(Icons.add),
              ),
            SizedBox(width: 40.0,),
            Text(
              '$inputEpisode',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(width: 40.0,),
            FloatingActionButton(
              onPressed: () => setState(()=> (inputEpisode <= 1) ? 0  : inputEpisode--),
              backgroundColor: Colors.redAccent,
              elevation: 5.0,
              mini: true,
              child: Icon(Icons.remove),
           )  
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
          color: Colors.orange[900],  
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
    ouevreFinal = new 
      OuevreEntity(
        seasons: inputSeason,
        episodes: inputEpisode,
        comment: _commentController.text,
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
     ) );
  
    _getSuccessFlushbarOfStatus();  
  }
  
  void _getSuccessFlushbarOfStatus(){
    if(widget.newOuevre.status == 3){

       Navigator.pop(context);
      getFlushbarSuccessPause(context);

    }else if(widget.newOuevre.status == 4){

       Navigator.pop(context);
      getFlushbarSuccessDropped(context);

    }
  }

  void getFlushbarSuccessPause(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 100.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.orangeAccent[700], Colors.orangeAccent[400]],),
      backgroundColor: Colors.orange[500],
      boxShadows: [BoxShadow(color: Colors.orange[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("added_success_pause"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    
  }

  void getFlushbarSuccessDropped(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 100.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.redAccent[700], Colors.redAccent[400]],),
      backgroundColor: Colors.red[500],
      boxShadows: [BoxShadow(color: Colors.red[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("added_success_dropped"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    

  }


}