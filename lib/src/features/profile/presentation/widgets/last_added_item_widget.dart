import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/empty_last_added_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/emptys_list_profile_widget.dart';
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
     padding: const EdgeInsets.only(top: 10.0),
     height: 200,
     child: BlocBuilder<GetListsBloc, GetListsState>(
      builder: (context, state) {
        if(state is GetListsLoading){

          return LoadingCustomWidget();

        }else if(state is GetListsLoaded){

          if(state.ouevreList.isEmpty){
            return ListProfileEmptyIconWidget(
              title: AppLocalizations.of(context).translate("wishlist_empty_label"),
              color: Colors.purpleAccent[400],
              icon: Icons.add_circle_outline,
            );
          }else{

            return Container(
            child: CarouselSlider.builder(
              options: CarouselOptions( 
                enlargeCenterPage: false, 
                aspectRatio: 16 / 9,
                autoPlay: false,
                viewportFraction: 0.33,
                height: 200,
                enableInfiniteScroll: state.ouevreList.length > 2,
              ),
              itemCount: state.ouevreList.length,
              itemBuilder: (context, i, h) => ItemPosterHHistoryWidget(ouevre: state.ouevreList[i],) //_itemPoster( state.ouevreList[i]),
            ),
          );

          }

          

        }else if(state is GetlistsError){

         return ListProfileEmptyIconWidget(
              title: AppLocalizations.of(context).translate("wishlist_empty_label"),
              color: Colors.purpleAccent[400],
              icon: Icons.add_circle_outline,
            );

        }

        return ListProfileEmptyIconWidget(
              title: AppLocalizations.of(context).translate("wishlist_empty_label"),
              color: Colors.purpleAccent[400],
              icon: Icons.add_circle_outline,
            );

      },
      )
   );
  }

  // _itemPoster(OuevreEntity ouevre) {
  //   return Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Expanded(child: _itemImage(context, ouevre), flex: 4,),
  //         _itemTitle(ouevre),
  //         Expanded(child: _chipStatus(context, ouevre), flex: 1,),
  //       ],
  //   );
  // }

  // Widget _itemImage(BuildContext context, OuevreEntity ouevre) {

  //   final placeholder = AssetImage('assets/poster_placeholder.png');

  //   final poster = NetworkImage(ouevre.oeuvrePoster);

  //   final _poster = ClipRRect(
  //     borderRadius: BorderRadius.circular(10.0),
  //     child: FadeInImage(
  //       image: poster,  //? Image Poster Item,
  //       placeholder: placeholder, //? PlaceHolder Item,
  //       fit: BoxFit.cover,
  //       width: MediaQuery.of(context).size.width * 0.36,
  //       height: MediaQuery.of(context).size.height / 2.8,
  //     ),
  //   );

  //   return Container(
  //     child: GestureDetector(
  //         onTap: (){
            
  //           Navigator.pushNamed(
  //             context, '/AllDetails', 
  //             arguments: 
  //             getIdAndType(
  //               ouevre.oeuvreId, 
  //               ouevre.oeuvreType,  
  //               ouevre.oeuvreTitle)
  //           );
  //         },
  //         child: _poster 
  //     ),
  //   );
  // }

  // Widget _itemTitle(OuevreEntity ouevre) {
  //   return Padding(
  //     padding: const EdgeInsets.all(1.0),
  //     child: Text(
  //       ouevre.oeuvreTitle,//? Title of Item
  //       style: TextStyle(
  //         fontSize: 14.0,  
  //         fontWeight: FontWeight.w700,
  //         color: Colors.white,
  //         shadows: [
  //           Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
  //         ]
  //       ),
  //       textAlign: TextAlign.center,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //   );
  // }

  // Widget _chipStatus(BuildContext context, OuevreEntity ouevre) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
  //     child: ActionChip(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.0)
  //         ),
  //         onPressed: () => null,
  //         elevation: 4.0,
  //         labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
  //         backgroundColor: _getStatusColor(ouevre),
  //         label: Text(_getStatusName(context, ouevre),
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: 14.0,
  //             fontStyle: FontStyle.italic
  //           ),
  //         ),
  //       ),
  //     );
  // }

  // String _getStatusName(BuildContext context, OuevreEntity ouevre){
  //   switch(ouevre.status){
      
  //     case 1: return AppLocalizations.of(context).translate("status_completed");
      
  //     case 2: return AppLocalizations.of(context).translate("status_watching");
      
  //     case 3: return AppLocalizations.of(context).translate("status_pause");
      
  //     case 4: return AppLocalizations.of(context).translate("status_dropped");
      
  //     case 5: return AppLocalizations.of(context).translate("status_wishlist");
      
  //     default: return  'no data';
  //   }
  // }

  // Color _getStatusColor( OuevreEntity ouevre){
  //   switch(ouevre.status){
      
  //     case 1: return Colors.greenAccent[400];
      
  //     case 2: return Colors.blueAccent[400];
      
  //     case 3: return Colors.orangeAccent[400];
      
  //     case 4: return Colors.redAccent[400];
      
  //     case 5: return Colors.purpleAccent[400];
      
  //     default: return  Colors.blueGrey[400];
  //   }
  // }
}



class ItemPosterHistoryWidget extends StatefulWidget {

  final OuevreEntity ouevre;

  ItemPosterHistoryWidget({@required this.ouevre});

  @override
  _ItemPosterHistoryWidgetState createState() => _ItemPosterHistoryWidgetState();
}

class _ItemPosterHistoryWidgetState extends State<ItemPosterHistoryWidget> {
  
  final Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
            
            Navigator.pushNamed(
              context, '/AllDetails', 
              arguments: 
              getIdAndType(
                widget.ouevre.oeuvreId, 
                widget.ouevre.oeuvreType,  
                widget.ouevre.oeuvreTitle
              )
            );
          },
        child: Card(  
        elevation: 15.0,
        margin: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 20.0
        ),
        color: Colors.transparent,
        child: Container(
          child: _stackTextAndIcon(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ) 
        ),

      ),
    );
  }

  Widget _stackTextAndIcon() {

    return Stack(
      children: <Widget>[
        _imageBackground(context, widget.ouevre),
        _itemTitle(widget.ouevre),
        _chipStatus(widget.ouevre),
        _buttonItem()
        
        
      ],
    );

  }

   Widget _imageBackground(BuildContext context, OuevreEntity ouevre) {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w780${ ouevre.oeuvrePoster }');
    
    //! Agregar el Hero
    
    return Container(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          image: (ouevre.oeuvrePoster == null) ? placeholder : poster,  //? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
      ),
    );



  }

  Widget _itemTitle(OuevreEntity ouevre) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          ouevre.oeuvreTitle,//? Title of Item
          style: TextStyle(
            fontSize: 18.0,  
            fontWeight: FontWeight.w600,
            color: Colors.white,
          shadows: [
            Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _chipStatus(OuevreEntity ouevre) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
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
        ),
    );
  }


  Widget _buttonItem(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: (){
            return ButtonClikedAdded(
                context: context,
                isUpdated: true,
                ouevre: widget.ouevre,
                type: widget.ouevre.oeuvreType,
                objectType: ConstantsTypeObject.ouevreEntity
              ).showBottomModal();
          },
          heroTag: null,
          elevation: 10.0,
          mini: true,
          child: Icon(Icons.playlist_add_check_rounded, color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], size: 20.0,),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
              width: 2.5
            ),
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
      
      case 1: return Colors.greenAccent[400];
      
      case 2: return Colors.blueAccent[400];
      
      case 3: return Colors.orangeAccent[400];
      
      case 4: return Colors.redAccent[400];
      
      case 5: return Colors.purpleAccent[400];
      
      default: return  Colors.blueGrey[400];
    }
  }
}








class ItemPosterHHistoryWidget extends StatefulWidget {

  final OuevreEntity ouevre;

  ItemPosterHHistoryWidget({@required this.ouevre});

  @override
  _ItemPosterHHistoryWidgetState createState() => _ItemPosterHHistoryWidgetState();
}

class _ItemPosterHHistoryWidgetState extends State<ItemPosterHHistoryWidget> {
  
  final Preferences prefs = Preferences();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
            
            Navigator.pushNamed(
              context, '/AllDetails', 
              arguments: 
              getIdAndType(
                widget.ouevre.oeuvreId, 
                widget.ouevre.oeuvreType,  
                widget.ouevre.oeuvreTitle
              )
            );
          },
        child: Container(
          height: 180,
          padding: const EdgeInsets.only(right: 10.0,),
          child: Card(
            elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
            child: Container(
              height: 150,
      
      child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: _stackTextAndIcon(), flex: 6,),
              SizedBox(height: 5.0,),
              Expanded(
                flex: 1,
                child: Text(_getStatusName(context, widget.ouevre),
                style: TextStyle(
                  color: _getStatusColor(widget.ouevre),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic
                ),
            ),
              ),
              
            ],
      ),
      ) ,
          ),
        ),
    );
  }

  Widget _stackTextAndIcon() {

    return Container(
      height: 150,
      child: Stack(
        children: <Widget>[
          _imageBackground(context, widget.ouevre),
          _itemTitle(widget.ouevre),
          
          
          
        ],
      ),
    );

  }

   Widget _imageBackground(BuildContext context, OuevreEntity ouevre) {
    final placeholder = AssetImage('assets/poster_placeholder.png');
    final poster = NetworkImage('https://image.tmdb.org/t/p/w780${ ouevre.oeuvrePoster }');
    
    //! Agregar el Hero
    
    return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              image: (ouevre.oeuvrePoster == null) ? placeholder : poster,  //? Image Poster Item,
              placeholder: placeholder, //? PlaceHolder Item,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 170,
            ),
          );



  }

  Widget _itemTitle(OuevreEntity ouevre) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          ouevre.oeuvreTitle,//? Title of Item
          style: TextStyle(
            fontSize: 14.0,  
            fontWeight: FontWeight.w600,
            color: Colors.white,
          shadows: [
            Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
          ]
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _chipStatus(OuevreEntity ouevre) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
        ),
    );
  }


  Widget _buttonItem(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: (){
            return ButtonClikedAdded(
                context: context,
                isUpdated: true,
                ouevre: widget.ouevre,
                type: widget.ouevre.oeuvreType,
                objectType: ConstantsTypeObject.ouevreEntity
              ).showBottomModal();
          },
          heroTag: null,
          elevation: 10.0,
          mini: true,
          child: Icon(Icons.playlist_add_check_rounded, color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], size: 20.0,),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
              width: 2.5
            ),
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
      
      case 1: return Colors.greenAccent[400];
      
      case 2: return Colors.blueAccent[400];
      
      case 3: return Colors.orangeAccent[400];
      
      case 4: return Colors.redAccent[400];
      
      case 5: return Colors.purpleAccent[400];
      
      default: return  Colors.blueGrey[400];
    }
  }
}