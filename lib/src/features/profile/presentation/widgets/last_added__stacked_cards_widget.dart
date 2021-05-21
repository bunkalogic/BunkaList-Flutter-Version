import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_id_and_type.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/empty_last_added_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/emptys_list_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stack_card/flutter_stack_card.dart';


class LastAddedItemStackedCardsWidget extends StatefulWidget {
  
  final String type; 
  final ListProfileQuery status;

  LastAddedItemStackedCardsWidget({
    @required this.type,
    @required this.status
  });

  @override
  _LastAddedItemStackedCardsWidgetState createState() => _LastAddedItemStackedCardsWidgetState();
}

class _LastAddedItemStackedCardsWidgetState extends State<LastAddedItemStackedCardsWidget> {
  

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetListsBloc>(context)..add(
      GetYourLists( type: widget.type, status: widget.status)
    );
  }

  
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListsBloc, GetListsState>(
    builder: (context, state) {
      if(state is GetListsLoading){

        return Container(
          height: MediaQuery.of(context).size.height * 0.33,
          width: MediaQuery.of(context).size.width / 0.80,
          child: LoadingCustomWidget()
        );


      }else if(state is GetListsLoaded){

        if(state.ouevreList.isEmpty){
          return ListProfileEmptyIconWidget(
              title: AppLocalizations.of(context).translate("wishlist_empty_label"),
              color: Colors.purpleAccent[400],
              icon: Icons.add_circle_outline,
            );
        }else{

          return StackedCardsBuilder(ouevreList: state.ouevreList);

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
    );
  }
}


class StackedCardsBuilder extends StatefulWidget {

  final List<OuevreEntity> ouevreList;

  StackedCardsBuilder({@required this.ouevreList});

  @override
  _StackedCardsBuilderState createState() => _StackedCardsBuilderState();
}

class _StackedCardsBuilderState extends State<StackedCardsBuilder> {
  
  int position = 0;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         Navigator.pushNamed(
      context, '/AllDetails', 
      arguments: 
        getIdAndType(
        widget.ouevreList[position].oeuvreId, 
        widget.ouevreList[position].oeuvreType,  
        widget.ouevreList[position].oeuvreTitle)
      );
      },
      child: Container(
        height: 300,
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
              child: ItemStackCards(ouevreEntity: widget.ouevreList[index],),
            );
          },
          onSwap: (value) {
            setState(() {
              position = value;
            });
          },
          stackType: StackType.middle,
          stackOffset: const Offset(25.0, -10.0),
          dimension: StackDimension(
            height: 300, // MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width / 0.85,
          ), 
          itemCount: widget.ouevreList.length
        ),
      ),
    );
   
  }


  
}

class ItemStackCards extends StatefulWidget {
  
  final OuevreEntity ouevreEntity;

  ItemStackCards({
    @required this.ouevreEntity,
  });

  @override
  _ItemStackCardsState createState() => _ItemStackCardsState();
}

class _ItemStackCardsState extends State<ItemStackCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          clipBehavior: Clip.antiAlias,
          children: [
            _cardItem(widget.ouevreEntity),
            _titleOfItem(widget.ouevreEntity),
            _chipStatus(widget.ouevreEntity)
          ],
        ),
      ),
    );
  }

  

  Widget _titleOfItem(OuevreEntity item) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          left: 15.0,
          right: 15.0
        ),
        child: Text(
          item.oeuvreTitle,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 24.0,
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
      )
    );
  }

  Widget _chipStatus(OuevreEntity item){
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          right: 15.0,
        ),
        child: ActionChip(
          label: Text(_getStatusName(context, item),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                fontStyle: FontStyle.italic
              ),
            ), 
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            onPressed: () => null,
            elevation: 6.0,
            labelPadding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 2.0),
            backgroundColor: _getStatusColor(item),
        ),
      ),
    );
  }

  Widget _cardItem(OuevreEntity item) {

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage(item.oeuvrePoster);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
          placeholder: placeholder, 
          image: poster,
          fit: BoxFit.fill,
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