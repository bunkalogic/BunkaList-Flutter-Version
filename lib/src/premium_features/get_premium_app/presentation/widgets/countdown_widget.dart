import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountDownFinishOfferWidget extends StatefulWidget {
  CountDownFinishOfferWidget({Key key}) : super(key: key);

  @override
  _CountDownFinishOfferWidgetState createState() => _CountDownFinishOfferWidgetState();
}

class _CountDownFinishOfferWidgetState extends State<CountDownFinishOfferWidget> {
  
  CountdownTimerController controller;
  int endTime = DateTime.parse("2021-03-11 00:00:00").millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.symmetric(
         vertical: 20.0,
         horizontal: 40.0
       ), 
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), 
        color: Colors.blueGrey[400].withOpacity(0.2),
       ),
       
       child: Column(
         children: [
           Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0
        ),
        child: Text(
          '50% OFF', // AppLocalizations.of(context).translate("label_offer"),
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.pinkAccent[400],
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
            fontSize: 18.0
          ),
        
        ),
      ),
       Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0
        ),
        child: Text(
         AppLocalizations.of(context).translate("label_offer_finish"),
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 14.0
          ),
        
        ),
      ),
           CountdownTimer(
             onEnd: onEnd,
             endTime: endTime,
             controller: controller,
             textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            //  widgetBuilder: (context, time) {
            //    return Center(
            //      child: Text(
            //        '${time.days ?? 00} : ${time.hours ?? 00} : ${time.min} : ${time.sec ?? 00}',
            //        style: TextStyle(
            //          fontSize: 20.0,
            //          fontWeight: FontWeight.bold,
            //        ),
            //       ),
                 
            //    );
            //  },
           ),
           SizedBox(height: 15.0,)
         ],
       )
            
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}