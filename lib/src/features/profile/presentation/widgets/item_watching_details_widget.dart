import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/build_bottom_modal_watching_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class BuildItemWatchingDetailsWidget extends StatefulWidget {
  
  final OuevreEntity ouevreEntity;

  BuildItemWatchingDetailsWidget({
    @required this.ouevreEntity
  });

  @override
  _BuildItemWatchingDetailsWidgetState createState() => _BuildItemWatchingDetailsWidgetState();
}

class _BuildItemWatchingDetailsWidgetState extends State<BuildItemWatchingDetailsWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width - 5.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: getBackgroundColorTheme()
      ),
      child: _stackOfDetails(),
    );
  }

   

  Widget _stackOfDetails() {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        _imageBackground(),
        _itemRating(),
        _bottomClose(),
        _titleItem(),
        progressBarEpisode(),
        Positioned(
          child: new BlocProvider<AddOuevreBloc>(
            create: (_) => serviceLocator<AddOuevreBloc>(),
            child:  BuildEditStatusWatching(newOuevre: widget.ouevreEntity,),
          ), 
          bottom: 20,
        ),
      ]
    );
  }

  Widget _imageBackground() {
    return Hero(
      tag: widget.ouevreEntity.oeuvreId,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)
              ),
              child: FadeInImage(
                image: NetworkImage(widget.ouevreEntity.oeuvrePoster),
                placeholder: AssetImage('assets/poster_placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
      ),
    );
  }

  _bottomClose() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[400].withOpacity(0.6),
            borderRadius: BorderRadius.circular(40)
          ),
          child: IconButton(
            padding: const EdgeInsets.all(1.0),
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 20.0,
            ), 
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
        ),
      ),
    );
  }

   Widget _itemRating(){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blueGrey[400].withOpacity(0.3)
        ),
        child: Text(
          widget.ouevreEntity.oeuvreRating.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            shadows: [
             Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
            ),
        ),
      ),
    );
  }

  Widget _titleItem() {
    return Positioned(
      top: 160.0,
      child: Container(
        width: MediaQuery.of(context).size.width - 100.0,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.ouevreEntity.oeuvreTitle,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            shadows: [
             Shadow(blurRadius: 1.5, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
          ),
          ),
      ),
    );
  }

  Widget progressBarEpisode() {
    
    int totalEpisode = widget.ouevreEntity.episodeTotal;
    int watchEpisode = widget.ouevreEntity.episodes;

    double percentOfWatch = widget.ouevreEntity.episodes / totalEpisode;

    int episodesLeft = totalEpisode - watchEpisode;

    final String labelEpisodesLeft = AppLocalizations.of(context).translate("label_epiosde_left");


    return Positioned(
      top: 220, 
      child: Container(
        width: MediaQuery.of(context).size.width - 60.0,
        padding: const EdgeInsets.only(
            top: 15.0,
            left: 15.0,
            right: 15.0
          ),
        child: Column(
          children: [
            LinearPercentIndicator(
              lineHeight: 22.0,
              percent: percentOfWatch,
              backgroundColor: Colors.blueGrey.withOpacity(0.7),
              center: Text(
              '$watchEpisode / $totalEpisode',
                style: TextStyle(
                color: Colors.white,
                fontSize: 18.0, 
                fontWeight: FontWeight.w800,
                shadows: [
                Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
                ]
              ),
              ),
              linearGradient: LinearGradient(
                colors: percentOfWatch <= 0.2
              ? 
              [
                Colors.deepPurpleAccent[400].withOpacity(0.9),
                Colors.deepPurpleAccent.withOpacity(0.9),
                Colors.pinkAccent.withOpacity(0.9),
              ]
              :
              [
                Colors.deepPurpleAccent[400].withOpacity(0.9),
                Colors.deepPurpleAccent.withOpacity(0.9),
                Colors.pinkAccent.withOpacity(0.9),
                Colors.pinkAccent[400].withOpacity(0.9)
              ]
              ),
            ),
            Text(
              '$episodesLeft $labelEpisodesLeft',
                style: TextStyle(
                color: Colors.white,
                fontSize: 16.0, 
                fontWeight: FontWeight.w800,
                shadows: [
                Shadow(blurRadius: 2.0, color: Colors.black, offset: Offset(1.5, 1.5))
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  

  
}


class BuildEditStatusWatching extends StatefulWidget{

  final OuevreEntity newOuevre; 
  
  BuildEditStatusWatching({
    @required this.newOuevre
  });
  
  @override
  _BuildEditStatusWatchingState createState() => _BuildEditStatusWatchingState();
}

class _BuildEditStatusWatchingState extends State<BuildEditStatusWatching> {

  OuevreEntity ouevreFinal;
  int inputSeason = 0;
  int inputEpisode = 0;

  TextEditingController _textSeasonController;
  TextEditingController _textEpisodeController;

  @override
  void initState() {
    super.initState();
    
    inputSeason = widget.newOuevre.seasons;
    inputEpisode = widget.newOuevre.episodes;

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
          _rowOfButtons(),
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

  Widget _rowOfButtons(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          _buttonAddedInYourList(),
          SizedBox(width: 5.0,),
          _buttonMoreDetails()
        ],
      ),
    );
  }

  Widget _buttonAddedInYourList(){

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          onPressed:() => _addOuevreInFirebase(),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          color: Colors.pinkAccent[400],  
          child: Container(
            padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 5.0
            ),
            child: Text(AppLocalizations.of(context).translate("btn_label_edit_save_top")),
          )
        ),
      ),
    );

  }

  Widget _buttonMoreDetails(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0), 
          ),
          borderSide: BorderSide(
            color: Colors.pinkAccent[400],
            width: 1.5
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 5.0
            ),
            child: Text(
              AppLocalizations.of(context).translate("details_more_info"),
              style: TextStyle(
                fontSize: 14.0
              ),
            ),
          ),
          color: Colors.pinkAccent[400],
          onPressed: (){
            Navigator.pushNamed(
                context, '/AllDetails', 
                arguments: 
                getIdAndType(
                  widget.newOuevre.oeuvreId, 
                  widget.newOuevre.oeuvreType,  
                  widget.newOuevre.oeuvreTitle
                )
              );
          }
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
      seasonTotal: widget.newOuevre.seasonTotal,
      episodeTotal: widget.newOuevre.episodeTotal
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