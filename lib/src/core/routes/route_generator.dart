import 'package:bunkalist/src/features/login/presentation/pages/base_login_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_people_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_season_page.dart';
import 'package:flutter/material.dart';

import 'package:bunkalist/src/core/routes/route_error.dart';
import 'package:bunkalist/src/core/routes/slide_route.dart';

import 'package:bunkalist/src/features/base/presentation/pages/home_page.dart';
import 'package:bunkalist/src/features/home_tops/presentation/pages/top_list_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_ouevre_page.dart';
import 'package:bunkalist/src/features/profile/presentation/pages/list_profile_page.dart';





class RouteGeneretor{
  
  static Route<dynamic> generateRoute(RouteSettings settings){
    
    //?Variables
    final args = settings.arguments;

    switch(settings.name){
      
      case '/':
        //return MaterialPageRoute(builder: (_) => HomePage());
        return MaterialPageRoute(builder: (_) => LoginHomePage());
      
      case '/TopList':
        if(args is String){
          
          return SlideRightRoute(page: TopsListPage(data: args,));
        }
        return routeError();

      case '/ListProfile':
        if(args is int){
          
          return SlideRightRoute(page: ListProfilePage(data: args,));
        }
        return routeError();  

      case '/AllDetails':
        if(args is int){
          
          return SlideRightRoute(page: AllDetailsOuevrePage(data: args,));
        }
        return routeError();

      case '/AllDetailsSeason':
        if(args is int){
          
          return SlideRightRoute(page: AllDetailsSeasonPage(data: args,));
        }
        return routeError();

      case '/AllDetailsPeople':
        if(args is int){
          
          return SlideRightRoute(page: AllDetailsPeoplePage(data: args,));
        }
        return routeError();      

      
      
      
      
      default: return routeError(); 

        
    }
  }

  

}