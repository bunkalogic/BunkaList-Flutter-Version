
import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReorderTopWidget extends StatefulWidget {


  final List<OuevreEntity> ouevreList;

  ReorderTopWidget({@required this.ouevreList});

  @override
  _ReorderTopWidgetState createState() => _ReorderTopWidgetState();
}

class _ReorderTopWidgetState extends State<ReorderTopWidget> {

  List<Widget> itemsWidget = List<Widget>();
  // int position = 0;
  List<OuevreEntity> ouevreList = List<OuevreEntity>();

  @override
  void initState() {
    super.initState();
    ouevreList = widget.ouevreList;

    ouevreList.forEach((item) { 

      // position++;

      Widget widget = _buildItem(item, item.positionListFav);
        
      itemsWidget.add(widget);
    });

    if(ouevreList.length < 9){
      itemsWidget.add(itemEmptyAddNewItem());
    }
  }

  @override
  Widget build(BuildContext context) {

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget itemWidget = itemsWidget.removeAt(oldIndex);

        itemsWidget.insert(newIndex, itemWidget);
        

        if (newIndex > ouevreList.length) newIndex = ouevreList.length;
        if (oldIndex < newIndex) newIndex--;

        OuevreEntity item = ouevreList[oldIndex];
        ouevreList.remove(item);
        ouevreList.insert(newIndex, item);
    
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        leading: AppBarButtonBack(),
      ),
      body: ReorderableListView(
        children: itemsWidget,
        onReorder: _onReorder,
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    
  }

  String _getTitle(){
    final String type = widget.ouevreList[0].oeuvreType;

    if(type == 'movie'){
      
      return AppLocalizations.of(context).translate("title_edit_top_movie_favorites");

    }else if(type == 'tv'){

      return AppLocalizations.of(context).translate("title_edit_top_serie_favorites");

    }else if(type == 'anime'){

      return AppLocalizations.of(context).translate("title_edit_top_anime_favorites");

    }
     return AppLocalizations.of(context).translate("title_edit_top_movie_favorites");
  }

  Widget _buildFab(){
    return new BlocProvider<AddOuevreBloc>(
      builder: (_) => serviceLocator<AddOuevreBloc>(),
      child: ButtonUpdateTopFavorites(listOuevre: ouevreList,)
    );
  }

  Widget _buildItem(OuevreEntity item, int position){
    return Container(
      key: ValueKey(item.oeuvreId),
      height: 70.0,
      child: Row(
        children: [
          _itemPosition(position),
          Expanded(
            flex: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0 ),
              borderOnForeground: false,
              child: Stack(
               fit: StackFit.expand, 
               children: <Widget>[
                 _imageBackground(item),
                 _buildListTile(item, position)
               ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageBackground(OuevreEntity item) {
    return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            image: NetworkImage(item.oeuvrePoster),
            placeholder: AssetImage('assets/poster_placeholder.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
  }


  Widget _buildListTile(OuevreEntity item, int position){
    return ListTile(
      title: _itemTitle(item),
      leading:_iconDraggable(),
      trailing: _iconRemove(item, position),
      contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0 ),
    );
  }


  Widget _itemTitle(OuevreEntity item) {
    return Text(
      item.oeuvreTitle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        shadows: [
          Shadow(
              color: Colors.black,
              blurRadius: 2.5,
          )
        ]
      ),
    );
  }

  Widget _itemPosition(int position) {
    
    String label = '$position.';

    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(
                  color: Colors.black,
                  blurRadius: 2.5,
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget _iconDraggable(){
    return Icon(
      Icons.reorder_rounded,
      color: Colors.pinkAccent[400],
      size: 35.0,
    );
  }

  Widget _iconRemove(OuevreEntity item, int position){
    return new BlocProvider<AddOuevreBloc>(
      builder: (_) => serviceLocator<AddOuevreBloc>(),
      child: IconRemoveItemList(
        ouevreEntity: item,
        isDelete: (value) {
          if(value){

            itemsWidget.add(itemEmptyAddNewItem());            
            ouevreList.removeAt(position);

            itemsWidget.removeAt(position);

            setState(() {});
          }
        },
      ),
    );
  }

  Widget itemEmptyAddNewItem(){
    return ListTile(
      key: ValueKey(-1),
      title: Icon(
        Icons.addchart_rounded,
        color: Colors.pinkAccent[400],
        size: 34.0,
      ),
      onTap: (){
        Navigator.pushNamed(context, '/TopFavCreate', arguments: getTypeAndMaxSelected( 0, widget.ouevreList[0].oeuvreType ));
        setState(() {});
      },
    );
  }
  
}


class IconRemoveItemList extends StatefulWidget {

  final OuevreEntity ouevreEntity;
   final ValueChanged<bool> isDelete;

  IconRemoveItemList({
    @required this.ouevreEntity,
    @required this.isDelete
  });

  @override
  _IconRemoveItemListState createState() => _IconRemoveItemListState();
}

class _IconRemoveItemListState extends State<IconRemoveItemList> {
  
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // remove to the top

        showDialog(
          context: context,
          builder: (context){
            return _buildDialog();
          }
        );
      },
      child: Icon(
        Icons.delete_forever,
        color: Colors.pinkAccent[400],
        size: 35.0,
      ),
    );
  }

  Widget _buildDialog(){
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
      onPressed: () {
        Navigator.of(context).pop();

        widget.isDelete(false);

      }, 
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

        widget.ouevreEntity.isFavorite = false;
        widget.ouevreEntity.positionListFav = -1;

        BlocProvider.of<AddOuevreBloc>(context)..add(
          ButtonAddPressed( type: widget.ouevreEntity.oeuvreType, ouevreEntity: widget.ouevreEntity)
        );

        widget.isDelete(true);


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



class ButtonUpdateTopFavorites extends StatefulWidget {
  
  final List<OuevreEntity> listOuevre;
  
  ButtonUpdateTopFavorites({
    @required this.listOuevre
  });

  @override
  _ButtonUpdateTopFavoritesState createState() => _ButtonUpdateTopFavoritesState();
}

class _ButtonUpdateTopFavoritesState extends State<ButtonUpdateTopFavorites> {
  
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 10.0,
      backgroundColor: _getBackgroundColorTheme(),
      onPressed: (){

      Navigator.of(context).pop();

      widget.listOuevre.forEach((item) {
        
        print('${item.oeuvreTitle} old position => ${item.positionListFav}'); 
        // setState(() {
          position+=1;

          item.positionListFav = position;
        // });

        print('${item.oeuvreTitle} new position => ${item.positionListFav}'); 

        BlocProvider.of<AddOuevreBloc>(context)..add(
          ButtonAddPressed( type: item.oeuvreType, ouevreEntity: item)
        );

      });
    

      }, 
      label: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.pinkAccent[400],
                ),
              ),
              Text(
                AppLocalizations.of(context).translate("btn_label_edit_save_top"),
                style: TextStyle(
                  color: Colors.pinkAccent[400],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700
                ),
              )
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
}

