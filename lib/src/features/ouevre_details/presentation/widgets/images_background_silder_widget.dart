import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ImagesBackgroundSlider extends StatefulWidget {
  
  final int id;
  final String type;
  
  ImagesBackgroundSlider({@required this.id, @required this.type});

  @override
  _ImagesBackgroundSliderState createState() => _ImagesBackgroundSliderState();
}

class _ImagesBackgroundSliderState extends State<ImagesBackgroundSlider> {
  
  @override
  void initState() {
    BlocProvider.of<OuevreDetailsBloc>(context)
    ..add(GetMoreDetailsOuevreImages(widget.id, widget.type));
    super.initState();
  } 

  
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
     builder: (context, state){

      if(state is EmptyDetails){

          return LoadingCustomWidget();

      }else if(state is LoadingDetails){
          
          return LoadingCustomWidget();

      }else if(state is LoadedImages){

        return BuildImagesBackgroundSlider(backdrops: state.posterImages.backdrops,);

      }else if(state is ErrorDetails){
          
          return Center(
            child: Text(state.message),
          );

        }

        return Center(
            child: Text('something Error'),
          );

     }
   );
  }


}


class BuildImagesBackgroundSlider extends StatefulWidget {
  
  final List<Backdrop> backdrops;
  
  BuildImagesBackgroundSlider({@required this.backdrops});

  @override
  _BuildImagesBackgroundSliderState createState() => _BuildImagesBackgroundSliderState();
}

class _BuildImagesBackgroundSliderState extends State<BuildImagesBackgroundSlider> {
  
   int _current = 0;


  @override
  Widget build(BuildContext context) {

    

    return CarouselSlider(
      items: _listSliderWidgets(), 
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,
        // aspectRatio: 16 / 9,
        height: double.infinity,
        viewportFraction: 1.0,
        autoPlayInterval: const Duration(seconds: 15),
        autoPlayAnimationDuration: const Duration(milliseconds: 700),
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        }
      )
    );
  }

  List<Widget> _listSliderWidgets(){

   
    List<Widget> listWidgets = [];
    

    if(widget.backdrops.length < 5){

      widget.backdrops.forEach((item) {

      final placeholder = AssetImage('assets/poster_placeholder.png'); 
      final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ item.filePath }');

      Widget imageBackground = 
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FadeInImage(
          image: (item.filePath == null) ? placeholder : poster,
          placeholder: placeholder, 
          fit: BoxFit.fill,
        // width:  double.infinity,
        ),
      );
      

      listWidgets.add(imageBackground);

    });

    }else if(widget.backdrops.length > 5){


      for (var i = 0; i < 4; i++) {
        
        final placeholder = AssetImage('assets/poster_placeholder.png'); 
      final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ widget.backdrops[i].filePath }');

      Widget imageBackground = 
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FadeInImage(
          image: (widget.backdrops[i].filePath == null) ? placeholder : poster,
          placeholder: placeholder, 
          fit: BoxFit.fill,
        // width:  double.infinity,
        ),
      );
      

      listWidgets.add(imageBackground);

      }


    }

    

    return listWidgets;

  }
}