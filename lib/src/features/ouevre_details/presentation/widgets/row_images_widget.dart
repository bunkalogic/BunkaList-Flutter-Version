import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/ouevre_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RowImagesWidget extends StatefulWidget {

  final int id;
  final String type;

  RowImagesWidget({@required this.id, @required this.type});

  @override
  _RowImagesWidgetState createState() => _RowImagesWidgetState();
}

class _RowImagesWidgetState extends State<RowImagesWidget> {
  
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

      if(state is Empty){

          return LoadingCustomWidget();

      }else if(state is Loading){
          
          return LoadingCustomWidget();

      }else if(state is LoadedImages){


        return _buildRowImages(state.posterImages);

      }else if(state is Error){
          
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


  Widget _buildRowImages(PosterImages posterImages){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _backgroundTotalImages(posterImages.backdrops),

        _posterTotalImages(posterImages.posters),
        
      ],
    );
  }

  Widget _posterTotalImages(List<Backdrop> posters){

    if(posters.isEmpty){
      return SizedBox.shrink();
    }

    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w342${ posters.first.filePath }');

    final label = AppLocalizations.of(context).translate('label_poster');
  
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/AllDetailsImages', arguments: posters);
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            width: 100,
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400].withOpacity(0.4),
                  blurRadius: 0.5,
                  spreadRadius: 0.5
                ),
              ]
            ),
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 140.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      image: (posters.isEmpty == null) ? placeholder : poster,//? Image Poster Item,
                      placeholder: placeholder, //? PlaceHolder Item,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${posters.length} $label',
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 16.0,
                      shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.9, 0.9))],
                      fontWeight: FontWeight.w800 
                    ),
                  ),
                )
              ]
            ),
        ),
      ),
    );

  }

  Widget _backgroundTotalImages(List<Backdrop> backdrops){

    if(backdrops.isEmpty){
      return SizedBox.shrink();
    }
    
    final placeholder = AssetImage('assets/poster_placeholder.png'); 
    final poster = NetworkImage('https://image.tmdb.org/t/p/w780${ backdrops.first.filePath }');

    final label = AppLocalizations.of(context).translate('label_background');

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/AllDetailsImages', arguments: backdrops);
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            width: 200,
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400].withOpacity(0.4),
                  blurRadius: 0.5,
                  spreadRadius: 0.5
                ),
              ]
            ),
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 140.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      image: (backdrops.isEmpty == null) ? placeholder : poster,//? Image Poster Item,
                      placeholder: placeholder, //? PlaceHolder Item,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "${backdrops.length} $label",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 18.0,
                      shadows: [Shadow(blurRadius: 1.0, color:  Colors.black, offset: Offset(0.9, 0.9))],
                      fontWeight: FontWeight.w800 
                    ),
                  ),
                )
              ]
            ),
        ),
      ),
    );

  }
}