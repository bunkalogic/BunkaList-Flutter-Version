import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/bottom_loader_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/card_view_list_series_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_animes_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_movies_widget.dart';
import 'package:bunkalist/src/features/home_tops/presentation/widgets/grid_view_list_series_widget.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/bloc/bloc/personaltop1_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExplorerFilterPage extends StatefulWidget {

  final FilterParams data;

  ExplorerFilterPage({
    @required this.data
    });

  @override
  _ExplorerFilterPageState createState() => _ExplorerFilterPageState();
}

class _ExplorerFilterPageState extends State<ExplorerFilterPage> {
  @override
  Widget build(BuildContext context) {
    return new BlocProvider<Personaltop1Bloc>(
      builder: (_) => serviceLocator<Personaltop1Bloc>(),
      child: BuildExplorerFilterListPage(filterParams: widget.data,)
    );
  }
}


class BuildExplorerFilterListPage extends StatefulWidget {
  
  final FilterParams filterParams;
  
  BuildExplorerFilterListPage({
    @required this.filterParams
    });

  @override
  _BuildExplorerFilterListPageState createState() => _BuildExplorerFilterListPageState();
}

class _BuildExplorerFilterListPageState extends State<BuildExplorerFilterListPage> {
  

  final double _aspectRatio = 2.7 / 4.2;

  ScrollController _scrollController;

  bool isLoading = false;
  bool changeDesign = false;
  int page = 1;

  @override
  void initState() {
    _scrollController = ScrollController();

    // BlocProvider.of<Personaltop1Bloc>(context)
    // ..add(GetPersonalTop1(
    //   page: page,
    //   filterParams: widget.filterParams
    // ));

    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: _appBar(),
      body: _buildBody(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: _buildTitle(),
      leading: AppBarButtonBack(),
      actions: [
        IconButton(
          icon: _changedIcon(),
          onPressed: (){
            if(!changeDesign){
              changeDesign = true;
              setState(() { });
            }else{
              changeDesign = false;
              setState(() { });
            }
          },
        ),
      ],
    );
  }

  Widget _buildTitle() {

    return Text(AppLocalizations.of(context).translate("label_filter_personalize"),);

  }


  Widget _changedIcon() {
     
    if(!changeDesign){
      return Icon(Icons.art_track, size: 32, );
    }else {
      return Icon(Icons.view_module, size: 32 ,);
    }    
  }

  Widget _buildBody(){
    return new BlocBuilder<Personaltop1Bloc, Personaltop1State>(
      builder: (context, state) {
        if(state is Personaltop1Initial){

          if(page == 1){
            BlocProvider.of<Personaltop1Bloc>(context)
            ..add(GetPersonalTop1(
              page: page,
              filterParams: widget.filterParams
            ));
          }
          
        }

        if(state is Personaltop1LoadedMovies){
          
          isLoading = false;

          if(state.movies.isEmpty){
            return EmptyIconWidget();
          }else{

              if(!changeDesign){
                
              
              return NotificationListener<ScrollNotification>(
                 onNotification: _handleScrollNotification,
                child: Column(
                  children: [
                    SmallContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (context, i) {
                          return i >= state.movies.length
                            ? BottomLoader()
                            : GridViewListMoviesWidget(movie: state.movies[i],);
                        }, 
                        itemCount: state.hasReachedMax
                          ? state.movies.length
                          : state.movies.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: _aspectRatio
                        ),
                      ),
                    ),
                  ],
                ),
              );
              

            }else {
              
              return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: Column(
                children: [
                  SmallContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                        ? state.movies.length
                        : state.movies.length + 1,
                      itemBuilder: (context , i){
                        
                        return i >= state.movies.length
                          ? BottomLoader()
                          : CardViewListMoviesWidget(movie: state.movies[i],);
                        
                      } 
                    ),
                  ),
                ],
              ),
            );

            }

            }
          

          


        }

        if(state is Personaltop1LoadedSeries){

          isLoading = false;
          
          if(state.series.isEmpty){
            return EmptyIconWidget();
          }else{

              if(!changeDesign){
              
              return NotificationListener<ScrollNotification>(
                 onNotification: _handleScrollNotification,
                child: Column(
                  children: [
                    SmallContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (context, i) {
                          return i >= state.series.length
                            ? BottomLoader()
                            : GridViewListSeriesWidget(series: state.series[i],);
                        }, 
                        itemCount: state.hasReachedMax
                          ? state.series.length
                          : state.series.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: _aspectRatio
                        ),
                      ),
                    ),
                  ],
                ),
              );
              

            }else {
              
              return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: Column(
                children: [
                  SmallContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                        ? state.series.length
                        : state.series.length + 1,
                      itemBuilder: (context , i){
                        
                        return i >= state.series.length
                          ? BottomLoader()
                          : CardViewListSeriesWidget(series: state.series[i],);
                        
                      } 
                    ),
                  ),
                ],
              ),
            );

            }

            }
          

          


        }

        if(state is Personaltop1LoadedAnimes){
          
          isLoading = false;

          if(state.animes.isEmpty){
            return EmptyIconWidget();
          }else{

              if(!changeDesign){
              
              return NotificationListener<ScrollNotification>(
                 onNotification: _handleScrollNotification,
                child: Column(
                  children: [
                    SmallContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (context, i) {
                          return i >= state.animes.length
                            ? BottomLoader()
                            : GridViewListAnimesWidget(anime: state.animes[i],);
                        }, 
                        itemCount: state.hasReachedMax
                          ? state.animes.length
                          : state.animes.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: _aspectRatio
                        ),
                      ),
                    ),
                  ],
                ),
              );
              

            }else {
              
              return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: Column(
                children: [
                  SmallContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/7229321126',),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                        ? state.animes.length
                        : state.animes.length + 1,
                      itemBuilder: (context , i){
                        
                        return i >= state.animes.length
                          ? BottomLoader()
                          : CardViewListAnimesWidget(anime: state.animes[i],);
                        
                      } 
                    ),
                  ),
                ],
              ),
            );

            }

            }
          


        }
        
        if(state is ErrorPersonaltop1){
          return EmptyIconWidget();
        }

        return LoadingCustomWidget();

      }
    );
  }


  bool _handleScrollNotification(ScrollNotification notification){
     final offsetVisibleThreshold = 50; // or something else..

    if (notification is ScrollEndNotification &&
    _scrollController.offset + offsetVisibleThreshold >=
    _scrollController.position.maxScrollExtent){

      isLoading = true;

      (!isLoading) ? page : page++;

      BlocProvider.of<Personaltop1Bloc>(context)
      ..add(GetPersonalTop1(
        page: page,
        filterParams: widget.filterParams
      ));

    }

    isLoading = false;
    return isLoading;

  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}