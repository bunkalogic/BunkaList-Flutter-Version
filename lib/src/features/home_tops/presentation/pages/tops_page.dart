import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_anime_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_series_widget.dart';

import 'package:flutter/widgets.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/banner_premium_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';





class TopsPage extends StatefulWidget {
  TopsPage({Key key}) : super(key: key);

  _TopsPageState createState() => _TopsPageState();
}

class _TopsPageState extends State<TopsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createScrollPagePlatform(context),
    );
  }

  Widget _createScrollPagePlatform(BuildContext context) {
    return Container(
      child:_listTops(context),
    );
  }

  Widget _listTops(BuildContext context) {

    // final BlocProvider<TopsMoviesBloc> bloc = new BlocProvider<TopsMoviesBloc>(
    //                 builder: (_) => serviceLocator<TopsMoviesBloc>(),);

    return ListView(
      children: <Widget>[
        //* Add Ads banner
        new BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate('movies_popular'), typeId: Constants.topsMoviesPopularId,),
        ),
        new BlocProvider<TopsSeriesBloc>(
          builder: (_) => serviceLocator<TopsSeriesBloc>(),
          child: ContainerListSeriesWidget(title: AppLocalizations.of(context).translate('series_popular'), typeId: Constants.topsSeriesPopularId,),
        ),
        new BlocProvider<TopsAnimesBloc>(
          builder: (_) => serviceLocator<TopsAnimesBloc>(),
          child:ContainerListAnimeWidget(title: AppLocalizations.of(context).translate('anime_popular'), typeId: Constants.topsAnimePopularId,),
        ),
        new BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate('movies_rated'), typeId: Constants.topsMoviesRatedId,),
        ),
        BannerPremiumWidget()
      ],
    );

    

  }

//  Widget _containerListMovies(BuildContext context, String title, int topId){
    
//     final loadingPage = Center(
//       child: CircularProgressIndicator(),
//     ) ;
    
    
//     return new BlocProvider<TopsMoviesBloc>(
//                 builder: (_) => serviceLocator<TopsMoviesBloc>(),
//                 child: new Container(
//       height: MediaQuery.of(context).size.height / 3.0,
//       child: Column(
//         children: <Widget>[
//           titleListTop(title, context),
//           Expanded(child: BlocBuilder<TopsMoviesBloc, TopsMoviesState>(
//         bloc: serviceLocator<TopsMoviesBloc>(),
//         builder: (context, state) {
//           if(state is Empty){
//             _getTopStream(context, topId);
//             return loadingPage;
//           }else if(state is Loading){
//             return loadingPage;
//           }else if (state is Loaded){
//             //! cambiar por el TopsScrollViewHorizontal
//             return new TopsScrollViewHorizontal(
//               items: state.movies,
//               page: () => _getTopStream(context, topId),
//               type: 'movie',
//             );
//           }else if(state is Error){
//             return Text(state.message);
//           }
//           return Center(child: Text('something Error'));
//         },
//       ),
              
          
//           ),
//         ],
//       ),
//     ),
//   ); 
//   }

  // void _getTopStream(BuildContext context, int topId){
  //     switch (topId) {
  //       case Constants.topsMoviesPopularId:
  //         return BlocProvider.of<TopsMoviesBloc>(context).add(GetMoviesTopsPopular(topId));
  //         break;
  //       case Constants.topsMoviesRatedId:
  //         return BlocProvider.of<TopsMoviesBloc>(context).add(GetMoviesTopsRated(topId));
  //         break;
  //       case Constants.topsMoviesUpcommingId:
  //         return BlocProvider.of<TopsMoviesBloc>(context).add(GetMoviesTopsUpcoming(topId));
  //         break;  

  //       default:  BlocProvider.of<TopsMoviesBloc>(context).add(GetMoviesTops(topId));
  //     }
  // }

  
  

  // Widget titleListTop(String title, BuildContext context ){
  //   return ListTile(
  //     onTap: () {
  //       Navigator.pushNamed(context, '/TopList', arguments: title);
  //     },
  //     title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
  //     trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800], fontSize: 16.0 ),),
  //   );
  // }


  
}