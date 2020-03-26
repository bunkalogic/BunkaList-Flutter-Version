import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_more_tops_widget.dart';
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

    return ListView(
      children: <Widget>[
        //* Add Ads banner
        new BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate('movies_popular'), typeId: Constants.topsMoviesPopularId,),
        ),
        SizedBox(height: 1.0,),
        new BlocProvider<TopsSeriesBloc>(
          builder: (_) => serviceLocator<TopsSeriesBloc>(),
          child: ContainerListSeriesWidget(title: AppLocalizations.of(context).translate('series_popular'), typeId: Constants.topsSeriesPopularId,),
        ),
        SizedBox(height: 1.0,),
        new BlocProvider<TopsAnimesBloc>(
          builder: (_) => serviceLocator<TopsAnimesBloc>(),
          child:ContainerListAnimeWidget(title: AppLocalizations.of(context).translate('anime_popular'), typeId: Constants.topsAnimePopularId,),
        ),
        CardMoreTopsWidget(),
      ],
    );

    

  }



  
}