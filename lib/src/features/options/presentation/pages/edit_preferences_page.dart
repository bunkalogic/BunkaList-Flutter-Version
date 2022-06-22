import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/widgets/list_personalized_tops_widget.dart';
import 'package:flutter/material.dart';


class EditPreferencesPage extends StatefulWidget {
  EditPreferencesPage({Key key}) : super(key: key);

  @override
  _EditPreferencesPageState createState() => _EditPreferencesPageState();
}

class _EditPreferencesPageState extends State<EditPreferencesPage> {
  
  Preferences prefs = Preferences();
  bool hideAll = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("label_edit_preferences")),
          leading: AppBarButtonBack(),
      ),
      body: _listViewOptions(),

    );
  }

   Widget _titleOfSections(String title){
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold ),
      ),
    );
  }

  Widget _titleOfSectionsPremium(){
    return Center(
      child: Text(
        "PREMIUM",
        style: TextStyle(
        fontSize: 12.0, 
        fontWeight: FontWeight.bold, 
        color: prefs.whatModeIs 
          ? Colors.pinkAccent[400] 
          : Colors.deepPurpleAccent[400],  
        ),
      ),
    );
  }

  Widget _createItemSettings({IconData icon, String text, Widget trailing, void Function() onTap}) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.w600),),
      leading: Icon(
        icon, 
        size: 25.0, 
        color: prefs.whatModeIs 
          ? Colors.pinkAccent[400] 
          : Colors.deepPurpleAccent[400], 
      ),
      trailing: trailing,
      onTap: onTap,
      // enabled: prefs.isNotAds,
    );
  }



  Widget _listViewOptions() {

    final bool isPremium = prefs.isNotAds;

    return ListView(
      children: [
        SizedBox(height: 25.0,),
        _titleOfSections(AppLocalizations.of(context).translate("label_edit_explorer_and_tops")),
        Divider(),
        _createItemSettings(
          icon: Icons.clear_all_rounded,
          text: AppLocalizations.of(context).translate("label_hide_all_in_your_list"),
          trailing: Switch(
            activeColor: prefs.whatModeIs 
              ? Colors.pinkAccent[400] 
              : Colors.deepPurpleAccent[400],
            value: hideAll, 
            onChanged: (bool value){
              hideAll = value;
              prefs.hideMoviesInList = value;
              prefs.hideSeriesInList = value;
              prefs.hideAnimeInList = value;

              setState(() {});
            }),
        ),

        _createItemSettings(
          icon: Icons.view_column_rounded,
          text: AppLocalizations.of(context).translate("label_prefrences_number_column"),
          trailing: Text(
            prefs.totalColumnList.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
            ),
          ),
          onTap: (){
            
           final int totalColumn = prefs.totalColumnList;


            switch (totalColumn) {
              case 3: {
                print('${prefs.totalColumnList}');
                prefs.totalColumnList = 4;
                setState(() {});
              }
                break;

              case 4: {
                print('${prefs.totalColumnList}');
                prefs.totalColumnList = 2;
                setState(() {});
              }
                break;
              
              case 2: {
                print('${prefs.totalColumnList}');
                prefs.totalColumnList = 3;
                setState(() {});
              }
                break;    
              default: {
                prefs.totalColumnList = 3;
                setState(() {});
              }
            }
            


          }
        ),
        SizedBox(height: 10.0,),
        _titleOfSectionsPremium(),
        Divider(),
        _createItemSettings(
          icon: Icons.auto_fix_high,
          text: AppLocalizations.of(context).translate("title_label_edit_home_tops"),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 24,
            color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
          ),
          onTap: (){


            if(prefs.isNotAds){
              Navigator.of(context).push(PageRouteBuilder(
                opaque: true,
                pageBuilder: (BuildContext context, _, __) => ListPersonalizedTopsWidget(),
              ));
            }else{
              Navigator.pushNamed(context, '/Premium');
            }
            

          }
        ),

        _createItemSettings(
          icon: prefs.isNotAds
            ? Icons.local_movies_outlined
            : Icons.lock_rounded, 
          text: AppLocalizations.of(context).translate("label_hide_movies_in_your_list"),
          trailing: Switch(
            activeColor: prefs.whatModeIs 
              ? Colors.pinkAccent[400] 
              : Colors.deepPurpleAccent[400],
            value: prefs.hideMoviesInList, 
            onChanged: isPremium 
            ? (bool value){

              
                prefs.hideMoviesInList = value;
                setState(() {});
              

              
            }
            : null
            
            ),
        ),
        _createItemSettings(
          icon: prefs.isNotAds
            ? Icons.tv_off_rounded
            : Icons.lock_rounded,
          text: AppLocalizations.of(context).translate("label_hide_series_in_your_list"),
          trailing: Switch(
            activeColor: prefs.whatModeIs 
              ? Colors.pinkAccent[400] 
              : Colors.deepPurpleAccent[400],
            value: prefs.hideSeriesInList, 
            onChanged: isPremium 
            ? (bool value){

              
                prefs.hideSeriesInList = value;
                setState(() {});
               
              
              
            }
            : null
            ),
        ),
        _createItemSettings(
          icon: prefs.isNotAds
            ? Icons.reset_tv
            : Icons.lock_rounded,
          text: AppLocalizations.of(context).translate("label_hide_animes_in_your_list"),
          trailing: Switch(
            activeColor: prefs.whatModeIs 
              ? Colors.pinkAccent[400] 
              : Colors.deepPurpleAccent[400],
            value: prefs.hideAnimeInList, 
            onChanged: isPremium 
            ? (bool value){

              
                prefs.hideAnimeInList = value;
                setState(() {});
               
              
            }
            : null
            
            ),
        ),
        SizedBox(height: 20.0,),
        // _titleOfSections(AppLocalizations.of(context).translate("label_edit_pofile")),
        // Divider(),
        // SizedBox(height: 10.0,),
        // _titleOfSectionsPremium(),
        // Divider(),
        // _createItemSettings(
        //   icon: prefs.isNotAds
        //     ? Icons.play_arrow_rounded
        //     : Icons.lock_rounded,
        //   text: AppLocalizations.of(context).translate("label_design_watchlist"),
        //   trailing: IconButton(
        //     icon: Icon(
        //       prefs.currentDesignWatching ? Icons.art_track_rounded : Icons.horizontal_split_rounded,
        //       color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        //       size: 34,
        //     ), 
        //     onPressed: (){
              
        //       if(prefs.isNotAds){
        //         prefs.currentDesignWatching = !prefs.currentDesignWatching;
        //         setState(() {});
        //       }else{
        //         Navigator.pushNamed(context, '/Premium');
        //       }
              
        //     }
        //   ),
        // ),
        // _createItemSettings(
        //   icon: prefs.isNotAds
        //     ? Icons.history
        //     : Icons.lock_rounded,
        //   text: AppLocalizations.of(context).translate("label_design_history"),
        //   trailing: IconButton(
        //     icon: Icon(
        //       prefs.currentDesignWatching ? Icons.amp_stories : Icons.horizontal_split_rounded,
        //       color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        //       size: 34,
        //     ), 
        //     onPressed: (){
              
        //       if(prefs.isNotAds){
        //         prefs.currentDesignHistory = !prefs.currentDesignHistory;
        //         setState(() {});
        //       }else{
        //         Navigator.pushNamed(context, '/Premium');
        //       }
              
        //     }
        //   ),
        // ),
        // _createItemSettings(
        //   icon: prefs.isNotAds
        //     ? Icons.playlist_add_rounded
        //     : Icons.lock_rounded,
        //   text: AppLocalizations.of(context).translate("label_design_wishlist"),
        //   trailing: IconButton(
        //     icon: Icon(
        //       prefs.currentDesignWatching ? Icons.amp_stories : Icons.horizontal_split_rounded,
        //       color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
        //       size: 34,
        //     ), 
        //     onPressed: (){
              
        //       if(prefs.isNotAds){
        //         prefs.currentDesignWishlist = !prefs.currentDesignWishlist;
        //         setState(() {});
        //       }else{
        //         Navigator.pushNamed(context, '/Premium');
        //       }
              
        //     }
        //   ),
        // ),
      ],
    );
  }
}