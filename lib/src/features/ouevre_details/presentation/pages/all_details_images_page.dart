import 'package:admob_flutter/admob_flutter.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/app_bar_back_button_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/interstitial_ads_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/images_poster_entity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class AllDetailsImagesPage extends StatefulWidget {

  final List<Backdrop> images;

  AllDetailsImagesPage({@required this.images});

  @override
  _AllDetailsImagesPageState createState() => _AllDetailsImagesPageState();
}

class _AllDetailsImagesPageState extends State<AllDetailsImagesPage> {
  
  int _current = 1;

  final Preferences prefs = Preferences();

  AdmobInterstitial interstitialAd;

  @override
  void initState() { 
    super.initState();


    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-6667428027256827/9781810380',
    );

    if(!prefs.isNotAds){

      interstitialAd.load();

    }

    

    

    // getInterstitialAds('ca-app-pub-6667428027256827/9781810380');
  }


  void _getShowAds() async {
     if(!prefs.isNotAds){

      if (await interstitialAd.isLoaded) {
        print('----Ads is showing !!!! ----');
        interstitialAd.show();
      }
      
    } 
    
  }


  @override
  void dispose() {

    interstitialAd.dispose();
    super.dispose();
  }

  
  
  @override
  Widget build(BuildContext context) {
    
    _getShowAds();

    final String label = AppLocalizations.of(context).translate('label_images');

    return Scaffold(
      appBar: AppBar(
        leading: AppBarButtonBack(),
        title: Text('$label ( $_current / ${widget.images.length} )')
      ),
      body: _carouselImages(),

    );
  }

  Widget _carouselImages() {

    return CarouselSlider(
      items: _listSliderWidgets(), 
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: false,
        // aspectRatio: 16 / 9,
        height: double.infinity,
        viewportFraction: 1.0,
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
    

    

      widget.images.forEach((item) {

      final placeholder = AssetImage('assets/poster_placeholder.png'); 
      final poster = NetworkImage('https://image.tmdb.org/t/p/w1280${ item.filePath }');

      Widget imageBackground = 
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FadeInImage(
          image: (item.filePath == null) ? placeholder : poster,
          placeholder: placeholder, 
          fit: BoxFit.contain,
        // width:  double.infinity,
        ),
      );
      

      listWidgets.add(imageBackground);

    });

    

    

    return listWidgets;

  }



}
