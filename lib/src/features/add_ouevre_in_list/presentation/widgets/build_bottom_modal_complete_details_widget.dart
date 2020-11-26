import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuildBottomModalCompleteInDetails extends StatefulWidget{
  
  final OuevreEntity newOuevre; 
  
  BuildBottomModalCompleteInDetails ({
    @required this.newOuevre
  }); 
  
  @override
  _BuildBottomModalCompleteInDetailsState createState() => _BuildBottomModalCompleteInDetailsState();
}

class _BuildBottomModalCompleteInDetailsState extends State<BuildBottomModalCompleteInDetails> {
  
  final _commentController  = TextEditingController();
  OuevreEntity ouevreFinal;
  double _ratePlot = 0.5;
  double _rateCharacters = 0.5;
  double _ratePhotography = 0.5;
  double _rateSoundtrack = 0.5;
  double _rateEntertainment = 0.5;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.end,
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 4.0,),
          _commentField(),
          SizedBox(height: 2.0,),
          _sliderRatingPlot(),
          _labelSliderRatingPlot(),
          Divider(),
          _sliderRatingCharacters(),
          _labelSliderRatingCharacters(),
          Divider(),
          _sliderRatingPhotography(),
          _labelSliderRatingPhotography(),
          Divider(),
          _sliderRatingSoundtrack(),
          _labelSliderRatingSoundtrack(),
          Divider(),
          _sliderRatingEntertainment(),
          _labelSliderRatingEntertainment(),
          Divider(),
          _buttonAddedInYourList(),
          SizedBox(height: 2.0,),

        ],
      ),
    );
  }

  Widget _labelSliderRatingPlot(){
    final labelRating = AppLocalizations.of(context).translate("rating_in_plot"); 

    final label = '$labelRating $_ratePlot';

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

  Widget _sliderRatingPlot(){
    return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 5.0
    ),
    child: new Slider(
      inactiveColor: Colors.greenAccent[100],
      activeColor: Colors.greenAccent[400],
      label: '$_ratePlot',
      value: _ratePlot, 
      onChanged: (newValue){
        setState(() => _ratePlot = newValue);
      },
      min: 0.5,
      max: 10.0,
      divisions: 19,
      ),
    );
  }

  Widget _labelSliderRatingCharacters(){
    final labelRatingInGeneral = AppLocalizations.of(context).translate("rating_in_characters"); 

    final label = '$labelRatingInGeneral $_rateCharacters';

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

  Widget _sliderRatingCharacters(){
    return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 5.0
    ),
    child: new Slider(
      inactiveColor: Colors.blueAccent[100],
      activeColor: Colors.blueAccent[400],
      label: '$_rateCharacters',
      value: _rateCharacters, 
      onChanged: (newValue){
        setState(() => _rateCharacters = newValue);
      },
      min: 0.5,
      max: 10.0,
      divisions: 19,
      ),
    );
  }

  Widget _labelSliderRatingPhotography(){
    final labelRatingInGeneral = AppLocalizations.of(context).translate("rating_in_photography"); 

    final label = '$labelRatingInGeneral $_ratePhotography';

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

  Widget _sliderRatingPhotography(){

    return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 5.0
    ),
    child: new Slider(
      inactiveColor: Colors.deepPurpleAccent[100],
      activeColor: Colors.deepPurpleAccent[400],
      label: '$_ratePhotography',
      value: _ratePhotography, 
      onChanged: (newValue){
        setState(() => _ratePhotography = newValue);
      },
      min: 0.5,
      max: 10.0,
      divisions: 19,
      ),
    );

  }

  Widget _labelSliderRatingSoundtrack(){

    final labelRatingInGeneral = AppLocalizations.of(context).translate("rating_in_soundtrack"); 

    final label = '$labelRatingInGeneral $_rateSoundtrack';

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

  Widget _sliderRatingSoundtrack(){
    return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 5.0
    ),
    child: new Slider(
      inactiveColor: Colors.tealAccent[400],
      activeColor: Colors.tealAccent[700],
      label: '$_rateSoundtrack',
      value: _rateSoundtrack, 
      onChanged: (newValue){
        setState(() => _rateSoundtrack = newValue);
      },
      min: 0.5,
      max: 10.0,
      divisions: 19,
      ),
    );
  }

  Widget _labelSliderRatingEntertainment(){
    final labelRatingInGeneral = AppLocalizations.of(context).translate("rating_in_entertainment"); 

    final label = '$labelRatingInGeneral $_rateEntertainment';

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

  Widget _sliderRatingEntertainment(){
    return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 30.0,
      vertical: 5.0
    ),
    child: new Slider(
      inactiveColor: Colors.redAccent[100],
      activeColor: Colors.redAccent[400],
      label: '$_rateEntertainment',
      value: _rateEntertainment, 
      onChanged: (newValue){
        setState(() => _rateEntertainment = newValue);
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
          maxLines: 4,
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
          color: Colors.pinkAccent[400],  
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

  double getTheFinalRate(){
    
    double totalResult = _ratePlot + _rateCharacters + _ratePhotography + _rateSoundtrack + _rateEntertainment;

    double ratingFinal = totalResult / 5;

    return ratingFinal;

  }

  OuevreEntity fillNewOuevreEntity(){

    ouevreFinal = new OuevreEntity(
      historyRate: _ratePlot,
      characterRate:_rateCharacters,
      effectsRate: _ratePhotography,
      ostRate:_rateSoundtrack,
      enjoymentRate:_rateEntertainment,
      finalRate: getTheFinalRate(),
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

  void getFlushbarSuccessComplete(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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