
import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/utils/get_list_company.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/card_tops_types.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/scroll_company_widget.dart';
import 'package:bunkalist/src/features/explorer/presentation/widgets/scroll_row_genres.dart';
import 'package:bunkalist/src/features/search/domain/entities/search_result_entity.dart';
import 'package:bunkalist/src/features/search/presentation/bloc/bloc.dart';
import 'package:bunkalist/src/features/search/presentation/pages/search_page.dart';
import 'package:bunkalist/src/core/utils/get_list_genres.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/banner_premium_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerPage extends StatefulWidget {
  ExplorerPage({Key key}) : super(key: key);

  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {

  final prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _titleExplorer(),
        new BlocProvider(
          builder: (_) => serviceLocator<SearchBloc>(),
          child: BoxSearch(),
        ),
        CardTypesMoreTopsWidget(),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_company_series")),
        ScrollCompanyWidget(companies: getListSeriesCompany(),),
        SizedBox(height: 15.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_company_animes")),
        ScrollCompanyWidget(companies: getListAnimesCompany(),),
        SizedBox(height: 15.0,),
        BannerPremiumWidget(),
        SizedBox(height: 15.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_genres_movie")),
        SizedBox(height: 5.0,),
        ScrollRowGenres(genres:  getListGenresMovies(context),),
        SizedBox(height: 15.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_genres_serie")),
        SizedBox(height: 5.0,),
        ScrollRowGenres(genres:  getListGenresSeries(context),),
        SizedBox(height: 15.0,),
        _labelScrollGenres(AppLocalizations.of(context).translate("label_genres_anime")),
        SizedBox(height: 5.0,),
        ScrollRowGenres(genres:  getListGenresAnimes(context),),
        SizedBox(height: 35.0,),
        BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/6111874096',),
        
      ],
    );
  }

  Widget _titleExplorer() {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0),
      child: Text(
        AppLocalizations.of(context).translate("title_label_explore"),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          shadows: [
            Shadow(
              color: Colors.greenAccent[400],
              blurRadius: 1.0,
              offset: Offset(0.5, 0.5),
            ),
            Shadow(
              color: Colors.blueAccent[400],
              blurRadius: 1.0,
              offset: Offset(-0.5, 0.5),
            ),
            Shadow(
              color: Colors.redAccent[400],
              blurRadius: 1.0,
              offset: Offset(0.5, -0.5),
            ),
          ]
        ),
      ),
    );
  }

  Widget _labelScrollGenres(String label){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800
        ),
      ),
    );
  }
  
}


class BoxSearch extends StatelessWidget {
  

  final prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: (){

        showSearch<ResultsEntity>(
          context: context,
          delegate: MultiSearchWidget(BlocProvider.of<SearchBloc>(context)),
        );

      },
      child: Container(
        height: 45.0,
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: prefs.whatModeIs ? Colors.grey[100] : Colors.grey[800],
        ),
        child: _rowBoxSearch(context),
      ),
    );
  }

 

  Widget _rowBoxSearch(BuildContext context) {

   final String labelMovie = AppLocalizations.of(context).translate("movies");
   final String labelSerie = AppLocalizations.of(context).translate("series");
   final String labelAnime = AppLocalizations.of(context).translate("animes");

   final String labelSearch = "$labelMovie, $labelSerie & $labelAnime";  

    return Row(
      children: [
        SizedBox(width: 10.0,),
        Icon(
          Icons.search,
          size: 35.0,
          color: Colors.deepPurpleAccent,
        ),
        SizedBox(width: 20.0,),
        Text(
          labelSearch,
          style: TextStyle(
            color: prefs.whatModeIs ? Colors.grey[900] : Colors.grey[100],
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic
          ),
        )
      ],
    );
  }
}
