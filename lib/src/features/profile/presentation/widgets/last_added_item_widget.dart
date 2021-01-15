import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/empty_last_added_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastAddedItem extends StatefulWidget {
  final String type; 
  final ListProfileQuery status;

  const LastAddedItem({
    @required this.type,
    @required this.status
  });


  @override
  _LastAddedItemState createState() => _LastAddedItemState();
}

class _LastAddedItemState extends State<LastAddedItem> {

  

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }

  

  @override
  Widget build(BuildContext context) {
   return Container(
     height: MediaQuery.of(context).size.height / 2.6,
     child: BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){

          return LoadingCustomWidget();

        }else if(state is GetListsLoaded){

          if(state.ouevreList.isEmpty){
            return EmptyLastAddedIconWidget(typeOuevre: widget.type,);
          }else{

            return Container(
            child: CarouselSlider.builder(
              enlargeCenterPage: true, 
              height: MediaQuery.of(context).size.height / 2.6,
              autoPlay: false,
              enableInfiniteScroll: state.ouevreList.length > 2,
              viewportFraction: 0.45,
              itemCount: state.ouevreList.length,
              itemBuilder: (context, i) => _itemPoster( state.ouevreList[i]),
            ),
          );

          }

          

        }else if(state is GetlistsError){

          return EmptyLastAddedIconWidget(typeOuevre: widget.type,);

        }

        return EmptyLastAddedIconWidget(typeOuevre: widget.type,);

      },
      )
   );
  }

  _itemPoster(OuevreEntity ouevre) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _itemImage(context, ouevre), flex: 4,),
          _itemTitle(ouevre),
          Expanded(child: _chipStatus(context, ouevre), flex: 1,),
        ],
    );
  }

  Widget _itemImage(BuildContext context, OuevreEntity ouevre) {

    final placeholder = AssetImage('assets/poster_placeholder.png');

    final poster = NetworkImage(ouevre.oeuvrePoster);

    final _poster = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage(
        image: poster,  //? Image Poster Item,
        placeholder: placeholder, //? PlaceHolder Item,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.36,
        height: MediaQuery.of(context).size.height / 2.8,
      ),
    );

    return Container(
      child: GestureDetector(
          onTap: (){
            
            Navigator.pushNamed(
              context, '/AllDetails', 
              arguments: 
              getIdAndType(
                ouevre.oeuvreId, 
                ouevre.oeuvreType,  
                ouevre.oeuvreTitle)
            );
          },
          child: _poster 
      ),
    );
  }

  Widget _itemTitle(OuevreEntity ouevre) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
        ouevre.oeuvreTitle,//? Title of Item
        style: TextStyle(fontSize: 14.0,  fontWeight: FontWeight.w700,),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _chipStatus(BuildContext context, OuevreEntity ouevre) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
      child: ActionChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          onPressed: () => null,
          elevation: 4.0,
          labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
          backgroundColor: _getStatusColor(ouevre),
          label: Text(_getStatusName(context, ouevre),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      );
  }

  String _getStatusName(BuildContext context, OuevreEntity ouevre){
    switch(ouevre.status){
      
      case 1: return AppLocalizations.of(context).translate("status_completed");
      
      case 2: return AppLocalizations.of(context).translate("status_watching");
      
      case 3: return AppLocalizations.of(context).translate("status_pause");
      
      case 4: return AppLocalizations.of(context).translate("status_dropped");
      
      case 5: return AppLocalizations.of(context).translate("status_wishlist");
      
      default: return  'no data';
    }
  }

  Color _getStatusColor( OuevreEntity ouevre){
    switch(ouevre.status){
      
      case 1: return Colors.greenAccent[700];
      
      case 2: return Colors.blueAccent[700];
      
      case 3: return Colors.orangeAccent[700];
      
      case 4: return Colors.redAccent[700];
      
      case 5: return Colors.purpleAccent[700];
      
      default: return  Colors.blueGrey[700];
    }
  }
}