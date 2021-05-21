import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:bunkalist/src/core/utils/get_random_number.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/card_tops_types.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/scroll_company_widget.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/scroll_row_genres.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/tab_bar_series_company_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime_season/animeseason_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_cinema_movie/cinemamovie_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_animes/selectionanimes_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_movies/selectionmovies_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_series/selectionseries_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series_air_month/seriesair_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/anime_season_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_more_tops_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_anime_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/container_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/scroll_movies_cinema.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/series_month_widget.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/banner_premium_widget.dart';

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
    
      bool random = randomAdsOrBanner();

    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(AppLocalizations.of(context).translate("label_movie_cinema"), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
        ),
        new BlocProvider<CinemaMovieBloc>(
          create: (_) => serviceLocator<CinemaMovieBloc>(),
          child: CarouselMoviesInCinemaWidget(),
        ),
        SizedBox(height: 10.0,),
        new BlocProvider<TopsMoviesBloc>(
          create: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate("label_tops_more_popular"), typeId: Constants.topsMoviesPopularId,),
        ),
        SizedBox(height: 10.0,),
        new BlocProvider<TopsMoviesBloc>(
          create: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate("label_tops_best_rated"), typeId: Constants.topsMoviesRatedId,),
        ),
        
        SizedBox(height: 20.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_genres_movie")),
        SizedBox(height: 10.0,),
        ScrollRowGenres(genres:  getListGenresMovies(context),),
        SizedBox(height: 10.0,),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/2168759652', ),
        SizedBox(height: 10.0,),
        new BlocProvider<TopsSeriesBloc>(
          create: (_) => serviceLocator<TopsSeriesBloc>(),
          child: ContainerListSeriesWidget(title: AppLocalizations.of(context).translate("label_tops_more_popular"), typeId: Constants.topsSeriesPopularId,),
        ),
        SizedBox(height: 10.0,),
        ListTile(
          title: Text(AppLocalizations.of(context).translate("label_serie_month"), style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
        ),
        new BlocProvider<SeriesAirBloc>(
          create: (_) => serviceLocator<SeriesAirBloc>(),
          child: CarouselSeriesInMonthWidget(),
        ),
         SizedBox(height: 10.0,),
        //MiniNativeBannerAds(adPlacementID: "177059330328908_179569186744589",),
        // SizedBox(height: 1.0,),
        new BlocProvider<TopsSeriesBloc>(
          create: (_) => serviceLocator<TopsSeriesBloc>(),
          child: ContainerListSeriesWidget(title: AppLocalizations.of(context).translate("label_tops_best_rated"), typeId: Constants.topsSeriesRatedId,),
        ),
        SizedBox(height: 20.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_genres_serie")),
        SizedBox(height: 10.0,),
        ScrollRowGenres(genres:  getListGenresSeries(context),),
        SizedBox(height: 20.0,),

        SizedBox(height: 10.0,),
        random
        ? MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/5724861288', )
        : BannerPremiumWidget(),
        SizedBox(height: 10.0,),
        new BlocProvider<TopsAnimesBloc>(
          create: (_) => serviceLocator<TopsAnimesBloc>(),
          child: ContainerListAnimeWidget(title: AppLocalizations.of(context).translate("label_tops_more_popular"), typeId: Constants.topsAnimePopularId,),
        ),
        SizedBox(height: 10.0,),
        ListTile(
          title: Text(AppLocalizations.of(context).translate("label_tops_season_spring"), style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
        ),
        new BlocProvider<AnimeSeasonBloc>(
          create: (_) => serviceLocator<AnimeSeasonBloc>(),
          child: CaruoselAnimeSeasonWidget(),
        ),
        SizedBox(height: 10.0,),
        new BlocProvider<TopsAnimesBloc>(
          create: (_) => serviceLocator<TopsAnimesBloc>(),
          child:ContainerListAnimeWidget(title: AppLocalizations.of(context).translate('label_tops_best_rated'), typeId: Constants.topsAnimeRatedId,),
        ),
        SizedBox(height: 10.0,),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/1785616276', ),
        SizedBox(height: 20.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_genres_anime")),
        SizedBox(height: 10.0,),
        ScrollRowGenres(genres:  getListGenresAnimes(context),),
        //MaxNativeBannerAds(adPlacementID: "177059330328908_179574190077422",),
        // CardMoreTopsWidget(),
        CardTypesMoreTopsWidget(),
        BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7693328979', ),
        SizedBox(height: 10.0,),
        new BlocProvider<TopsMoviesBloc>(
          create: (_) => serviceLocator<TopsMoviesBloc>(),
          child:ContainerListMoviesWidget(title: AppLocalizations.of(context).translate("genre_thriller"), typeId: Constants.topsMoviesThillerId,),
        ),
        SizedBox(height: 20.0,),
        //MiniNativeBannerAds(adPlacementID: "177059330328908_179569186744589",),
        // SizedBox(height: 1.0,),
        new BlocProvider<TopsSeriesBloc>(
          create: (_) => serviceLocator<TopsSeriesBloc>(),
          child: ContainerListSeriesWidget(title: 'Netflix', typeId: Constants.topsSeriesNetflixId,),
        ),

         SizedBox(height: 10.0,),
        new BlocProvider<SelectionseriesBloc>(
          create: (_) => serviceLocator<SelectionseriesBloc>(),
          child: ContainerListSelectionSeriesWidget(title: AppLocalizations.of(context).translate("label_tops_underrated"), typeId: Constants.selectionSeriesId,),
        ),
      
        
        SizedBox(height: 20.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_company_series")),
        TabBarSeriesCompanyWidget(),
        SizedBox(height: 20.0,),

        
        new BlocProvider<TopsAnimesBloc>(
          create: (_) => serviceLocator<TopsAnimesBloc>(),
          child:ContainerListAnimeWidget(title: AppLocalizations.of(context).translate('label_tops_season_summer'), typeId: Constants.topsAnimeUpcomingNextSeasonId,),
        ),

         SizedBox(height: 10.0,),
         
        new BlocProvider<SelectionanimesBloc>(
          create: (_) => serviceLocator<SelectionanimesBloc>(),
          child: ContainerListSelectionAnimeWidget(title: AppLocalizations.of(context).translate("label_tops_underrated"), typeId: Constants.selectionAnimesId,),
        ),
        
        SizedBox(height: 20.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_company_animes")),
        ScrollCompanyWidget(companies: getListAnimesCompany(),),
        SizedBox(height: 20.0,),
      ],
    );

    

  }


  Widget _labelScrollGenres(String label){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  
}