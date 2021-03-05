import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/widgets/build_filter_params_widget.dart';
import 'package:flutter/material.dart';


class ListPersonalizedTopsWidget extends StatefulWidget {
  ListPersonalizedTopsWidget({Key key}) : super(key: key);

  @override
  _ListPersonalizedTopsWidgetState createState() => _ListPersonalizedTopsWidgetState();
}

class _ListPersonalizedTopsWidgetState extends State<ListPersonalizedTopsWidget> {
  
  Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("title_label_edit_home_tops")),
          leading: AppBarButtonBack(),
      ),
      body: _listViewOfHomeTops(),
    );
  }

  Widget _listViewOfHomeTops() {

    FilterParams homeTops1 =  FilterParams.fromJson(prefs.getHomeTops1);
    FilterParams homeTops2 =  FilterParams.fromJson(prefs.getHomeTops2);
    FilterParams homeTops3 =  FilterParams.fromJson(prefs.getHomeTops3);
    FilterParams homeTops4 =  FilterParams.fromJson(prefs.getHomeTops4);
    FilterParams homeTops5 =  FilterParams.fromJson(prefs.getHomeTops5);
    FilterParams homeTops6 =  FilterParams.fromJson(prefs.getHomeTops6);
    FilterParams homeTops7 =  FilterParams.fromJson(prefs.getHomeTops7);
    FilterParams homeTops8 =  FilterParams.fromJson(prefs.getHomeTops8);
    FilterParams homeTops9 =  FilterParams.fromJson(prefs.getHomeTops9);

    return ListView(
      children: [
        SizedBox(height: 30,),
        listTileHomeTops(homeTops1, 1),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops2, 2),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops3, 3),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops4, 4),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops5, 5),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops6, 6),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops7, 7),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops8, 8),
        SizedBox(height: 10,),
        listTileHomeTops(homeTops9, 9),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget listTileHomeTops(FilterParams homeTops, int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        elevation: 5.0,
        color: _getTabbarBackgroundColor(),
        margin: const EdgeInsets.all(4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: ListTile(
          leading: _buttonChangedDesign(homeTops, index),
          title: Text(homeTops.title ?? 'Home Tops $index',
          overflow: TextOverflow.ellipsis, 
          style: TextStyle(fontSize: 18),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 30,
            color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
          ),
          onTap: (){

      
            Navigator.of(context).push(PageRouteBuilder(
              opaque: true,
              pageBuilder: (BuildContext context, _, __) => BuildFilterParamsWidget(
                homeTops: (FilterParams newHomeTops){
                  
                  updateFilter(newHomeTops, index);

                  setState(() {});
                }
              ),
            ));


          },
        ),
      ),
    );

  }

  Color _getTabbarBackgroundColor(){

    final bool theme = prefs.whatModeIs;
    final bool dark = prefs.whatDarkIs;
    
    if(theme && dark == false){
      return Colors.blueGrey[800];
    }else if(theme && dark){
      return Colors.grey[900];
    }else{
      return Colors.grey[100];
    }
 }

  Widget _buttonChangedDesign(FilterParams homeTops, int index) {
    return Icon(
        homeTops.design 
          ? Icons.view_compact_rounded
          : Icons.view_carousel_rounded ,
        size: 35,
        color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
      ); 
  }



  void updateFilter(FilterParams homeTops, int index){

    FilterParams homeTops1 =  FilterParams.fromJson(prefs.getHomeTops1);
    FilterParams homeTops2 =  FilterParams.fromJson(prefs.getHomeTops2);
    FilterParams homeTops3 =  FilterParams.fromJson(prefs.getHomeTops3);
    FilterParams homeTops4 =  FilterParams.fromJson(prefs.getHomeTops4);
    FilterParams homeTops5 =  FilterParams.fromJson(prefs.getHomeTops5);
    FilterParams homeTops6 =  FilterParams.fromJson(prefs.getHomeTops6);
    FilterParams homeTops7 =  FilterParams.fromJson(prefs.getHomeTops7);
    FilterParams homeTops8 =  FilterParams.fromJson(prefs.getHomeTops8);
    FilterParams homeTops9 =  FilterParams.fromJson(prefs.getHomeTops9);


    switch (index) {
      case 1:{
         homeTops1 = homeTops;
         prefs.getHomeTops1 = homeTops1;
      }
      break; 

      case 2:{
        homeTops2 = homeTops;
        prefs.getHomeTops2 = homeTops2;
      }
      break; 

      case 3:{

        homeTops3 = homeTops;
        prefs.getHomeTops3 = homeTops3;

      }
      break;

      case 4:{
        homeTops4 = homeTops;
        prefs.getHomeTops4 = homeTops4;
      }
      break;

      case 5:{
        homeTops5 = homeTops;
        prefs.getHomeTops5 = homeTops5;
      }
      break;

      case 6:{
        homeTops6 = homeTops;
        prefs.getHomeTops6 = homeTops6;
      }
      break;

      case 7:{
        homeTops7 = homeTops;
        prefs.getHomeTops7 = homeTops7;
      }
      break;

      case 8:{
        homeTops8 = homeTops;
        prefs.getHomeTops8 = homeTops8;
      }
      break;

      case 9:{
        homeTops9 = homeTops;
        prefs.getHomeTops9 = homeTops9;
      }
      break;  
       
    }
  }
}