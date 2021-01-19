import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:bunkalist/src/core/reusable_widgets/empty_label_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/icon_empty_widget.dart';
import 'package:bunkalist/src/core/reusable_widgets/loading_custom_widget.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_reviews/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsReviewTab extends StatefulWidget {

  final int id;
  final String type;

  AllDetailsReviewTab({@required this.id, @required this.type});


  @override
  _AllDetailsReviewTabState createState() => _AllDetailsReviewTabState();
}

class _AllDetailsReviewTabState extends State<AllDetailsReviewTab> {
  
  


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ReviewsBloc>(context)
    ..add(GetDetailsReviews(widget.id, widget.type));
    
  }  
  
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (context, state) {
          
          if(state is Empty){

            return LoadingCustomWidget();

          }else if(state is Loading){
            
            return LoadingCustomWidget();

          }else if(state is Loaded){

            if(state.reviews.isEmpty || state.reviews.length < 0){
              
              return EmptyLabelIconWidget(
                icon: Icons.announcement_rounded,
                label: AppLocalizations.of(context).translate("label_review_empty"),
              );

            }else{
              return ListView.builder(
                itemCount: state.reviews.length,
                itemBuilder: (context, i) => _createItemReview(state.reviews[i]),
              );
            }
            
          }else if(state is Error){
            
            return EmptyIconWidget();
          }

          return EmptyIconWidget();

        },
      ),
    );
    
  }

  Widget _createItemReview(ReviewEntity reviewItem) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: _columnItemReview(reviewItem),
    );
  }

  Widget _columnItemReview(ReviewEntity reviewItem) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _rowUserInfo(reviewItem),
          _commentReview(reviewItem)
        ],
      ),
    );
  }

  Widget _rowUserInfo(ReviewEntity reviewItem) {
    return Container(
      child: Row(
        children: <Widget>[
          _avatarUser(),
          _usernameInfo(reviewItem),
          //Spacer(),
          //_dateInfo()
        ],
      ),
    );
  }

  Widget _avatarUser() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(          
        radius: 24.0,
        backgroundImage: AssetImage('assets/api-logo.png'),
      ),
    );
  }

  Widget _usernameInfo(ReviewEntity reviewItem) {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Text(
        reviewItem.author,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget _commentReview(ReviewEntity reviewItem) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Text(
        reviewItem.content,
        textAlign: TextAlign.justify,
      ),
    );
  }
}