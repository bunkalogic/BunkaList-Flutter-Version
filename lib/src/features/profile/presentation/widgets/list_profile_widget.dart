import 'package:bunkalist/src/features/profile/presentation/widgets/tab_completed_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_pause_dropped_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_watching_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_whish_list_item_widget.dart';
import 'package:flutter/material.dart';

class ListTabProfileWidget extends StatefulWidget {
  ListTabProfileWidget({@required this.idStatus});

  final Key idStatus;

  _ListTabProfileWidgetState createState() => _ListTabProfileWidgetState();
}

class _ListTabProfileWidgetState extends State<ListTabProfileWidget> {

  


  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView.builder(
         itemBuilder: (context, i) => getStatusItemBuilder(widget.idStatus),
         itemCount: 12,
         
       ),
    );
  }

  Widget getStatusItemBuilder(Key idStatus){
    switch(idStatus.toString()){
      case '[<0>]': return TabItemCompletedWidget();

      case '[<1>]': return TabItemWatchingWidget();

      case '[<2>]': return TabItemPauseAndDroppedWidget();

      case '[<3>]': return TabItemPauseAndDroppedWidget();

      case '[<4>]': return TabItemWhishListWidget();

      default: return Center(child: Text('Error tab'),);
    }
  }
  
}