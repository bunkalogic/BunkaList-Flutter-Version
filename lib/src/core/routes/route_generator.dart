import 'package:bunkalist/src/core/routes/route_error.dart';
import 'package:bunkalist/src/features/base/presentation/pages/home_page.dart';
import 'package:bunkalist/src/features/home_tops/presentation/pages/top_list_page.dart';


import 'package:flutter/material.dart';


class RouteGeneretor{
  
  static Route<dynamic> generateRoute(RouteSettings settings){
    
    //?Variables
    final args = settings.arguments;

    switch(settings.name){
      
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      
      case '/TopList':
        if(args is String){
          
          return MaterialPageRoute(builder: (_) => TopsListPage(
            data: args,
          ));
        }
        return routeError();

      
      
      
      
      default: return routeError(); 

        
    }
  }

  

}