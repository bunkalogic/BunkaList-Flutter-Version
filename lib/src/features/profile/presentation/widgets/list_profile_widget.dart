import 'package:bunkalist/src/features/profile/presentation/widgets/tab_completed_item_widget.dart';
import 'package:flutter/material.dart';

class ListTabProfileWidget extends StatefulWidget {
  ListTabProfileWidget({Key key}) : super(key: key);

  _ListTabProfileWidgetState createState() => _ListTabProfileWidgetState();
}

class _ListTabProfileWidgetState extends State<ListTabProfileWidget> {

  


  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView.builder(
         itemBuilder: (context, i) => TabItemCompletedWidget(),
         itemCount: 12,
         
       ),
    );
  }

  
}