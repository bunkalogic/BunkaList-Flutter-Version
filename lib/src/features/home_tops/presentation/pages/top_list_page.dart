import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class TopsListPage extends StatelessWidget {
  
  
  final String data;

  TopsListPage({
    Key key,
    @required this.data
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return PlatformScaffold(
      appBar:  _createAppBarPlatform(context),
      body: GridViewListWidget(), // TODO: crear el otro diseño 
      
    );
  }

  


  //!  Common Components (Android & iOS)

  PlatformAppBar _createAppBarPlatform(BuildContext context) {
    return PlatformAppBar(
      android: (context) => _createAppBarMaterial(context),

    );

  }

  //! Material Components (Android)

  MaterialAppBarData _createAppBarMaterial(BuildContext context) {

    

    return MaterialAppBarData(
      title: Text(data),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.view_compact, size: 22 ,),
          onPressed: (){},
          )
      ],
    ); 
  }

  //! Cupertino Components (iOS)

}

