import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_completed_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_pause_dropped_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_watching_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_whish_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTabProfileWidget extends StatefulWidget {
  

  final Key idStatus;
  final String type;

  ListTabProfileWidget({@required this.idStatus, @required this.type});

  _ListTabProfileWidgetState createState() => _ListTabProfileWidgetState();
}

class _ListTabProfileWidgetState extends State<ListTabProfileWidget> {


  // final loadingPage = Center(
  //     child: CircularProgressIndicator(),
  //   ) ;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   BlocProvider.of<GetListsBloc>(context)..add(
  //     GetYourLists( type: widget.type, status: getStatusName())
  //   );

  // }  



  @override
  Widget build(BuildContext context) {
    
    return getStatusItemBuilder();

  }

  Widget getStatusItemBuilder(){
    switch(widget.idStatus.toString()){
      case '[<0>]': {

        return new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: TabItemCompletedWidget(type: widget.type, status: getStatusName(),),
          );

      }

      case '[<1>]':{

        return new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: TabItemWatchingWidget(type: widget.type, status: getStatusName(),),
          );

      }

      case '[<2>]':{

        return new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: TabItemPauseAndDroppedWidget(type: widget.type, status: getStatusName(),),
          );

      }
       

      case '[<3>]':{

        return new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: TabItemPauseAndDroppedWidget(type: widget.type, status: getStatusName(),),
          );

      } 

      case '[<4>]':{

        return new BlocProvider<GetListsBloc>(
            builder: (_) => serviceLocator<GetListsBloc>(),
            child: TabItemWhishListWidget(type: widget.type, status: getStatusName(),),
          );

      } 

      default: return Center(child: Text('Error tab'),);
    }
  }

  String getStatusName(){
    switch(widget.idStatus.toString()){
      
      case '[<0>]': return 'Completed';
      
      case '[<1>]': return 'Watching';
      
      case '[<2>]': return 'Pause';
      
      case '[<3>]': return 'Dropped';
      
      case '[<4>]': return 'WishList';

      default: return 'WishList';
    }
  }
  
}