
import 'package:bunkalist/src/core/reusable_widgets/tops_scrollview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: _createProfileDesign(context),
    );
  }
  
  
  //!  Common Components (Android & iOS)

  Widget _createProfileDesign(BuildContext context) {
    return PlatformWidget(
      android: (context) => _profileDesignMaterial(context),
      ios: (context) => _profileDesignCupertino(context),
    );
  }

  Widget _createBox() {
        //! posible cambio por un card para ponerle elevation
    return Container(   
        child:  _infoProfileBox(),
        height: 240.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey[800].withOpacity(0.4),
              Colors.blueGrey[700].withOpacity(0.5),
              Colors.blueGrey[600].withOpacity(0.7),
              Colors.blueGrey[500].withOpacity(0.9)
            ]
          ) 
        ),
      );
  }

  Widget _infoProfileBox() {
     return Container(
       padding: EdgeInsets.all(15.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           _profileImage(),
           _profileName(),
           SizedBox(height: 10.0,),
           _profileViews(),
           SizedBox(height: 8.0,),
           _profileViews(),
           SizedBox(height: 8.0,),
           _itemTotalTimeView()
           
         ],
       ),
     );
   }

  Widget _profileImage() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: CircleAvatar(
        backgroundImage: NetworkImage('https://avatarfiles.alphacoders.com/175/175534.jpg'),
      )
    );
  }

  Widget _profileName() {
    return Text('Username', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold), );
  }

  Widget _profileViews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _itemViews(),
        SizedBox(width: 40.0,),
        _itemViews(),
      ],
    );
  }

  Widget _itemViews() {
    return Text('Movies views: 124', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),);
  }

  Widget _itemTotalTimeView() {
    return Text('total time views: 14 day and 12 hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),);
  }

  Widget _titleScrollSection(String title) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      ),
    );
  }

  // TODO: cambiar cuando se agregue la parte de Firebase
  Widget _scrollViewsExample(){
    return TopsScrollView();
  }

  Widget _buttomPlatformList(BuildContext context){
    return PlatformWidget(
        android: (context) => _buttonsTypeListMaterial(),
        ios: (context) => _buttonsTypeListCupertino(),
    );
  }
  

  //! Material Components (Android)

  Widget _profileDesignMaterial(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: <Widget>[
        _createBox(),
        SizedBox(height: 5.0,),
        _buttomPlatformList(context),
        SizedBox(height: 20.0,),
        _titleScrollSection('The last views :'),
        SizedBox(height: 10.0,),
        _scrollViewsExample(),
        //SizedBox(height: 1.0,),
        _titleScrollSection('The list watching :'),
        SizedBox(height: 10.0,),
        _scrollViewsExample(),
        //SizedBox(height: 1.0,),
        _titleScrollSection('The list awaiting :'),
        SizedBox(height: 10.0,),
        _scrollViewsExample(),
       // SizedBox(height: 2.0,),
      ],
    );
  }

  Widget _buttonsTypeListMaterial(){ 
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buttonTypeMaterial('List Movies', Colors.redAccent),
        SizedBox(width: 10.0,),
        _buttonTypeMaterial('List Series TV', Colors.greenAccent[400]),
        SizedBox(width: 10.0,),
        _buttonTypeMaterial('List Anime', Colors.lightBlueAccent),
      ],
    );
  }

  Widget _buttonTypeMaterial(String title, Color color) {
      return RaisedButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: color,
        child: Text(title, style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),
        onPressed: (){
          //? pushNamed con los arguments con el numberType de la firestore
          // movies == 0
          // series == 1
          // anime == 2
        },
      );
  }
  

  //! Cupertino Components (iOS)

  Widget _profileDesignCupertino(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: <Widget>[
        _createBox(),
        SizedBox(height: 5.0,),
        _buttomPlatformList(context),
        SizedBox(height: 20.0,),
        _titleScrollSection('The last views :'),
        SizedBox(height: 10.0,),
        _scrollViewsExample(),
        //SizedBox(height: 1.0,),
        _titleScrollSection('The list watching :'),
        SizedBox(height: 10.0,),
        _scrollViewsExample(),
        //SizedBox(height: 1.0,),
        _titleScrollSection('The list awaiting :'),
        SizedBox(height: 10.0,),
        _scrollViewsExample(),
       // SizedBox(height: 2.0,),
      ],
    );
  }

  _buttonsTypeListCupertino() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buttonTypeCupertino('List Movies', Colors.redAccent),
        SizedBox(width: 10.0,),
        _buttonTypeCupertino('List Series TV', Colors.greenAccent[400]),
        SizedBox(width: 10.0,),
        _buttonTypeCupertino('List Anime', Colors.lightBlueAccent),
      ],
    );
  }

  Widget _buttonTypeCupertino(String title, Color color) {
      return CupertinoButton(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
        child: Text(title, style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)),
        onPressed: (){
          //? pushNamed con los arguments con el numberType de la firestore
          // movies == 0
          // series == 1
          // anime == 2
        },
      );
  }

  
  

  

  

 

  
}