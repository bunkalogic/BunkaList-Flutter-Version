import 'package:bunkalist/src/core/constans/object_type_code.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/add_ouevre_in_list/presentation/widgets/added_or_update_controller_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/empty_last_added_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          Expanded(child: _itemImage(context, ouevre), flex: 5,),
          _itemTitle(ouevre),
          Expanded(child: _chipStatus(context, ouevre), flex: 1,),
          Expanded(child: ButtonAddedArrowDown(ouevre: ouevre, type: ouevre.oeuvreType, isUpdated: false, objectType: ConstantsTypeObject.ouevreEntity,), flex: 1,)
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
            //! PushNamed Al ItemAllDetail
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
        style: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.w700,),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _chipStatus(BuildContext context, OuevreEntity ouevre) {

    final DateTime datetime = ouevre.addDate;

    final formatter = DateFormat('dd-MM-yy');

    final date = formatter.format(datetime);

    final Widget labelActionChip = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.today, color: Colors.pinkAccent[400], size: 25.0,),
        Text( date,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              fontStyle: FontStyle.italic
            ),
        ),    
      ],
    );


    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5, horizontal: 4.0),
      child: ActionChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          onPressed: () => null,
          elevation: 5.0,
          labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
          backgroundColor: Colors.grey.withOpacity(0.4),
          label: labelActionChip,
        ),
      );
  }

 
}