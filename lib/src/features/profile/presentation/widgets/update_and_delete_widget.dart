import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_delete/bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ButtomUpdateAndDelete {
  
  final OuevreEntity ouevre;
  final String type;


  ButtomUpdateAndDelete({
    @required this.ouevre,
    @required this.type
  });


  final prefs = new Preferences();

   

  void showBottonModalOptions(BuildContext context){
    showBottomSheet(
      elevation: 10.0,
      backgroundColor: _getBackgroundColorTheme(), 
      context: context,
      builder: (context) => _buildBottomModal(context,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
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

  Widget _buildBottomModal(BuildContext context) {
    

    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _optionFavorite(),
          Flexible(
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                return ButtonClikedAdded(
                  context: context,
                  isUpdated: true,
                  ouevre: ouevre,
                  type: ouevre.oeuvreType,
                  objectType: ConstantsTypeObject.ouevreEntity
                ).showBottomModal();
              },
              title: Text(AppLocalizations.of(context).translate("title_update_ouevre"),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),) ,
              subtitle: Text(AppLocalizations.of(context).translate("label_update_ouevre"),style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
              leading: Icon(Icons.update, color: Colors.greenAccent[700],),
            )
          ),
          Flexible(
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                _alertDialogOfDelete(context);
              },
              title: Text(AppLocalizations.of(context).translate("title_delete_ouevre"),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),) ,
              subtitle: Text(AppLocalizations.of(context).translate("label_delete_ouevre"),style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
              leading: Icon(Icons.delete_forever, color: Colors.redAccent[700],),
            )
          ),
        ],
      );
  }

  Widget _optionFavorite(){
    return new BlocProvider<AddOuevreBloc>(
      builder: (_) => serviceLocator<AddOuevreBloc>(),
      child: ButtonFavorite(ouevreEntity: ouevre,)
    );
  }

  void _alertDialogOfDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context){
        return BlocProvider<DeleteBloc>(
          builder: (context) => serviceLocator<DeleteBloc>(),
          child: BuildDialogDelete(ouevre: ouevre, type: type,),
        );
      }
    );
  }
}

class BuildDialogDelete extends StatefulWidget {
 
  final OuevreEntity ouevre;
  final String type;


  BuildDialogDelete({
    @required this.ouevre,
    @required this.type
  });


  @override
  _BuildDialogDeleteState createState() => _BuildDialogDeleteState();
}

class _BuildDialogDeleteState extends State<BuildDialogDelete> {
  
   final prefs = new Preferences();
  
  @override
  Widget build(BuildContext context) {
    return Container( 
       child: AlertDialog(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),   
        backgroundColor: _getBackgroundColorTheme(),
        elevation: 10.0,
        title: Text(
          AppLocalizations.of(context).translate("title_delete_ouevre"),
        ),
        content: Text(
          AppLocalizations.of(context).translate("label_dialog_delete_ouevre")
        ),
        actions: <Widget>[
          _buttonCancel(context),
          _buttonAccept(context)
        ],
       ),
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

  Widget _buttonCancel(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(), 
      child: Text(
        AppLocalizations.of(context).translate("cancel"),
        style: TextStyle(
          color: Colors.deepPurpleAccent[400],
          fontSize: 16.0,
          fontWeight: FontWeight.w700
          ),
        )
    );
  }

  _buttonAccept(BuildContext context) {
    return FlatButton(
      onPressed: () {

         Navigator.of(context).pop();

        BlocProvider.of<DeleteBloc>(context)..add(
          ButtonDeletePressed(
            ouevreEntity: widget.ouevre,
            type: widget.type
          )
        );

        getFlushbarSuccessDelete(context);

       
      }, 
      child: Text(
        AppLocalizations.of(context).translate("accept"),
        style: TextStyle(
          color: Colors.deepPurpleAccent[400],
          fontSize: 16.0,
          fontWeight: FontWeight.w700
          ),
        )
    );
  }


  void getFlushbarSuccessDelete(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.redAccent[700], Colors.redAccent[400]],),
      backgroundColor: Colors.red[500],
      boxShadows: [BoxShadow(color: Colors.red[500], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 2),
      messageText: Text(
        AppLocalizations.of(context).translate("success_delete_ouevre"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    

  }
}


class ButtonFavorite extends StatefulWidget {

  final OuevreEntity ouevreEntity;

  ButtonFavorite({ @required this.ouevreEntity});

  @override
  _ButtonFavoriteState createState() => _ButtonFavoriteState();
}

class _ButtonFavoriteState extends State<ButtonFavorite> {

  final Preferences prefs = Preferences();


  @override
  Widget build(BuildContext context) {
    final bool isFavorite = widget.ouevreEntity.isFavorite?? false;

    final bool isComplete = (widget.ouevreEntity.status == 1) ? true : false;

    return isComplete 
          ? isFavorite 
            ? _buildRemoveFavorites()
            :  _getLimitedOfFavorites()
              ? _buildAddFavorites()
              : Container()
          : Container();
  }

  Widget _buildAddFavorites() {
    return Flexible(
          child: ListTile(
            onTap: () {
              Navigator.of(context).pop();

              widget.ouevreEntity.isFavorite = true;
              widget.ouevreEntity.positionListFav = _getPosition();

              BlocProvider.of<AddOuevreBloc>(context)..add(
                ButtonAddPressed( type: widget.ouevreEntity.oeuvreType, ouevreEntity: widget.ouevreEntity )
              );

            },
            title: Text(AppLocalizations.of(context).translate("update_dialog_title_add_top"),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),) ,
            subtitle: Text(AppLocalizations.of(context).translate("update_dialog_label_add_top"),style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
            leading: Icon(Icons.star_rate_rounded, color: Colors.yellowAccent[700],),
            )
          );
  }

  Widget _buildRemoveFavorites() {
    return Flexible(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pop();
          
          widget.ouevreEntity.isFavorite = false;

          widget.ouevreEntity.positionListFav = -1;

          BlocProvider.of<AddOuevreBloc>(context)..add(
            ButtonAddPressed( type: widget.ouevreEntity.oeuvreType, ouevreEntity: widget.ouevreEntity )
          );
        },
        title: Text(AppLocalizations.of(context).translate("update_dialog_title_remove_top"),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),) ,
        subtitle: Text(AppLocalizations.of(context).translate("update_dialog_label_remove_top"),style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
        leading: Icon(Icons.star_border_rounded, color: Colors.yellowAccent[700],),
      )
    );
  }

  int _getPosition() {

    switch (widget.ouevreEntity.oeuvreType) {
      case 'movie':{
        int position = prefs.totalMoviesFav;

        prefs.totalMoviesFav = position++;

        return position++;
      }
        break;

      case 'tv':{
        int position = prefs.totalSeriesFav;

        prefs.totalSeriesFav = position++;

        return position++;
      }
        break;

      case 'anime':{
        int position = prefs.totalAnimesFav;

        prefs.totalAnimesFav = position++;

        return position++;
      }
        break;    
      default: return prefs.totalMoviesFav;
    }
  }

  bool _getLimitedOfFavorites(){
    final int maxSelected = prefs.isNotAds ? 20 : 10;

    switch (widget.ouevreEntity.oeuvreType) {
      case 'movie':{
        

        bool isMax = prefs.totalMoviesFav < maxSelected;

        return isMax;
      }
        break;

      case 'tv':{
        
        bool isMax = prefs.totalSeriesFav < maxSelected;

        return isMax;
      }
        break;

      case 'anime':{
        bool isMax = prefs.totalAnimesFav < maxSelected;

        return isMax;
      }
        break;    
      default: return false;
    }
  }
  
}