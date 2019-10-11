import 'package:flutter/material.dart';



class AllDetailsTabViewControllerWidget extends StatefulWidget {
  AllDetailsTabViewControllerWidget({@required this.idStatus});

  final Key idStatus;

  _AllDetailsTabViewControllerWidgetState createState() => _AllDetailsTabViewControllerWidgetState();
}

class _AllDetailsTabViewControllerWidgetState extends State<AllDetailsTabViewControllerWidget> {

  


  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text('All details'),//! Implementar BLOC para manejar pages de los details
       )
    );
  }

  // Widget _getDetailsTabView(Key idStatus){
  //   switch(idStatus.toString()){
  //     // case '[<0>]': return

  //     // case '[<1>]': return 

  //     // case '[<2>]': return 

  //     // case '[<3>]': return 

  //     // case '[<4>]': return

  //     default: return Center(child: Text('Error tab'),);
  //   }
  // }
  
}