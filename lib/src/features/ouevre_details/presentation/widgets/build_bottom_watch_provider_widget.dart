import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/core/utils/get_watch_provider_from_country_util.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/watch_provider_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';



class BuildBottomWatchProviderWidget extends StatefulWidget {


  final int id;
  final String type;
  

  BuildBottomWatchProviderWidget({@required this.id, @required this.type});

  @override
  _BuildBottomWatchProviderWidgetState createState() => _BuildBottomWatchProviderWidgetState();
}

class _BuildBottomWatchProviderWidgetState extends State<BuildBottomWatchProviderWidget> {
  
  
 @override
  void initState() {
    BlocProvider.of<OuevreDetailsBloc>(context)
    ..add(GetMoreDetailsOuevreWatchProvider(widget.id, widget.type));
    super.initState();
  } 

  
  @override
  Widget build(BuildContext context) {

   return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: 10,),
        Container(
          child: BlocBuilder<OuevreDetailsBloc, OuevreDetailsState>(
          builder: (context, state){
          
            if(state is Empty){
           
              return LoadingCustomWidget();

            }else if(state is Loading){

              return LoadingCustomWidget();

            }else if(state is LoadedWatchProvider){
           

              return BuildWatchProvider(watchProvider: state.watchProvider,);

            }else if(state is Error){

              return Center(
                child: Text(state.message),
              );

            }

            return Center(
                 child: Text('something Error'),
            );

          }
        ),
      ),
      SizedBox(height: 10,),
      _labelPoweredBy(),
      SizedBox(height: 10,),
      ],
    ); 
  
  }


  Widget _labelPoweredBy() {

    final label = AppLocalizations.of(context).translate("api_label");
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic
            ),
          ),
         GestureDetector(
           onTap: (){
             launch('https://www.justwatch.com');
           },
           child: Text(
             ' JustWatch',
             style: TextStyle(
               fontSize: 14.0,
               fontWeight: FontWeight.w800,
               color: Colors.blueAccent[400]
             ),
           ),
         )
        ],
      ),
    );

    
  }

}


class BuildWatchProvider extends StatefulWidget {
  
  final WatchProvider watchProvider;
  
  BuildWatchProvider({@required this.watchProvider});

  @override
  _BuildWatchProviderState createState() => _BuildWatchProviderState();
}

class _BuildWatchProviderState extends State<BuildWatchProvider> {
  
  final Preferences prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    Results results = widget.watchProvider.results;

   Ar watchProvider = getWatchProviderFromCountry(results: results);

   if (watchProvider.link == ''){
     watchProvider = results.us;
   }

   List<Buy> streamings = watchProvider.flatrate;


   return Container(
      height: 140.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: streamings.length,
        itemBuilder: (context, i) => _buildItemStreaming(streamings[i], watchProvider.link),
      ),
    ); 
   
  }

  Widget _buildItemStreaming(Buy streaming, String link) {
    return Column(
      children: [
        _itemImageCompany(streaming, link),
        _itemNameCompany(streaming)
      ],
    );  
  }

  Widget _itemImageCompany(Buy streaming, String link) {
    
    
    return GestureDetector(
      onTap: (){

        launch(link);

      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.network(
            'https://image.tmdb.org/t/p/original/${streaming.logoPath}',
            height: 45.0,
            width: 45.0,
            fit: BoxFit.contain,
          ),
        )
      ),
    );
  }

  Widget _itemNameCompany(Buy streaming) {
    return Center(
      child: Text(
        streaming.providerName,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }


  
}