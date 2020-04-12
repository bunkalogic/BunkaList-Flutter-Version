
import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/last_added_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/total_views_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Preferences prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _createProfileDesign(context),
    );
  }
  
  
  //!  Common Components (Android & iOS)

  Widget _createProfileDesign(BuildContext context) {
    return PlatformWidget(
      android: (context) => _profileDesignMaterial(context),
      ios: (context) => _profileDesignCupertino(context),
    );
  }

  Widget _createBox() {
        //! posible cambio por un card para ponerle elevation
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(   
          child:  _infoProfileBox(),
          height: 185.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              colors: [
                Colors.blueGrey[500].withOpacity(0.1),
                Colors.blueGrey[500].withOpacity(0.1),
                Colors.blueGrey[500].withOpacity(0.1),
                Colors.blueGrey[500].withOpacity(0.1)
              ]
            ) 
          ),
        ),
    );
  }

  Widget _infoProfileBox() {
     return Container(
       padding: EdgeInsets.all(6.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           _profileImage(),
           _profileName(),
           SizedBox(height: 8.0,),
           _profileTotalViews(),
         ],
       ),
     );
   }

  Widget _profileImage() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: CircleAvatar(
        backgroundImage: NetworkImage(prefs.getCurrentUserPhoto),
      )
    );
  }

  Widget _profileName() {
    return Text(prefs.getCurrentUsername, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold), );
  }

  Widget _profileTotalViews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: TotalViewsWidget(status: 'Total', type: 'movie',),
          ),
        new BlocProvider<GetListsBloc>(
          builder: (_) => serviceLocator<GetListsBloc>(),
          child: TotalViewsWidget(status: 'Total', type: 'tv',),
        ),
        new BlocProvider<GetListsBloc>(
          builder: (_) => serviceLocator<GetListsBloc>(),
          child: TotalViewsWidget(status: 'Total', type: 'anime',),
        ),
      ],
    );
  }

  

  Widget _titleScrollSection(String title) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      ),
    );
  }

  

  Widget _buttomPlatformList(BuildContext context){
    return PlatformWidget(
        android: (context) => _buttonsTypeListMaterial(context),
        ios: (context) => _buttonsTypeListCupertino(context),
    );
  }
  

  //! Material Components (Android)

  Widget _profileDesignMaterial(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: <Widget>[
        _createBox(),
        SizedBox(height: 5.0,),
        _buttomPlatformList(context),
        SizedBox(height: 10.0,),
        _titleScrollSection(AppLocalizations.of(context).translate("last_views_movie")),
        SizedBox(height: 5.0,),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: LastAddedItem(status: 'Last', type: 'movie',),
          ),
        SizedBox(height: 10.0,),
        _titleScrollSection(AppLocalizations.of(context).translate("last_views_serie")),
        SizedBox(height: 5.0,),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: LastAddedItem(status: 'Last', type: 'tv',),
          ),
        SizedBox(height: 10.0,),
        _titleScrollSection(AppLocalizations.of(context).translate("last_views_anime")),
        SizedBox(height: 5.0,),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: LastAddedItem(status: 'Last', type: 'anime',),
          ),
        SizedBox(height: 25.0,),    
      ],
    );
  }

  Widget _buttonsTypeListMaterial(BuildContext context){ 
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buttonTypeMaterial(context, AppLocalizations.of(context).translate("list_movies"), Colors.redAccent, 0),
        SizedBox(width: 10.0,),
        _buttonTypeMaterial(context,  AppLocalizations.of(context).translate("list_series"), Colors.greenAccent[400], 1),
        SizedBox(width: 10.0,),
        _buttonTypeMaterial(context,  AppLocalizations.of(context).translate("list_animes"), Colors.lightBlueAccent, 2),
      ],
    );
  }

  Widget _buttonTypeMaterial(BuildContext context,String title, Color color, int type) {
      return Flexible(
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          color: color,
          child: Text(title,
          overflow: TextOverflow.ellipsis, 
          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
          onPressed: (){
            //TODO refactor this method 
            //? pushNamed con los arguments con el numberType de la firestore
            // movies == 0
            // series == 1
            // anime == 2
            Navigator.pushNamed(context, '/ListProfile', arguments: type);
          },
        ),
      );
  }
  

  //! Cupertino Components (iOS)

  Widget _profileDesignCupertino(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: <Widget>[
        _createBox(),
        SizedBox(height: 5.0,),
        _buttomPlatformList(context),
        SizedBox(height: 20.0,),
        _titleScrollSection('The last views of Movies :'),
        SizedBox(height: 5.0,),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: LastAddedItem(status: 'Last', type: 'movie',),
          ),
        _titleScrollSection('The last views of Series :'),
        SizedBox(height: 10.0,),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: LastAddedItem(status: 'Last', type: 'tv',),
          ),
        _titleScrollSection('The last views of Animes :'),
        SizedBox(height: 10.0,),
        new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: LastAddedItem(status: 'Last', type: 'anime',),
          ),
      ],
    );
  }

  _buttonsTypeListCupertino(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buttonTypeCupertino('List Movies', Colors.redAccent, 0, context),
        SizedBox(width: 10.0,),
        _buttonTypeCupertino('List Series TV', Colors.greenAccent[400], 1, context),
        SizedBox(width: 10.0,),
        _buttonTypeCupertino('List Anime', Colors.lightBlueAccent, 2, context),
      ],
    );
  }

  Widget _buttonTypeCupertino(String title, Color color,  int type, BuildContext context) {
      return CupertinoButton(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
        child: Text(title, style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),
        onPressed: (){
          //TODO refactor this method 
          //? pushNamed con los arguments con el numberType de la firestore
          // movies == 0
          // series == 1
          // anime == 2
          Navigator.pushNamed(context, '/ListProfile', arguments: type);
        },
      );
  }

  
  

  

  

 

  
}