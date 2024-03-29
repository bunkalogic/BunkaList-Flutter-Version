import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:bunkalist/src/features/base/presentation/bloc/bloc/userdata_bloc.dart';
import 'package:bunkalist/src/features/base/presentation/pages/home_new_user_page.dart';
import 'package:bunkalist/src/features/base/presentation/pages/initial_controller_page.dart';
import 'package:bunkalist/src/features/base/presentation/pages/intro_slider_page.dart';
import 'package:bunkalist/src/features/base/presentation/pages/loading_page.dart';
import 'package:bunkalist/src/features/base/presentation/pages/splash_page.dart';
import 'package:bunkalist/src/features/explorer/presentation/pages/explorer_company_list_page.dart';
import 'package:bunkalist/src/features/explorer/presentation/pages/explorer_filter_list_page.dart';
import 'package:bunkalist/src/features/explorer/presentation/pages/explorer_genre_list_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/about_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/change_language_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/edit_preferences_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/edit_profile_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/no_ads_page.dart';
import 'package:bunkalist/src/features/options/presentation/pages/policy_page.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/episode_season_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_episode_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_images_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/widgets/video_player_widget.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/presentation/pages/list_fav_profile_page.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/pages/top_detail_page.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/create_top_favorites_widget.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/reorder_top_widget.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/pages/get_premium_page.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/pages/personal_home_tops_details_page.dart';
import 'package:flutter/material.dart';

import 'package:bunkalist/src/core/routes/route_error.dart';
import 'package:bunkalist/src/core/routes/slide_route.dart';

import 'package:bunkalist/src/features/base/presentation/pages/home_page.dart';
import 'package:bunkalist/src/features/home_tops/presentation/pages/top_list_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_ouevre_page.dart';
import 'package:bunkalist/src/features/profile/presentation/pages/list_profile_page.dart';
import 'package:bunkalist/src/features/login/presentation/pages/base_login_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_people_page.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/pages/all_details_season_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class RouteGeneretor{
  
  static Route<dynamic> generateRoute(RouteSettings settings){
    
    //?Variables
    final args = settings.arguments;

    switch(settings.name){
      
      case '/Intro':
        return MaterialPageRoute(builder: (_) => IntroSliderPage());

      case '/':
        return MaterialPageRoute(builder: (_) => InitialController());

      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());

      case '/Loading':
        return MaterialPageRoute(builder: (_) => LoadingPage());  

      case '/Home':
        
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/NewUserHome':
        
        return MaterialPageRoute(builder: (_) => HomeNewUserPage());  
  
      
      case '/TopList':
        if(args is String){
          
          return SlideRightRoute(page: TopsListPage(data: args,));
        }
        return routeError();

      case '/ExplorerGenre':
        if(args is Genres){
          
          return SlideRightRoute(page: ExplorerGenreListPage(data: args,));
        }
        return routeError();

      case '/ExplorerCompany':
        if(args is Company){
          
          return SlideRightRoute(page: ExplorerCompanyListPage(data: args,));
        }
        return routeError();    

      case '/ListProfile':
        if(args is int){
          
          return SlideRightRoute(page: ListProfilePage(data: args,));
        }
        return routeError();  

      case '/AllDetails':
        if(args is Map){
          
          return SlideRightRoute(page: AllDetailsOuevrePage(data: args));
        }
        return routeError();

      case '/AllDetailsSeason':
        if(args is Map){
          
          return SlideRightRoute(page: AllDetailsSeasonPage(data: args,));
        }
        return routeError();

      case '/AllDetailsEpisode':
        if(args is Episode){
          
          return SlideRightRoute(page: AllDetailsEpisodePage(episode: args,));
        }
        return routeError();


      case '/AllDetailsPeople':
        if(args is Map){
          
          return SlideRightRoute(page: AllDetailsPeoplePage(data: args,));
        }
        return routeError();

      case '/AllDetailsImages':
        if(args is List<Backdrop>){
          
          return SlideRightRoute(page: AllDetailsImagesPage(images: args));
        }
        return routeError();

      case '/VideoPlayer':
        if(args is String){
          
          return SlideRightRoute(page: VideoPlayerWidget(id: args,));
        }
        return routeError();

      case '/TopFavDetails':
        if(args is List<OuevreEntity>){
          return SlideRightRoute(page: TopDetailPage(ouevreList: args ,));
        }
        return routeError();
        

      case '/TopFavEdit':
      if(args is List<OuevreEntity>){
          return SlideRightRoute(page: ReorderTopWidget(ouevreList: args,));
        }
        return routeError();
        

      case '/TopFavCreate':
        if(args is Map){
          return SlideRightRoute(page: CreateTopFaviritesWidget(data: args,));   
        }
       return routeError(); 

      case '/ExplorerFilter':
        if(args is FilterParams){
          return SlideRightRoute(page: ExplorerFilterPage(data: args,));   
        }
       return routeError();

      case '/HomeTopsPersonalDetails':
        if(args is FilterParams){
          return SlideRightRoute(page: PersonalHomeTopsDetailsPage(data: args,));   
        }
       return routeError();  



      case '/ListFavProfile':
        return SlideRightRoute(page: ListFavoriteProfilePage());

      case '/Login':
        return SlideRightRoute(page: LoginHomePage());

      case '/Licenses':
        return SlideRightRoute(page: LicensePage());

      case '/EditProfile':
        return SlideRightRoute(page: EditProfilePage());

      case '/About':
        return SlideRightRoute(page: AboutPage());

      case '/Policy':
        return SlideRightRoute(page: PolicyPage());  

      case '/Premium':
        return SlideRightRoute(page: BlocProvider<UserdataBloc>(
            create:(BuildContext context) => serviceLocator<UserdataBloc>(),
            child: GetPremiumPage(),
          )
        );

      case '/Language':
        return SlideRightRoute(page: ChangeLanguagePage());


       case '/EditPreferences':
        return SlideRightRoute(page: EditPreferencesPage());


      case '/NoAds':
        return SlideRightRoute(
          page: BlocProvider<UserdataBloc>(
            create:(BuildContext context) => serviceLocator<UserdataBloc>(),
            child: NoAdsPage(),
          )
        );
      
      
      
      default: return routeError(); 

        
    }
  }

  

}