import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/constans_status_ouevre.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/flushbar_go_login_widget.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/utils/firebase_fill_ouevre_object.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/build_bottom_modal_complete_details_widget.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/build_bottom_modal_complete_simple_widget.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/build_bottom_modal_pause_or_dropped_widget.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/build_bottom_modal_watching_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonAddedArrowDown extends StatelessWidget{
  
  final Object ouevre;
  final String type;
  final bool isUpdated;
  final int objectType;

  ButtonAddedArrowDown({
    @required this.ouevre,
    @required this.type,
    @required this.isUpdated,
    @required this.objectType,
  });
  
  
  @override
  Widget build(BuildContext context) {
    
    final Preferences prefs = Preferences();

    return IconButton(
      padding: const EdgeInsets.only(bottom: 20.0),
      icon: Icon(Icons.keyboard_arrow_down_rounded, size: 26.0,),
      onPressed: () => (prefs.currentUserHasToken) 
        ? _showBottomModal(context) 
        : getFlushbarGoToLogin(context),
    );
  }

  void _showBottomModal(BuildContext context){
    showModalBottomSheet(
      elevation: 10.0,
      isScrollControlled: true,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      builder: (_) {
        return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: BuildBottomModalStutusOptions(
            ouevre: ouevre,
            type: type,
            isUpdated: isUpdated,
            objectType: objectType,
          ),
        );   
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
    );
  }

}

class MultiButtonsAdded extends StatelessWidget{
  
  final Object ouevre;
  final String type;
  final int objectType;


  MultiButtonsAdded({
    @required this.ouevre,
    @required this.type,
    @required this.objectType,
  });
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
         Expanded(child: _buttonActions(context, Icons.check_circle, Colors.greenAccent[400], ConstantsStatus.completed)), 
         Expanded(child: _buttonActions(context, Icons.play_circle_filled, Colors.lightBlueAccent[400], ConstantsStatus.watching)),
         Expanded(child: _buttonActions(context, Icons.pause_circle_filled, Colors.orangeAccent[400], ConstantsStatus.pause)),
         Expanded(child: _buttonActions(context, Icons.remove_circle, Colors.redAccent[400], ConstantsStatus.dropped)),
         Expanded(child: _buttonActions(context, Icons.add_circle, Colors.deepPurpleAccent[400], ConstantsStatus.wishlist)),
        ],
      ),
    );
  }


  Widget _buttonActions(BuildContext context, IconData icon, Color color, int status){
    
    final Preferences prefs = Preferences();
    final OuevreEntity ouevreConvert = FirebaseFillOuevreObject(ouevre: ouevre, type: type, status: status, typeObject: objectType).detectTypeObjectAndFill();  

    return IconButton(
      icon: Icon(
        icon, 
        size: 25.0, 
        color: color,
        ),
        onPressed: () {

          if(!prefs.currentUserHasToken){
            getFlushbarGoToLogin(context);
            return;
          }

          return GetBottomModalStatus(
            context: context, 
            ouevre: ouevreConvert, 
            type: type, 
            isUpdated: false, 
            status: status,
            bloc: BlocProvider.of<AddOuevreBloc>(context)
          ).call();
        },
    );
  }

}

class ButtonClikedAdded {
  
  final Object ouevre;
  final String type;
  final BuildContext context;
  final bool isUpdated;
  final int objectType;

  ButtonClikedAdded({
    @required this.context,
    @required this.ouevre,
    @required this.type,
    @required this.isUpdated,
    @required this.objectType
  });

  
  
  

  void showBottomModal(){

    final Preferences prefs = Preferences();

    if(!prefs.currentUserHasToken){
      getFlushbarGoToLogin(context);
      return;
    }

    showModalBottomSheet(
      elevation: 10.0,
      isScrollControlled: true,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      builder: (_) {
        return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: BuildBottomModalStutusOptions(
            ouevre: ouevre,
            type: type,
            isUpdated: isUpdated,
            objectType: objectType,
          ),
        );   
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
    );
  }

  
}

class BuildBottomModalStutusOptions extends StatefulWidget {
  
  final Object ouevre;
  final String type;
  final bool isUpdated;
  final int objectType;

 BuildBottomModalStutusOptions({
    @required this.ouevre,
    @required this.type,
    @required this.isUpdated,
    @required this.objectType
  });

  @override
  _BuildBottomModalStutusOptionsState createState() => _BuildBottomModalStutusOptionsState();
}

class _BuildBottomModalStutusOptionsState extends State<BuildBottomModalStutusOptions> {
  
  
  
  @override
  Widget build(BuildContext context) {
    
    final completed = AppLocalizations.of(context).translate("status_completed");
    final watching =  AppLocalizations.of(context).translate("status_watching");
    final pause = AppLocalizations.of(context).translate("status_pause");
    final dropped =  AppLocalizations.of(context).translate("status_dropped");
    final wishlist = AppLocalizations.of(context).translate("status_wishlist");

    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        Flexible(child: _buttonStatus(context, completed, Colors.greenAccent[400], Icons.check_circle, ConstantsStatus.completed,), flex: 1,),
        Flexible(child:_buttonStatus(context, watching, Colors.lightBlueAccent[400], Icons.play_circle_filled, ConstantsStatus.watching,), flex: 1,),
        Flexible(child:_buttonStatus(context, pause, Colors.orangeAccent[400], Icons.pause_circle_filled, ConstantsStatus.pause, ), flex: 1,),
        Flexible(child:_buttonStatus(context, dropped, Colors.redAccent[400], Icons.remove_circle, ConstantsStatus.dropped, ), flex: 1,),
        Flexible(child:_buttonStatus(context, wishlist, Colors.deepPurpleAccent[400], Icons.add_circle, ConstantsStatus.wishlist,), flex: 1,),
        ],
    );
  }

  Widget _buttonStatus(BuildContext context, String title, Color color, IconData icon, int status,){
    
    final OuevreEntity ouevreConvert = FirebaseFillOuevreObject(ouevre: widget.ouevre, type: widget.type, status: status, typeObject: widget.objectType).detectTypeObjectAndFill();  

    final Preferences prefs = Preferences();
    

    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)),
      leading: Icon(icon, color: color, size: 35.0,),
      onTap: () {

        if(!prefs.currentUserHasToken){
          getFlushbarGoToLogin(context);
          return;
        }

        Navigator.of(context).pop();

        return GetBottomModalStatus(
        context: context, 
        ouevre: ouevreConvert, 
        type: widget.type, 
        isUpdated: widget.isUpdated, 
        status: status,
        bloc: BlocProvider.of<AddOuevreBloc>(context)
        ).call();
      } 
    );
  }



}


class GetBottomModalStatus {

    final BuildContext context; 
    final OuevreEntity ouevre;
    final String type;
    final bool isUpdated;
    final int status;
    final Bloc<AddOuevreEvent, AddOuevreState> bloc;
    

    GetBottomModalStatus({
      @required this.context,
      @required this.ouevre,
      @required this.type,
      @required this.isUpdated,
      @required this.status,
      @required this.bloc
    });

    void call(){
      switch(status){

        case ConstantsStatus.completed: {

          return getOptionsCompleteStatus(context, ouevre);

        }

        case ConstantsStatus.watching: {

          //? esto solo debe aparecer en obras de tipo serie y anime
        if(type == 'tv' || type == 'anime'){
          getBottomModalWatchingStatus(context, ouevre);
           
        }else if(type == 'movie'){
          getFlushbarSuccessWatching(context);
        }
        break;

        }

        case ConstantsStatus.pause: {

          return  getBottomModalPauseOrDroppedStatus(context, ouevre);
          
        }

        case ConstantsStatus.dropped: {

          return  getBottomModalPauseOrDroppedStatus(context, ouevre);
          
        }

        case ConstantsStatus.wishlist: {

          return getFlushbarSuccessWishlist(context, ouevre);
          
        }
      }
    }

  //? Get ModalBottomSheet for Completed Status 

  void getOptionsCompleteStatus(BuildContext context, OuevreEntity newOuevre){
    showModalBottomSheet(
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      elevation: 10.0,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      builder: (context) => _buildBottomModalOptionsComplete(context, newOuevre),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20)
        )
      )
    );
  }

  Widget _buildBottomModalOptionsComplete(BuildContext context, OuevreEntity newOuevre){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                ratingSimpleModalBottomSheet(context, newOuevre);
              },
              title: Text(AppLocalizations.of(context).translate("title_simple_rating"),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),) ,
              subtitle: Text(AppLocalizations.of(context).translate("label_simple_rating"),style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
              leading: Icon(Icons.edit_attributes, color: Colors.pinkAccent[400],),
            )
          ),
          Flexible(
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                ratingDetailsModalBottomSheet(context, newOuevre);
              },
              title: Text(AppLocalizations.of(context).translate("title_details_rating"),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),) ,
              subtitle: Text(AppLocalizations.of(context).translate("label_details_rating"),style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
              leading: Icon(Icons.assignment, color: Colors.deepPurpleAccent[400],),
            )
          ),
        ],
      );
  }

  void ratingSimpleModalBottomSheet(BuildContext context, OuevreEntity newOuevre){
    showModalBottomSheet(
      elevation: 10.0,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      builder: (context) {
        return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: BuildBottomModalCompleteSimple(newOuevre: newOuevre,),
        );   
      }, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
    );
  }

  void ratingDetailsModalBottomSheet(BuildContext context, OuevreEntity newOuevre){
    showModalBottomSheet(
      elevation: 10.0,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      builder: (context) {
        return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: BuildBottomModalCompleteInDetails(newOuevre: newOuevre),
        );   
      }, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
    );
  }

  //? Get ModalBottomSheet for Watching Status 

  void getBottomModalWatchingStatus(BuildContext context, OuevreEntity newOuevre){
    showModalBottomSheet(
      elevation: 10.0,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      builder: (context) {
        return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: BuildBottomModalWatching(newOuevre: newOuevre),
        );
      }, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20)
        )
      )
    );
  }

  void getFlushbarSuccessWatching(BuildContext context){
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.lightBlueAccent, Colors.lightBlueAccent[400]],),
      backgroundColor: Colors.lightBlueAccent[700],
      boxShadows: [BoxShadow(color: Colors.lightBlueAccent[700], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
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


  //? Get ModalBottomSheet for Pause or Dropped Status 

  void getBottomModalPauseOrDroppedStatus(BuildContext context, OuevreEntity newOuevre){
    showModalBottomSheet(
      elevation: 10.0,
      backgroundColor: getBackgroundColorTheme(), 
      context: context,
      barrierColor: Colors.blueGrey.withOpacity(0.3),
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider<AddOuevreBloc>(
          create: (_) => serviceLocator<AddOuevreBloc>(),
          child: BuildBottomModalPauseOrDropped(newOuevre: newOuevre),
        );
      }, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20)
        )
      )
    );
  }

  //? Get ModalBottomSheet for Wishlist Status 

  void getFlushbarSuccessWishlist(BuildContext context, OuevreEntity newOuevre){
    
      bloc..add(
        ButtonAddPressed(
          ouevreEntity: newOuevre, 
          type: type
        )
      );
    

    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      borderRadius: 10,
      backgroundGradient: LinearGradient(colors: [Colors.deepPurpleAccent, Colors.purpleAccent[400]],),
      backgroundColor: Colors.purpleAccent[400],
      boxShadows: [BoxShadow(color: Colors.purpleAccent[700], offset: Offset(0.5, 0.5), blurRadius: 1.0,)],
      duration: Duration(seconds: 3),
      messageText: Text(
        AppLocalizations.of(context).translate("added_success_wish"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0
        ),
        ),
    )..show(context);
    
  }


}

