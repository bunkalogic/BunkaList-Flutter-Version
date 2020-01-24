import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_people/bloc.dart';
import 'package:flutter/material.dart';

import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_people_pages/people_cast_tab.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/tab_people_pages/people_info_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';






class AllDetailsTabPersonControllerWidget extends StatefulWidget {


  final Key idStatus;
  final int idCast;

  AllDetailsTabPersonControllerWidget({@required this.idStatus, @required this.idCast});

  

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

      case '[<0>]': {
        return new BlocProvider<PeopleInfoBloc>(
          builder: (_) => serviceLocator<PeopleInfoBloc>(),
          child: PeopleInfoTab(id: widget.idCast,),
        );
      }

      case '[<1>]':  {
        return new BlocProvider<PeopleInfoBloc>(
          builder: (_) => serviceLocator<PeopleInfoBloc>(),
          child: PeopleCastTab(id: widget.idCast,),
        );
      }

      case '[<2>]':  {
        return new BlocProvider<PeopleInfoBloc>(
          builder: (_) => serviceLocator<PeopleInfoBloc>(),
          child: PeopleCrewTab(id: widget.idCast,),
        );
      }

      default: return Center(child: Text('Error tab'),);
    }
  }
  
}