import 'package:flutter/material.dart';

import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_people_pages/people_cast_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_people_pages/people_info_tab.dart';






class AllDetailsTabPersonControllerWidget extends StatefulWidget {
  AllDetailsTabPersonControllerWidget({@required this.idStatus});

  final Key idStatus;

  _AllDetailsTabPersonControllerWidgetState createState() => _AllDetailsTabPersonControllerWidgetState();
}

class _AllDetailsTabPersonControllerWidgetState extends State<AllDetailsTabPersonControllerWidget> {

  


  @override
  Widget build(BuildContext context) {
    return _getPersonTabView(widget.idStatus);
  }

  Widget _getPersonTabView(Key idStatus){

    /**
     * TODO: refactorizar y implementar la comprobacion de que tipo
     *  es devoler las tabs que sean necesarias
     */


    switch(idStatus.toString()){

      case '[<0>]': return PeopleInfoTab();

      case '[<1>]': return PeopleCastTab();

      case '[<2>]': return PeopleCastTab();

      case '[<3>]': return PeopleCastTab();
 

      default: return Center(child: Text('Error tab'),);
    }
  }
  
}