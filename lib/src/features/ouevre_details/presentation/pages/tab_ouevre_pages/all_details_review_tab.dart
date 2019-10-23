import 'package:flutter/material.dart';

class AllDetailsReviewTab extends StatelessWidget {
  const AllDetailsReviewTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, i) => _createItemReview(),
    );
  }

  Widget _createItemReview() {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: _columnItemReview(),
    );
  }

  Widget _columnItemReview() {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _rowUserInfo(),
          _commentReview()
        ],
      ),
    );
  }

  Widget _rowUserInfo() {
    return Container(
      child: Row(
        children: <Widget>[
          _avatarUser(),
          _usernameInfo(),
          Spacer(),
          _dateInfo()
        ],
      ),
    );
  }

  Widget _avatarUser() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(          
        radius: 22.0,
        backgroundImage: NetworkImage('https://avatarfiles.alphacoders.com/187/187187.png'),
      ),
    );
  }

  Widget _usernameInfo() {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Text(
        'Username',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget _dateInfo() {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Text(
        '4 days ago',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500
        ),
      ),
    ); 
  }

  Widget _commentReview() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Text(
        'Non esse minim nisi irure minim officia labore exercitation ad Lorem pariatur in. Ipsum est amet eu nulla sunt velit. Culpa consequat eu adipisicing minim aute. Enim velit sunt aliquip est est non est ex.',
        textAlign: TextAlign.justify,
      ),
    );
  }
}