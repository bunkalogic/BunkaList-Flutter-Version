import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class TopsListPage extends StatefulWidget {
  
  
  final String data;


  TopsListPage({
    Key key,
    @required this.data
  }) : super(key: key);

  @override
  _TopsListPageState createState() => _TopsListPageState();
}

class _TopsListPageState extends State<TopsListPage> {
  bool changeDesign = false;

  @override
  Widget build(BuildContext context) {


    return PlatformScaffold(
      appBar:  _createAppBarPlatform(context),
      body: _changedListDesign(),
      
    );
  }

  PlatformAppBar _createAppBarPlatform(BuildContext context) {
    return PlatformAppBar(
      android: (context) => _createAppBarMaterial(context),

    );

  }

  MaterialAppBarData _createAppBarMaterial(BuildContext context) {

    return MaterialAppBarData(
      title: Text(widget.data),
      actions: <Widget>[
        IconButton(
          icon: _changedIcon(),
          onPressed: (){
            if(!changeDesign){
              changeDesign = true;
              setState(() { });
            }else{
              changeDesign = false;
              setState(() { });
            }
          },
          )
      ],
    ); 
  }

  Widget _changedListDesign() {

    final card = new CardViewListWidget();
    final grid = new GridViewListWidget();
     
      if(!changeDesign){
        return grid;
      }else {
        return card;
      }
      
      
  }

  Widget _changedIcon() {
     
      if(!changeDesign){
        return Icon(Icons.art_track, size: 32, );
      }else {
        return Icon(Icons.view_module, size: 32 ,);
      }
      
      
  }
}

