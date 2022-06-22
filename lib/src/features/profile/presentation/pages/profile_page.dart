

import 'package:bunkalist/injection_container.dart';
import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/preferences/shared_preferences.dart';
import 'package:bunkalist/src/core/reusable_widgets/container_ads_widget.dart';
import 'package:bunkalist/src/core/theme/get_background_color.dart';
import 'package:bunkalist/src/core/utils/get_random_number.dart';
import 'package:bunkalist/src/core/utils/in_app_review_util.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/circular_chart_media_rating_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/circular_chart_total_views.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/last_added_item_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_bar_plan_to_see_list_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_bar_to_recent_add_list_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/tab_bar_watching_list_widget.dart';
import 'package:bunkalist/src/features/profile/presentation/widgets/total_views_container_widget.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/container_top_empty_widget.dart';
import 'package:bunkalist/src/features/tops_favorites/presentation/widgets/stacked_cards_widget.dart';
import 'package:bunkalist/src/premium_features/get_premium_app/presentation/widgets/banner_premium_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Preferences prefs = new Preferences();
  //final _controller = NativeAdmobController();

  @override
  void initState() {
    super.initState();

    prefs.totalVisitProfile += 1;
    print('visit profile for ${prefs.totalVisitProfile}');

    getInAppReview();

    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createProfileDesign(context),
    );
  }
  
  
  //!  Common Components (Android & iOS)

  Widget _createProfileDesign(BuildContext context) {
    return _profileDesignMaterial(context);
  }

  Widget _createBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 12.0
      ),
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(   
            child: _infoProfileBox(),
            height: 150.0,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15.0),
            //   color: getBackgroundColorItemTheme()
            // ),
          ),
      ),
    );
  }

  Widget _infoProfileBox() {
     return Container(
      //  padding: EdgeInsets.all(1.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
          //  _profileImage(),
          //  _profileName(),
           SizedBox(height: 8.0,),
            _profileRateAverage(),
           
           SizedBox(height: 8.0,),
          //  _labelProfileRateAverage(),
          _profileTotalViews(),
           SizedBox(height: 8.0,),
         ],
       ),
     );
   }

  Widget _profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: 65.0,
        height: 65.0,
        child: CircleAvatar(
          backgroundImage: NetworkImage(prefs.getCurrentUserPhoto),
        )
      ),
    );
  }

  Widget _profileName() {
    return Text(prefs.getCurrentUsername, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), );
  }

  Widget _profileTotalViews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: TotalViewsWidget(status: ListProfileQuery.Total, type: 'movie',),
          ),
        new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child: TotalViewsWidget(status: ListProfileQuery.Total, type: 'tv',),
        ),
        new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child: TotalViewsWidget(status: ListProfileQuery.Total, type: 'anime',),
        ),
      ],
    );
  }

  Widget _labelProfileRateAverage(){
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        AppLocalizations.of(context).translate("label_media_lists"),
        textAlign: TextAlign.center,
        style: TextStyle(
        fontSize: 14.0, 
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic
      ),
      ),
    );
  }

  Widget _profileRateAverage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: Expanded(child: MediaRatingWidget(status: ListProfileQuery.Completed, type: 'movie',), flex: 1,),
          ),
        new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child: Expanded(child: MediaRatingWidget(status: ListProfileQuery.Completed, type: 'tv',), flex: 1,),
        ),
        new BlocProvider<GetListsBloc>(
          create: (_) => serviceLocator<GetListsBloc>(),
          child: Expanded(child: MediaRatingWidget(status: ListProfileQuery.Completed, type: 'anime',), flex: 1,),
        ),
      ],
    );
  }

  

  Widget _titleScrollSection(String title) {
    return Container(
      padding: EdgeInsets.only(left: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,),
      ),
    );
  }

  

  Widget _buttomPlatformList(BuildContext context){
    return _buttonsTypeListMaterial(context);
  }
  


  //! Material Components (Android)

  Widget _profileDesignMaterial(BuildContext context) {
    bool random = randomAdsOrBanner();

    return ListView(
      //padding: EdgeInsets.all(5.0),
      children: <Widget>[
        SizedBox(height: 10.0,),
        _buttomPlatformList(context),
        _createBox(),
        SizedBox(height: 10.0,),
        ListContainerChartViews(),
        MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/1841263070', ),
        SizedBox(height: 10.0,),
        _buildBodyTopsFavorites()
        // TabBarWatchingAddedToListsWidget(),     
        // // SizedBox(height: 10.0,),
        // TabBarRecentAddedToListsWidget(),
        // MiniContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/5588936395', ),
        // TabBarPlanToWatchAddedToListsWidget(),
        // BannerPremiumWidget(),
        // SizedBox(height: 20.0,),    
      ],
    );
  }

  Widget _buttonsTypeListMaterial(BuildContext context){ 
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buttonTypeMaterial(context, AppLocalizations.of(context).translate("list_movies"), Colors.redAccent[400], 0),
        SizedBox(width: 10.0,),
        _buttonTypeMaterial(context,  AppLocalizations.of(context).translate("list_series"), Colors.greenAccent[400], 1),
        SizedBox(width: 10.0,),
        _buttonTypeMaterial(context,  AppLocalizations.of(context).translate("list_animes"), Colors.lightBlueAccent[400], 2),
      ],
    );
  }

  Widget _buttonTypeMaterial(BuildContext context,String title, Color color, int type) {
      return Flexible(
        // ignore: deprecated_member_use
        child: RaisedButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title,
            overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/ListProfile', arguments: type);
          },
        ),
      );
  }
  

  Widget _buildBodyTopsFavorites() { 

    return Column(
      children: [
        // _labelFavorites(AppLocalizations.of(context).translate("title_top_movie"),),
        // dashed container
        new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: BuildSatckedCardTopFavorites(type: 'movie',),
          ),
        
        // _labelFavorites(AppLocalizations.of(context).translate("title_top_serie"),),
        // dashed container
        new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: BuildSatckedCardTopFavorites(type: 'tv',),
          ),
          BigContainerAdsWidget(adUnitID: 'ca-app-pub-6667428027256827/3234817637',),
        // _labelFavorites(AppLocalizations.of(context).translate("title_top_anime"),),
        // dashed container
         new BlocProvider<GetListsBloc>(
            create: (_) => serviceLocator<GetListsBloc>(),
            child: BuildSatckedCardTopFavorites(type: 'anime',),
          ),
        // dashed container working in new features for create tops
        // Divider(color: Colors.grey,),
        SizedBox(height: 10.0,),
        BannerPremiumWidget(),
        
        // ContainerTopEmptyWidget(
        //   labelTitle: AppLocalizations.of(context).translate("title_working_feature"),
        //   label: AppLocalizations.of(context).translate("subtitle_working_feature"), 
        //   dottedColor: Colors.pinkAccent[400],
        //   icon: Icons.build_rounded,
        //   onTap: null
        // ), 
      ],
    );
  }

  // Widget _labelFavorites(String title) {

  //   return ListTile(
  //     onTap: (){

  //       Navigator.pushNamed(context, '/TopFavDetails', arguments: widget.ouevreList);

  //     },
  //     title: Text(
  //       title,
  //       style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  //     ),
      
  //     trailing: Icon(
  //       Icons.chevron_right_rounded,
  //       color: prefs.whatModeIs ? Colors.pinkAccent[400] : Colors.deepPurpleAccent[400],
  //       size: 28,
  //     ),
  //   );

    
  // }



  

  // //! Cupertino Components (iOS)

  // Widget _profileDesignCupertino(BuildContext context) {
  //   return ListView(
  //     padding: EdgeInsets.all(5.0),
  //     children: <Widget>[
  //       _createBox(),
  //       SizedBox(height: 5.0,),
  //       _buttomPlatformList(context),
  //       SizedBox(height: 20.0,),
  //       _titleScrollSection('The last views of Movies :'),
  //       SizedBox(height: 5.0,),
  //       new BlocProvider<GetListsBloc>(
  //           create: (_) => serviceLocator<GetListsBloc>(),
  //           child: LastAddedItem(status: ListProfileQuery.Last, type: 'movie',),
  //         ),
  //       _titleScrollSection('The last views of Series :'),
  //       SizedBox(height: 10.0,),
  //       new BlocProvider<GetListsBloc>(
  //           create: (_) => serviceLocator<GetListsBloc>(),
  //           child: LastAddedItem(status: ListProfileQuery.Last, type: 'tv',),
  //         ),
  //       _titleScrollSection('The last views of Animes :'),
  //       SizedBox(height: 10.0,),
  //       new BlocProvider<GetListsBloc>(
  //           create: (_) => serviceLocator<GetListsBloc>(),
  //           child: LastAddedItem(status: ListProfileQuery.Last, type: 'anime',),
  //         ),
  //     ],
  //   );
  // }

  // _buttonsTypeListCupertino(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       _buttonTypeCupertino('List Movies', Colors.redAccent, 0, context),
  //       SizedBox(width: 10.0,),
  //       _buttonTypeCupertino('List Series TV', Colors.greenAccent[400], 1, context),
  //       SizedBox(width: 10.0,),
  //       _buttonTypeCupertino('List Anime', Colors.lightBlueAccent, 2, context),
  //     ],
  //   );
  // }

  // Widget _buttonTypeCupertino(String title, Color color,  int type, BuildContext context) {
  //     return CupertinoButton(
  //       borderRadius: BorderRadius.circular(4.0),
  //       color: color,
  //       child: Text(title, style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),
  //       onPressed: (){
          
  //         Navigator.pushNamed(context, '/ListProfile', arguments: type);
  //       },
  //     );
  // }

  
  

  

  

 

  
}