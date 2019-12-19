

import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/review_details_entity.dart';


class ReviewModel extends ReviewEntity{

    ReviewModel({
    @required String author,
    @required String content,
    @required String id,
    @required String url,
    }) : super(
        author  : author, 
        content : content,
        id      : id,
        url     : url,
    );


    factory ReviewModel.fromJson(Map<String, dynamic> json){
      return ReviewModel(
          author  : json['author'], 
          content : json['content'],
          id      : json['id'],
          url     : json['url'],
      );
    }

    Map<String, dynamic> toJson(){
      return{
        'author ' : author, 
        'content' : content,
        'id     ' : id,
        'url    ' : url,
      };
    } 
}

class Reviews{
  
  List<ReviewModel> items = new List();
  
  Reviews();

  Reviews.fromJsonList(List<dynamic> jsonList){

    if(jsonList == null) return;

    for(var item in jsonList){
      final review  = new ReviewModel.fromJson(item);

      items.add(review);
    }

  }
}