import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/circular_chart_rating.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_update/update_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/emptys_list_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';




class CreateTopFaviritesWidget extends StatefulWidget {

  final Map<dynamic, dynamic> data;
  CreateTopFaviritesWidget({
    @required this.data
  });

  @override
  _CreateTopFaviritesWidgetState createState() => _CreateTopFaviritesWidgetState();
}

class _CreateTopFaviritesWidgetState extends State<CreateTopFaviritesWidget> {

 
  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        leading: AppBarButtonBack(),
      ),
      body: _buildBody()
    );
  }

  Widget _buildBody() {

    final String type = widget.data['type'];
    final int maxSelected = widget.data['maxSelected'];

    return new BlocProvider<GetListsBloc>(
      create: (_) => serviceLocator<GetListsBloc>(),
      child: BuildCreateTopFavoritesWidget(type: type, maxSelected: maxSelected,)
    );
  }

  String _getTitle(){
    final String type = widget.data['type'];

    if(type == 'movie'){
      
      return AppLocalizations.of(context).translate("title_create_top_movie_favorites");

    }else if(type == 'tv'){

      return AppLocalizations.of(context).translate("title_create_top_serie_favorites");

    }else if(type == 'anime'){

      return AppLocalizations.of(context).translate("title_create_top_anime_favorites");

    }
     return AppLocalizations.of(context).translate("title_create_top_movie_favorites");
  }

  
 
}


class BuildCreateTopFavoritesWidget extends StatefulWidget {
  final String type;
  final int maxSelected;  

  BuildCreateTopFavoritesWidget({
    @required this.type,
    @required this.maxSelected
  });

  @override
  _BuildCreateTopFavoritesWidgetState createState() => _BuildCreateTopFavoritesWidgetState();
}

class _BuildCreateTopFavoritesWidgetState extends State<BuildCreateTopFavoritesWidget> {
  
  
  int totalSelected = 0;
  int totalSelect = 0;
  List<OuevreEntity> listOfSelected = new List<OuevreEntity>();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: ListProfileQuery.Completed)
    );
  }

  @override
  Widget build(BuildContext context) {
    


    return BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){


          return LoadingCustomWidget();


        }else if(state is GetListsLoaded){

         if(state.ouevreList.isEmpty){

           return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("completed_empty_label"),
            color: Colors.greenAccent[400],
            icon: Icons.check_circle_outline,
          );
          
         } 
          
          return _buildListSelectTops(state.ouevreList);


        }else if(state is GetlistsError){
          
          return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("completed_empty_label"),
            color: Colors.greenAccent[400],
            icon: Icons.check_circle_outline,
          );

        }



        return ListProfileEmptyIconWidget(
            title: AppLocalizations.of(context).translate("completed_empty_label"),
            color: Colors.greenAccent[400],
            icon: Icons.check_circle_outline,
          );

      },
    );

    
  }

  Widget _buildListSelectTops(List<OuevreEntity> ouevreList){
    

    return Column(
        children: [
          _labelTotalItemSelect(),
          _buildListItems(ouevreList),
          _buildButtonCreateTops()
        ],
      );
  }

  Widget _buildButtonCreateTops(){
    return new BlocProvider<AddOuevreBloc>(
      create: (_) => serviceLocator<AddOuevreBloc>(),
      child: ButtonCreateTopFavorites(totalSelected: totalSelected, listFavorites: listOfSelected, topPosition: totalSelect,)
    );
  }

  Widget _labelTotalItemSelect() {

    int maxSel = widget.maxSelected;

    maxSel++;

    String label = '$totalSelect / $maxSel';

    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
    );
  }

  Widget _buildListItems(List<OuevreEntity> ouevreList) {

    return Expanded(
      flex: 12,
      child: ListView.builder(
        itemExtent: 90.0,
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        itemCount: ouevreList.length,
        itemBuilder: (context, index) => ItemCreteTopFavorites(
          item: ouevreList[index],
          key: Key(ouevreList[index].positionListFav.toString()),
          position: listOfSelected.lastIndexOf(ouevreList[index])+1,
          maxSelected: widget.maxSelected,
          totalSelected: totalSelected,
          isSelected: (value) {
            setState(() {
              if(value){

                ouevreList.forEach((element) { 
                  if(element.isFavorite != null && element.isFavorite){
                    totalSelected+=1;
                  }
                });

                if(listOfSelected.length < widget.maxSelected){
                  totalSelect+=1;
                  listOfSelected.add(ouevreList[index]);
                  
                }else{
                  totalSelect-=1;
                  listOfSelected.removeLast();
                  totalSelect+=1;
                  listOfSelected.add(ouevreList[index]);
                }
                
              }else{
                totalSelect-=1;
                listOfSelected.remove(ouevreList[index]);
              }
            
            print("$index : $value");
            });  
          },

        )
      ),
    );
  }
}


class ItemCreteTopFavorites extends StatefulWidget {

  final Key key;
  final OuevreEntity item;
  final ValueChanged<bool> isSelected;
  final int position;
  final int maxSelected;
  final int totalSelected;

  ItemCreteTopFavorites({
    this.key,
    this.isSelected,
    this.item,
    this.position,
    this.maxSelected,
    this.totalSelected
  });

  @override
  _ItemCreteTopFavoritesState createState() => _ItemCreteTopFavoritesState();
}

class _ItemCreteTopFavoritesState extends State<ItemCreteTopFavorites> with AutomaticKeepAliveClientMixin {
  bool isSelected = false;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {

          isSelected = !isSelected;
          widget.isSelected(isSelected);

        }); 
      },
      child: (widget.item.isFavorite != null && widget.item.isFavorite) 
      ? _buildItemSelect()
      : (isSelected && widget.position != 0)
          ? _buildItemSelect()
          : _buildItemDeselect()
    );
  }

  Widget _buildItemDeselect(){
    return Container(
      height: 90,
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
           _imageBackground(widget.item),
           _buildListTile(widget.item)
         ],
        ),
      ),
    );
  }


  Widget _buildItemSelect(){


      return Container(
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.grey[400].withOpacity(0.4)
        ), 
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                (widget.item.isFavorite != null && widget.item.isFavorite) 
                  ? widget.item.positionListFav.toString()
                  : (widget.maxSelected < 1) 
                    ? widget.totalSelected.toString()
                    : widget.position.toString(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
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
                     _imageBackground(widget.item),
                     _buildListTile(widget.item)
                   ],
                  ),
                ),
              ),
           // ),
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


  Widget _buildListTile(OuevreEntity item){
    return ListTile(
      title: _itemTitle(item),
      leading: _itemRate(item),
      trailing: _itemDate(item),
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

  

  Widget _itemRate(OuevreEntity ouevre) {
    return MiniCircularChartRating(ouevre.finalRate);
  }

  Widget _itemDate(OuevreEntity ouevre) {

    final DateTime datetime = ouevre.addDate;

    final formatter = DateFormat('dd-MM-yy');

    final date = formatter.format(datetime);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.today, color: Colors.pink,),
        Text(date, 
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0, 
          fontWeight: FontWeight.w800,
          shadows: [
          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          )
          ),       
      ],
    );
  }

   @override
  bool get wantKeepAlive => true;

}

class ButtonCreateTopFavorites extends StatefulWidget {
  
  final int totalSelected;
  final List<OuevreEntity> listFavorites;
  final int topPosition;
  
  ButtonCreateTopFavorites({
    @required this.totalSelected,
    @required this.listFavorites,
    @required this.topPosition
  });

  @override
  _ButtonCreateTopFavoritesState createState() => _ButtonCreateTopFavoritesState();
}

class _ButtonCreateTopFavoritesState extends State<ButtonCreateTopFavorites> {
  
  final List<OuevreEntity> listSelected = new List<OuevreEntity>();
  int position = 0;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 6.0
        ),
        child: RaisedButton(
          padding: const EdgeInsets.all(2.0),
          onPressed: (widget.topPosition > 0) 
          ? _createlistFav
          : null,
          color: Colors.pinkAccent[400],
          disabledColor: Colors.pinkAccent[700],
          elevation: 10.0,
          disabledElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate("btn_label_create_top"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            )
          ),
        ),
      ),
    );
  }

  void _createlistFav(){

    if(widget.listFavorites.length == 0){

      OuevreEntity item = widget.listFavorites[0];

      item.isFavorite = true;
      item.positionListFav = widget.topPosition;

       BlocProvider.of<AddOuevreBloc>(context)..add(
        ButtonAddPressed( type: item.oeuvreType, ouevreEntity: item )
      );

      Navigator.of(context).pop();

    }else{
      widget.listFavorites.forEach((item) { 
      position++;

      item.isFavorite = true;
      item.positionListFav = position;

       BlocProvider.of<AddOuevreBloc>(context)..add(
        ButtonAddPressed( type: item.oeuvreType, ouevreEntity: item )
      );

    });
      Navigator.of(context).pop();
    }
    
  }
}