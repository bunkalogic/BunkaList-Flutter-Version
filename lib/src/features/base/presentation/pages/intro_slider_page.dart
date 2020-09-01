import 'dart:async';

import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';


class IntroSliderPage extends StatefulWidget {
  IntroSliderPage({Key key}) : super(key: key);

  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {

  List<Slide> slides = new List<Slide>();

  Function goToTab;

  Preferences prefs = Preferences();

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(milliseconds: 800), () {
  //   //  Timer.run((){
  //    List<Slide> listSlides = new List<Slide>();

  //   listSlides.add(
  //     new Slide(
  //       description: AppLocalizations.of(context).translate('label_intro_1'),
  //       styleDescription: TextStyle(
  //         color: Colors.grey[200],
  //         fontSize: 20.0,
  //         fontStyle: FontStyle.italic,
  //         fontWeight: FontWeight.w400
  //       ),
  //       backgroundColor: Colors.deepPurpleAccent[100],
  //       pathImage: 'assets/film-reel.png'
  //     )
  //   );

  //   listSlides.add(
  //     new Slide(
  //       description: AppLocalizations.of(context).translate('label_intro_2'),
  //       styleDescription: TextStyle(
  //         color: Colors.grey[200],
  //         fontSize: 20.0,
  //         fontStyle: FontStyle.italic,
  //         fontWeight: FontWeight.w400
  //       ),
  //       backgroundColor: Colors.deepPurpleAccent,
  //       pathImage: 'assets/smartphone.png'
  //     )
  //   );

  //   listSlides.add(
  //     new Slide(
  //       description: AppLocalizations.of(context).translate('label_intro_3'),
  //       styleDescription: TextStyle(
  //         color: Colors.grey[200],
  //         fontSize: 20.0,
  //         fontStyle: FontStyle.italic,
  //         fontWeight: FontWeight.w400
  //       ),
  //       backgroundColor: Colors.deepPurpleAccent[400],
  //       pathImage: 'assets/dashboard.png'
  //     )
  //   );

  //    setState(() {
       
  //      slides = listSlides;
      

  //    }); 
      

  //   });

    
  // }
  

   void onDonePress() {
    
    prefs.isOpenFirstTime = false;
    Navigator.pushReplacementNamed(context, '/');
  }


  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.deepOrangeAccent,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.deepOrangeAccent,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
        Icons.skip_next,
        color: Colors.deepOrangeAccent,
      );
  }

  //   List<Widget> renderListCustomTabs() {
  //   List<Widget> tabs = new List();
  //   for (int i = 0; i < slides.length; i++) {
  //     Slide currentSlide = slides[i];
  //     tabs.add(Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.height,
  //       margin: EdgeInsets.all(0.0),
  //       child: Container(
  //         margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
  //         child: ListView(
  //           children: <Widget>[
  //             GestureDetector(
  //                 child: Image.asset(
  //               currentSlide.pathImage,
  //               width: 200.0,
  //               height: 200.0,
  //               fit: BoxFit.contain,
  //             )),
  //             Container(
  //               child: Text(
  //                 currentSlide.description,
  //                 style: currentSlide.styleDescription,
  //                 textAlign: TextAlign.center,
  //                 maxLines: 5,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               margin: EdgeInsets.only(top: 20.0),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ));
  //   }
  //   return tabs;
  // }

  @override
  Widget build(BuildContext context) {

    slides.add(
      new Slide(
        description: AppLocalizations.of(context).translate('label_intro_1'),
        styleDescription: TextStyle(
          color: Colors.grey[200],
          fontSize: 22.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
        backgroundColor: Colors.deepPurpleAccent,
        pathImage: 'assets/film-reel.png'
      )
    );

    slides.add(
      new Slide(
        description: AppLocalizations.of(context).translate('label_intro_2'),
        styleDescription: TextStyle(
          color: Colors.grey[200],
          fontSize: 22.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
        backgroundColor: Colors.deepPurpleAccent[400],
        pathImage: 'assets/smartphone.png'
      )
    );

    slides.add(
      new Slide(
        description: AppLocalizations.of(context).translate('label_intro_3'),
        styleDescription: TextStyle(
          color: Colors.grey[200],
          fontSize: 22.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600
        ),
        backgroundColor: Colors.deepPurpleAccent[700],
        pathImage: 'assets/dashboard.png'
      )
    );


    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.deepOrangeAccent[400].withOpacity(0.5),
      highlightColorSkipBtn: Colors.deepOrangeAccent,
      

      // Next button
      renderNextBtn: this.renderNextBtn(),
  

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.deepOrangeAccent[400].withOpacity(0.5),
      highlightColorDoneBtn: Colors.deepOrangeAccent,

      // Dot indicator
      colorDot: Colors.deepOrangeAccent[100],
      colorActiveDot: Colors.deepOrangeAccent,
      sizeDot: 8.0,
      typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,

      // // Tabs
      // listCustomTabs: renderListCustomTabs(),
      // refFuncGoToTab: (refFunc) {
      //   goToTab = refFunc;
      // },

      // Show or hide status bar
      shouldHideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
      //  // On tab change completed
      // onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}

