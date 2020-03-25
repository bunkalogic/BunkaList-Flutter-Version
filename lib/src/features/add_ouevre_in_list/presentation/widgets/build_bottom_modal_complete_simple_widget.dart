import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBottomModalCompleteSimple extends StatefulWidget{

    final OuevreEntity newOuevre; 
  
  BuildBottomModalCompleteSimple ({
    @required this.newOuevre
  }); 

  @override
  _BuildBottomModalCompleteSimpleState createState() => _BuildBottomModalCompleteSimpleState();
}

class _BuildBottomModalCompleteSimpleState extends State<BuildBottomModalCompleteSimple> {
  
  OuevreEntity ouevreFinal;

  double _value = 0.5;

  final _commentController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _commentField(),
        SizedBox(height: 10.0,),
        _sliderRatingGeneral(),
        SizedBox(height: 5.0,),
        _labelSliderRatingGeneral(),
        SizedBox(height: 5.0,),
        _buttonAddedInYourList(),
        SizedBox(height: 5.0,),
      ],
    );
  }

  Widget _labelSliderRatingGeneral(){

    final labelRatingInGeneral = AppLocalizations.of(context).translate("rating_in_general"); 

    final label = '$labelRatingInGeneral $_value';

    return Center(
      child: Text(
        label, 
        style: TextStyle(
          fontSize: 16.0, 
          fontWeight: FontWeight.w600
        )
      )
    );
  }

  Widget _sliderRatingGeneral(){
    return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 15.0
    ),
    child: Slider(
      inactiveColor: Colors.deepPurpleAccent[100],
      activeColor: Colors.deepPurpleAccent[400],
      label: '$_value',
      value: _value, 
      onChanged: (newValue){
        setState(() => _value = newValue);
      },
      min: 0.5,
      max: 10.0,
      divisions: 19,
      ),
    );
  }

  Widget _commentField(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _commentController,
          //style: TextStyle(color: Colors.white),
          maxLength: 180,
          maxLines: 3,
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
              labelText: AppLocalizations.of(context).translate("label_comment_completed"),
              labelStyle: TextStyle(color: Colors.grey[400])),
        ),
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

    OuevreEntity ouevre = fillNewOuevreEntity();

    BlocProvider.of<AddOuevreBloc>(context)..add(
      ButtonAddPressed(
        ouevreEntity: ouevre, 
        type: ouevre.oeuvreType
      )
    );


    Navigator.pop(context);
    getFlushbarSuccessComplete(context);

  }

  OuevreEntity fillNewOuevreEntity(){
    ouevreFinal = new OuevreEntity(
      historyRate: _value,
      characterRate:_value,
      effectsRate: _value,
      ostRate:_value,
      enjoymentRate:_value,
      finalRate:_value,
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

    return ouevreFinal;
  }

  void getFlushbarSuccessComplete(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 100.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.greenAccent[700], Colors.greenAccent[400]],),
      backgroundColor: Colors.green[500],
      boxShadows: [BoxShadow(color: Colors.green[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("added_success_completed"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    
   
  }


}