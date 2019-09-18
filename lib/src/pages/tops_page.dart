import 'package:bunkalist/src/widgets/banner_premium_widget.dart';
import 'package:bunkalist/src/widgets/card_scroll_widget.dart';
import 'package:bunkalist/src/widgets/tops_scrollview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';



class TopsPage extends StatefulWidget {
  TopsPage({Key key}) : super(key: key);

  _TopsPageState createState() => _TopsPageState();
}

class _TopsPageState extends State<TopsPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _createScrollPagePlatform(context),
    );
  }

  

  
  
  //!  Common Components (Android & iOS)

  Widget _createScrollPagePlatform(BuildContext context) {
    return PlatformWidget(
      android: (context) => _listTopsMaterial(),
      ios: (context) => _listTopsCupertino(),
    );
  }

  Widget titleListTop(String title){
    return ListTile(
      onTap: () {},
      title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      trailing: Text('More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800], fontSize: 16.0 ),),
    );
  }

  //! Material Components (Android)

  Widget _listTopsMaterial() {
    return ListView(
      children: <Widget>[
        //* banner de Ads
        SizedBox(height: 10.0,),
        CardScrollWidget(),
        titleListTop('Top Popular Movies:'),
        TopsScrollView(),
        //SizedBox(height: 5.0,),
        titleListTop('Top Best Rated Movies:'),
        TopsScrollView(),
        //SizedBox(height: 5.0,),
        titleListTop('Top Popular Series Tv:'),
        TopsScrollView(),
        SizedBox(height: 15.0,),
        BannerPremiumWidget(),
        SizedBox(height: 15.0,),
        titleListTop('Top Best Rated Series Tv:'),
        TopsScrollView(),
        SizedBox(height: 5.0,),
        titleListTop('Top Popular Anime:'),
        TopsScrollView(),

      ],
    );
  }
  
  //! Cupertino Components (iOS)

  _listTopsCupertino() {

  }


  
}