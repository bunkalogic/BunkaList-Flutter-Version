import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/container_top_empty_widget.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/stacked_cards_widget.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/banner_premium_widget.dart';
import 'package:flutter/material.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopsFavoritesPage extends StatefulWidget {
  TopsFavoritesPage({Key key}) : super(key: key);

  @override
  _TopsFavoritesPageState createState() => _TopsFavoritesPageState();
}

class _TopsFavoritesPageState extends State<TopsFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _buildBodyTopsFavorites(),
      
    );
  }

  // Widget _buildBodyTopsFavorites() { DDDS

  //   return ListView(
  //     children: [
  //       _labelFavorites(AppLocalizations.of(context).translate("title_top_movie"),),
  //       // dashed container
  //       new BlocProvider<GetListsBloc>(
  //           create: (_) => serviceLocator<GetListsBloc>(),
  //           child: BuildSatckedCardTopFavorites(type: 'movie',),
  //         ),
        
  //       _labelFavorites(AppLocalizations.of(context).translate("title_top_serie"),),
  //       // dashed container
  //       new BlocProvider<GetListsBloc>(
  //           create: (_) => serviceLocator<GetListsBloc>(),
  //           child: BuildSatckedCardTopFavorites(type: 'tv',),
  //         ),
  //         BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/3234817637',),
  //       _labelFavorites(AppLocalizations.of(context).translate("title_top_anime"),),
  //       // dashed container
  //        new BlocProvider<GetListsBloc>(
  //           create: (_) => serviceLocator<GetListsBloc>(),
  //           child: BuildSatckedCardTopFavorites(type: 'anime',),
  //         ),
  //       // dashed container working in new features for create tops
  //       Divider(color: Colors.grey,),
  //       BannerPremiumWidget(),
  //       ContainerTopEmptyWidget(
  //         labelTitle: AppLocalizations.of(context).translate("title_working_feature"),
  //         label: AppLocalizations.of(context).translate("subtitle_working_feature"), 
  //         dottedColor: Colors.pinkAccent[400],
  //         icon: Icons.build_rounded,
  //         onTap: null
  //       ), 
  //     ],
  //   );
  // }

  Widget _labelFavorites(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0, bottom: 15.0, left: 15.0),
      child: Text(
        title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}


