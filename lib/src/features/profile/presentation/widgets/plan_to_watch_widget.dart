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
import 'package:flutter_stack_card/flutter_stack_card.dart';
import 'package:intl/intl.dart';

class PlanToWatchItem extends StatefulWidget {
  
  final String type; 
  final ListProfileQuery status;

  const PlanToWatchItem({
    @required this.type,
    @required this.status
  });


  @override
  _PlanToWatchItemState createState() => _PlanToWatchItemState();
}

class _PlanToWatchItemState extends State<PlanToWatchItem> {

  Preferences prefs = Preferences();

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
     height: 350,
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

            return prefs.currentDesignWishlist ? CardStackPlanToWatch(ouevreList: state.ouevreList,) : CarouselPlanToWatch(ouevreList: state.ouevreList);

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

  

 
}



class CarouselPlanToWatch extends StatefulWidget {

  final List<OuevreEntity> ouevreList;
  
  CarouselPlanToWatch({this.ouevreList});

  @override
  _CarouselPlanToWatchState createState() => _CarouselPlanToWatchState();
}

class _CarouselPlanToWatchState extends State<CarouselPlanToWatch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          height: 200,
          enableInfiniteScroll: widget.ouevreList.length > 2,
        ),
        itemCount: widget.ouevreList.length,
        itemBuilder: (context, i, h) =>  ItemPosterWishlistWidget(ouevre: widget.ouevreList[i],) //_itemPoster( widget.ouevreList[i]),
      ),
    );
  }

  // _itemPoster(OuevreEntity ouevre) {
  //   return Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Expanded(child: _itemImageAndRating(ouevre), flex: 5,),
  //         _itemTitle(ouevre),
  //         Expanded(child: _chipStatus(context, ouevre), flex: 1,),
  //         Expanded(child: ButtonAddedArrowDown(ouevre: ouevre, type: ouevre.oeuvreType, isUpdated: false, objectType: ConstantsTypeObject.ouevreEntity,), flex: 1,)
  //       ],
  //   );
  // }


  // Widget _itemImageAndRating(OuevreEntity ouevre){
  //   return Container(
  //     child: Stack(
  //       children: <Widget>[
  //         _itemImage(context, ouevre),
  //         _itemRating(ouevre)
  //       ],
  //     ),
  //   );
  // }

  // Widget _itemRating(OuevreEntity ouevre){
  //   return Container(
  //     margin: EdgeInsets.all(5.0),
  //     padding: EdgeInsets.all(3.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5.0),
  //       color: Colors.grey[400].withOpacity(0.4)
  //     ),
  //     child: Text(
  //       ouevre.oeuvreRating.toString(),
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.w800,
  //         shadows: [
  //          Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
  //         ]
  //         ),
  //     ),
  //   );
  // }

  // Widget _itemImage(BuildContext context, OuevreEntity ouevre) {

  //   final placeholder = AssetImage('assets/poster_placeholder.png');

  //   final poster = NetworkImage(ouevre.oeuvrePoster);

  //   final _poster = ClipRRect(
  //     borderRadius: BorderRadius.circular(8.0),
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
  //           //! PushNamed Al ItemAllDetail
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
  //     padding: const EdgeInsets.all(2.0),
  //     child: Text(
  //       ouevre.oeuvreTitle,//? Title of Item
  //       style: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.w700,),
  //       textAlign: TextAlign.center,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //   );
  // }

  // Widget _chipStatus(BuildContext context, OuevreEntity ouevre) {

  //   final DateTime datetime = ouevre.addDate;

  //   final formatter = DateFormat('dd-MM-yy');

  //   final date = formatter.format(datetime);

  //   final Widget labelActionChip = Row(
  //     mainAxisSize: MainAxisSize.min,
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       Icon(Icons.today, color: Colors.pinkAccent[400], size: 25.0,),
  //       Text( date,
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: 14.0,
  //             fontStyle: FontStyle.italic
  //           ),
  //       ),    
  //     ],
  //   );


  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
  //     child: ActionChip(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.0)
  //         ),
  //         onPressed: () => null,
  //         elevation: 5.0,
  //         labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
  //         backgroundColor: Colors.grey.withOpacity(0.4),
  //         label: labelActionChip,
  //       ),
  //     );
  // }
}



class ItemPosterWishlistWidget extends StatefulWidget {

  final OuevreEntity ouevre;

  ItemPosterWishlistWidget({@required this.ouevre});

  @override
  _ItemPosterWishlistWidgetState createState() => _ItemPosterWishlistWidgetState();
}

class _ItemPosterWishlistWidgetState extends State<ItemPosterWishlistWidget> {
  
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

    final DateTime datetime = ouevre.addDate;

    final formatter = DateFormat('dd-MM-yy');

    final date = formatter.format(datetime);

    final Widget labelActionChip = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.event_available_rounded, color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400], size: 25.0,),
        Text( date,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
        ),    
      ],
    );


    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
        child: ActionChip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            onPressed: () => null,
            elevation: 5.0,
            labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
            backgroundColor: Colors.grey.withOpacity(0.1),
            label: labelActionChip,
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
  
}






class CardStackPlanToWatch extends StatefulWidget {


  final List<OuevreEntity> ouevreList;

  CardStackPlanToWatch({this.ouevreList});

  @override
  _CardStackPlanToWatchState createState() => _CardStackPlanToWatchState();
}

class _CardStackPlanToWatchState extends State<CardStackPlanToWatch> {
  
  int position = 0;
  
  @override
  Widget build(BuildContext context) {

    List<OuevreEntity> ouevreList = widget.ouevreList.length > 14 ? getFirstItems() : widget.ouevreList;

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(
          context, '/AllDetails', 
          arguments: 
            getIdAndType(
            ouevreList[position].oeuvreId, 
            ouevreList[position].oeuvreType,  
            ouevreList[position].oeuvreTitle)
        );
      },
      child:Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 0.80,
        padding: const EdgeInsets.only(
            top: 25.0,  
          ),
        child: StackCard.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 5.0,  
              ),
              child: BuildItemStack(ouevre: ouevreList[index],),
            );
          },
          onSwap: (value) {
            setState(() {
              position = value;
            });
          },
          stackType: StackType.middle,
          stackOffset: const Offset(25.0, -12.5),
          dimension: StackDimension(
            height: 280, // MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width / 0.85,
            
          ), 
          itemCount: ouevreList.length
        ),
      ),
    );
   
  }

  List<OuevreEntity> getFirstItems(){
    
    List<OuevreEntity> ouevreList = [];
    
    for (var i = 0; i < 14; i++) {
      
      ouevreList.add(widget.ouevreList[i]);
    }

    return ouevreList;
  }

  
}



class BuildItemStack extends StatefulWidget {

  final OuevreEntity ouevre;

  BuildItemStack({this.ouevre});

  @override
  _BuildItemStackState createState() => _BuildItemStackState();
}

class _BuildItemStackState extends State<BuildItemStack> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
        margin: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 20.0
        ),
        color: Colors.transparent,
        child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400].withOpacity(0.4),
                blurRadius: 0.5,
                spreadRadius: 0.5
              ),
            ]
          ), 
        child: Stack(
          // clipBehavior: Clip.none, 
          // fit: StackFit.expand,
          children: [
            _cardItem(),
            _titleOfItem(),
            _itemRating(),
            // _buttonItem()
          ],
        ),
      ),
    );
  }

 


  
  Widget _titleOfItem() {

    final DateTime datetime = widget.ouevre.addDate;

    final formatter = DateFormat('dd-MM-yy');

    final date = formatter.format(datetime);

    return Align(
      alignment: Alignment.bottomCenter,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.ouevre.oeuvreTitle,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2.5,
                  )
                ]
              ),
            ),
            Text( date,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 4.5,
                  )
                ]
            ),
        ),    
          ],
        ),
      ),
    );
  }

 

  Widget _cardItem() {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage(widget.ouevre.oeuvrePoster);

   return Container(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          image: (widget.ouevre.oeuvrePoster == null) ? placeholder : poster,  //? Image Poster Item,
          placeholder: placeholder, //? PlaceHolder Item,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _itemRating(){
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[400].withOpacity(0.3)
        ),
        child: Text(
          widget.ouevre.oeuvreRating.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            shadows: [
             Shadow(blurRadius: 1.0, color: Colors.black, offset: Offset(1.0, 1.0))
            ]
            ),
        ),
      ),
    );
  }


  Widget _buttonItem(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
          child: Icon(Icons.add, color: Colors.pinkAccent[400], size: 22.0,),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: Colors.pinkAccent[400],
              width: 2.5
            ),
          ),
        ),
      ),
    );
  }
}