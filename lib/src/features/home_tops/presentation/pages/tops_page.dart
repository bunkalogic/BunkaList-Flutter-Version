import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime_season/animeseason_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_cinema_movie/cinemamovie_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series_air_month/seriesair_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/anime_season_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_more_tops_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_anime_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/scroll_movies_cinema.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/series_month_widget.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import '../../../../../injection_container.dart';





class TopsPage extends StatefulWidget {
  TopsPage({Key key}) : super(key: key);

  _TopsPageState createState() => _TopsPageState();
}

class _TopsPageState extends State<TopsPage> {

  final _controller = NativeAdmobController();

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
        ListTile(
          title: Text(AppLocalizations.of(context).translate("label_movie_cinema"), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
        ),
        new BlocProvider<CinemaMovieBloc>(
          builder: (_) => serviceLocator<CinemaMovieBloc>(),
          child: CarouselMoviesInCinemaWidget(),
        ),
        SizedBox(height: 1.0,),
        MiniNativeBannerAds(adPlacementID: "177059330328908_177063066995201",),
        SizedBox(height: 1.0,),
        new BlocProvider<TopsMoviesBloc>(
          builder: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate('movies_popular'), typeId: Constants.topsMoviesPopularId,),
        ),
        //MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/2168759652', ),
        SizedBox(height: 2.0,),
        ListTile(
          title: Text(AppLocalizations.of(context).translate("label_serie_month"), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
        ),
        new BlocProvider<SeriesAirBloc>(
          builder: (_) => serviceLocator<SeriesAirBloc>(),
          child: CarouselSeriesInMonthWidget(),
        ),
         SizedBox(height: 1.0,),
        MiniNativeBannerAds(adPlacementID: "177059330328908_179569186744589",),
        SizedBox(height: 1.0,),
        new BlocProvider<TopsSeriesBloc>(
          builder: (_) => serviceLocator<TopsSeriesBloc>(),
          child: ContainerListSeriesWidget(title: AppLocalizations.of(context).translate('series_popular'), typeId: Constants.topsSeriesPopularId,),
        ),
        //MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/5724861288', ),
        SizedBox(height: 2.0,),
        ListTile(
          title: Text(AppLocalizations.of(context).translate("label_anime_season"), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
        ),
        new BlocProvider<AnimeSeasonBloc>(
          builder: (_) => serviceLocator<AnimeSeasonBloc>(),
          child: CaruoselAnimeSeasonWidget(),
        ),
        SizedBox(height: 1.0,),
        new BlocProvider<TopsAnimesBloc>(
          builder: (_) => serviceLocator<TopsAnimesBloc>(),
          child:ContainerListAnimeWidget(title: AppLocalizations.of(context).translate('anime_popular'), typeId: Constants.topsAnimePopularId,),
        ),
        //MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/1785616276', ),
        SizedBox(height: 1.0,),
        MaxNativeBannerAds(adPlacementID: "177059330328908_179574190077422",),
        SizedBox(height: 1.0,),
        CardMoreTopsWidget(),
      ],
    );

    

  }



  
}