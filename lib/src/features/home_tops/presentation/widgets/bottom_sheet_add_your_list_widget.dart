import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomSheetAddInList {

  //?Variables
  final prefs = new Preferences();


   showButtomModalMaterial(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: _getBackgroundColorTheme(), 
      context: context,
      builder: (context) => _buildBottomModal(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30)
        )
      )
    );

  }

  Widget _buildBottomModal() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
        Flexible(child: _buttonStatus('Complete', Colors.green[600], Icons.check_circle), flex: 1,),
        Flexible(child:_buttonStatus('Watching', Colors.lightBlue[600], Icons.play_circle_filled), flex: 1,),
        Flexible(child:_buttonStatus('Pause', Colors.orangeAccent[700], Icons.pause_circle_filled), flex: 1,),
        Flexible(child:_buttonStatus('Dropped', Colors.red[800], Icons.remove_circle), flex: 1,),
        Flexible(child:_buttonStatus('WishList', Colors.purple[500], Icons.add_circle), flex: 1,),
        ],
    );
  }



  Widget _buttonStatus(String title, Color color, IconData icon){
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)),
      leading: Icon(icon, color: color, size: 35.0,),
      onTap: () {},
    );
  }

  Color _getBackgroundColorTheme() {
    if(prefs.whatModeIs){
      return Colors.grey[900];
    }else{
      return Colors.white;
    }
  }


}

