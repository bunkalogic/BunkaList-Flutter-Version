import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/search/presentation/widgets/empty_icon_widget.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/entities/filter_entity.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/bloc/bloc/personaltop1_bloc.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/widgets/container_poster_widget.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/widgets/item_poster_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuildListPersonalHomeTops extends StatefulWidget {
  
  final FilterParams filterParams;
  
  BuildListPersonalHomeTops({@required this.filterParams});

  @override
  _BuildListPersonalHomeTopsState createState() => _BuildListPersonalHomeTopsState();
}

class _BuildListPersonalHomeTopsState extends State<BuildListPersonalHomeTops> {
  @override
  Widget build(BuildContext context) {
    return new BlocProvider<Personaltop1Bloc>(
      builder: (_) => serviceLocator<Personaltop1Bloc>(),
      child: getTypeBuildList()
    );
  }


  Widget getTypeBuildList(){
    switch (widget.filterParams.type) {
      
      case 'movie':   return new BuildListMoviePersonalHomeTops(filterParams: widget.filterParams,);
        break;

      case 'tv':      return new BuildListSeriePersonalHomeTops(filterParams: widget.filterParams,);
        break;

      case 'anime':   return new BuildListAnimePersonalHomeTops(filterParams: widget.filterParams,);
        break;    

      default: return BuildListSeriePersonalHomeTops(filterParams: widget.filterParams,);
    }
  }

}







class BuildListMoviePersonalHomeTops extends StatefulWidget {
  
  final FilterParams filterParams;
  
  BuildListMoviePersonalHomeTops({@required this.filterParams});

  @override
  _BuildListMoviePersonalHomeTopsState createState() => _BuildListMoviePersonalHomeTopsState();
}

class _BuildListMoviePersonalHomeTopsState extends State<BuildListMoviePersonalHomeTops> {

  
  ScrollController _scrollController;

  
  bool isLoading = false;
  bool changeDesign = false;
  int page = 1;


  

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        height: widget.filterParams.design ? 265.0 : 288.0,  //MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            _titleList(widget.filterParams.title),
            SizedBox(height: 10,),
            _buildListViewBuilder()
          ],
        ),
      ),
    );
  }

  Widget _titleList(String title){
    return ListTile(
      onTap: () {
        // Navigator.pushNamed(context, '/TopList', arguments: 'movie');
        Navigator.pushNamed(context, '/HomeTopsPersonalDetails', arguments: widget.filterParams);
      },
      title: Text(title, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }

  Widget _buildListViewBuilder(){

    CarouselOptions containerPosterCarousel = CarouselOptions(
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: false,
      enableInfiniteScroll: true
    );

    CarouselOptions itemPosterCarousel = CarouselOptions(
      enlargeCenterPage: true,
      aspectRatio: 16 / 9,
      autoPlay: false,
      viewportFraction: 0.35,
      enableInfiniteScroll: true
    );


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
          
          if(state.movies.isEmpty){
            return Center(child: EmptyIconWidget());
          }

          return CarouselSlider.builder(
                options: widget.filterParams.design 
                ? containerPosterCarousel 
                : itemPosterCarousel,
                // RcarouselController: _scrollController,
                itemCount: state.movies.length,
                itemBuilder: (context, i, h) => widget.filterParams.design 
                  ? ContainerPosterMovieWidget(movie: state.movies[i],) 
                  :  ItemPosterMovieWidget(movie: state.movies[i],)
              );          

          // return NotificationListener<ScrollNotification>(
          //     onNotification: _handleScrollNotification,
          //     child: CarouselSlider.builder(
          //       options: widget.filterParams.design 
          //       ? containerPosterCarousel 
          //       : itemPosterCarousel,
          //       carouselController: _scrollController,
          //       itemCount: state.movies.length,
          //       itemBuilder: (context, i, h) => widget.filterParams.design 
          //         ? ContainerPosterMovieWidget(movie: state.movies[i],) 
          //         :  ItemPosterMovieWidget(movie: state.movies[i],)
          //     ),
          //   );


        }

        
        if(state is ErrorPersonaltop1){
          return Center(child: EmptyIconWidget());
        }

        return Center(child: LoadingCustomWidget());

      },
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


class BuildListSeriePersonalHomeTops extends StatefulWidget {
  
  final FilterParams filterParams;
  
  BuildListSeriePersonalHomeTops({@required this.filterParams});

  @override
  _BuildListSeriePersonalHomeTopsState createState() => _BuildListSeriePersonalHomeTopsState();
}

class _BuildListSeriePersonalHomeTopsState extends State<BuildListSeriePersonalHomeTops> {
  
  ScrollController _scrollController;

  
  bool isLoading = false;
  bool changeDesign = false;
  int page = 1;


  

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        height: widget.filterParams.design ? 265.0 : 288.0, //MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            _titleList(widget.filterParams.title),
            SizedBox(height: 10,),
            _buildListViewBuilder()
          ],
        ),
      ),
    );
  }

  Widget _titleList(String title){
    return ListTile(
      onTap: () {
        // Navigator.pushNamed(context, '/TopList', arguments: 'tv');
        Navigator.pushNamed(context, '/HomeTopsPersonalDetails', arguments: widget.filterParams);
      },
      title: Text(title, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }

  Widget _buildListViewBuilder(){


    CarouselOptions containerPosterCarousel = CarouselOptions(
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: false,
      enableInfiniteScroll: true
    );

    CarouselOptions itemPosterCarousel = CarouselOptions(
      enlargeCenterPage: true,
      aspectRatio: 16 / 9,
      autoPlay: false,
      viewportFraction: 0.35,
      enableInfiniteScroll: true
    );
    


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

        if(state is Personaltop1LoadedSeries){
          
          if(state.series.isEmpty){
            return Center(child: EmptyIconWidget());
          }

          return CarouselSlider.builder(
                options: widget.filterParams.design 
                ? containerPosterCarousel 
                : itemPosterCarousel,
                // carouselController: _scrollController,
                itemCount: state.series.length,
                itemBuilder: (context, i, h) => widget.filterParams.design 
                  ? ContainerPosterSerieWidget(serie: state.series[i],) 
                  :  ItemPosterSerieWidget(series: state.series[i],)
              );

          // return NotificationListener<ScrollNotification>(
          //     onNotification: _handleScrollNotification,
          //     child: CarouselSlider.builder(
          //       options: widget.filterParams.design 
          //       ? containerPosterCarousel 
          //       : itemPosterCarousel,
          //       carouselController: _scrollController,
          //       itemCount: state.series.length,
          //       itemBuilder: (context, i, h) => widget.filterParams.design 
          //         ? ContainerPosterSerieWidget(serie: state.series[i],) 
          //         :  ItemPosterSerieWidget(series: state.series[i],)
          //     ),
          //   );
          

        }

        
        if(state is ErrorPersonaltop1){
          return Center(child: EmptyIconWidget());
        }

        return Center(child: LoadingCustomWidget());

      },
    );
  }


  bool _handleScrollNotification(ScrollNotification notification){
     final offsetVisibleThreshold = 50; // or something else..

    if (notification is ScrollEndNotification &&
       _scrollController.offset + offsetVisibleThreshold >=
        _scrollController.position.maxScrollExtent){

          isLoading = true;

          !isLoading ? page : page++;

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


class BuildListAnimePersonalHomeTops extends StatefulWidget {
  
  final FilterParams filterParams;
  
  BuildListAnimePersonalHomeTops({@required this.filterParams});

  @override
  _BuildListAnimePersonalHomeTopsState createState() => _BuildListAnimePersonalHomeTopsState();
}

class _BuildListAnimePersonalHomeTopsState extends State<BuildListAnimePersonalHomeTops> {
  
  
  ScrollController _scrollController;

  
  bool isLoading = false;
  bool changeDesign = false;
  int page = 1;


  

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Container(
        height: widget.filterParams.design ? 265.0 : 288.0, // MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            _titleList(widget.filterParams.title),
            SizedBox(height: 10,),
            _buildListViewBuilder()
          ],
        ),
      ),
    );
  }

  Widget _titleList(String title){
    return ListTile(
      onTap: () {
        // Navigator.pushNamed(context, '/TopList', arguments: 'anime');
        Navigator.pushNamed(context, '/HomeTopsPersonalDetails', arguments: widget.filterParams);
      },
      title: Text(title, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent[400], fontSize: 16.0 ),),
    );
  }

  Widget _buildListViewBuilder(){


    CarouselOptions containerPosterCarousel = CarouselOptions(
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: false,
      enableInfiniteScroll: true
    );

    CarouselOptions itemPosterCarousel = CarouselOptions(
      enlargeCenterPage: true,
      aspectRatio: 16 / 9,
      autoPlay: false,
      viewportFraction: 0.33,
      enableInfiniteScroll: true
    );

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

        if(state is Personaltop1LoadedAnimes){
          
          if(state.animes.isEmpty){
            return Center(child: EmptyIconWidget());
          }
          
          return CarouselSlider.builder(
                options: widget.filterParams.design 
                ? containerPosterCarousel 
                : itemPosterCarousel,
                // carouselController: _scrollController,
                itemCount: state.animes.length,
                itemBuilder: (context, i, h) => widget.filterParams.design 
                  ? ContainerPosterAnimeWidget(anime: state.animes[i],) 
                  : ItemPosterAnimeWidget(anime: state.animes[i],)
              );

          //  return NotificationListener<ScrollNotification>(
          //     onNotification: _handleScrollNotification,
          //     child: CarouselSlider.builder(
          //       options: widget.filterParams.design 
          //       ? containerPosterCarousel 
          //       : itemPosterCarousel,
          //       carouselController: _scrollController,
          //       itemCount: state.animes.length,
          //       itemBuilder: (context, i, h) => widget.filterParams.design 
          //         ? ContainerPosterAnimeWidget(anime: state.animes[i],) 
          //         : ItemPosterAnimeWidget(anime: state.animes[i],)
          //     ),
          //   );

        }

        
        if(state is ErrorPersonaltop1){
          return Center(child: EmptyIconWidget());
        }

        return Center(child: LoadingCustomWidget());

      },
    );
  }


  bool _handleScrollNotification(ScrollNotification notification){
     final offsetVisibleThreshold = 50; // or something else..

    if (notification is ScrollEndNotification &&
       _scrollController.offset + offsetVisibleThreshold >=
        _scrollController.position.maxScrollExtent){

          isLoading = true;

          !isLoading ? page : page++;

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

