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
          icon: Icon(Icons.view_compact, size: 22 ,),
          onPressed: (){
            if(!changeDesign){
              changeDesign = true;
              print(changeDesign);
              setState(() { });
            }else{
              changeDesign = false;
              print(changeDesign);
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
}

