

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:flutter/material.dart';


class BuildItemDetailsWidget extends StatefulWidget {
  
  final OuevreEntity ouevreEntity;

  BuildItemDetailsWidget({
    @required this.ouevreEntity
  });

  @override
  _BuildItemDetailsWidgetState createState() => _BuildItemDetailsWidgetState();
}

class _BuildItemDetailsWidgetState extends State<BuildItemDetailsWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width - 5.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: _getBackgroundColorTheme()
      ),
      child: _stackOfDetails(),
    );
  }

   Color _getBackgroundColorTheme() {
    final prefs = new Preferences();

    if(prefs.whatModeIs && prefs.whatDarkIs == false){
      return Colors.blueGrey[900];
    }else if(prefs.whatModeIs && prefs.whatDarkIs == true){
      return Colors.grey[900];
    }
    else{
      return Colors.grey[100];
    }
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
        _itemRatingFinal(),
        columnDiferentRating(),
        _buttonMoreDetails()
      ]
    );
  }

  Widget _imageBackground() {
    return Hero(
      tag: widget.ouevreEntity.oeuvreId,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
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

  Widget _itemRatingFinal(){
    return Positioned(
      top: 210.0,
      child: BigCircularChartRating(widget.ouevreEntity.finalRate)
    );
  }
  
  Widget columnDiferentRating(){
    return Positioned(
      top: 290,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              itemRatingDiferents(widget.ouevreEntity.historyRate, AppLocalizations.of(context).translate("rating_in_plot"), Colors.greenAccent[400]),
              SizedBox(width: 4.0,),
              itemRatingDiferents(widget.ouevreEntity.characterRate, AppLocalizations.of(context).translate("rating_in_characters"), Colors.lightBlueAccent[400]),
            ],
          ),
           Row(
            children: [
              itemRatingDiferents(widget.ouevreEntity.effectsRate, AppLocalizations.of(context).translate("rating_in_photography"), Colors.purpleAccent[400]),
              SizedBox(width: 4.0,),
              itemRatingDiferents(widget.ouevreEntity.ostRate, AppLocalizations.of(context).translate("rating_in_soundtrack"), Colors.deepOrangeAccent[400]),
            ],
          ),
          itemRatingDiferents(widget.ouevreEntity.enjoymentRate, AppLocalizations.of(context).translate("rating_in_entertainment"), Colors.redAccent[400]),
          _commentOfItem()
        ]
      ),
    );
  }

  Widget itemRatingDiferents(double rating, String label, Color color){
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.grey[500]
          ),
        ),
        SizedBox(height: 1.0,),
        MiniCircularChartRatingColor(rating, color)
      ],
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
          child: Text(
            AppLocalizations.of(context).translate("details_more_info"),
            style: TextStyle(
              fontSize: 14.0
            ),
          ),
          color: Colors.pinkAccent[400],
          onPressed: (){
            Navigator.pushNamed(
                context, '/AllDetails', 
                arguments: 
                getIdAndType(
                  widget.ouevreEntity.oeuvreId, 
                  widget.ouevreEntity.oeuvreType,  
                  widget.ouevreEntity.oeuvreTitle
                )
              );
          }
        ),
      ),
    );
  }

  Widget _commentOfItem(){
    if(widget.ouevreEntity.comment.isEmpty){
      return Container();
    } 

    return Container(
      width: MediaQuery.of(context).size.width - 100.0,
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey[400].withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0)
      ),
      
      child: Text(
        widget.ouevreEntity.comment,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.clip,
         style: TextStyle(
            fontSize: 14.0, 
            fontWeight: FontWeight.w600,
            ) 
        ),
    );
  }
}