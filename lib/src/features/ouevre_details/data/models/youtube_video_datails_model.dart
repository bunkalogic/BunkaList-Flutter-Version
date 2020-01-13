import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';

class VideoYoutubeModel extends VideoYoutubeEntity{


  VideoYoutubeModel({
    @required  String id,
    @required  String title,
    @required  String thumbnailUrl,
    @required  String channelTitle,
    @required  String publishedAt,
  }) : super (
    id           : id,
    title        : title,
    thumbnailUrl : thumbnailUrl,
    channelTitle : channelTitle,
    publishedAt  : publishedAt
  );

  factory VideoYoutubeModel.fromJson(Map<String, dynamic> snippet){
      return VideoYoutubeModel(
      id            : snippet['id']['videoId'],
      title         : snippet['snippet']['title'],
      thumbnailUrl  : snippet['snippet']['thumbnails']['high']['url'],
      channelTitle  : snippet['snippet']['channelTitle'],
      publishedAt   : snippet['snippet']['publishedAt'] 
    );
  }

}

class ListVideosYoutube{

  List<VideoYoutubeModel> items = new List();

  ListVideosYoutube();

  ListVideosYoutube.fromJsonList(List<dynamic> jsonList){

    if(jsonList == null) return;

    for(var item in jsonList){
      final video  = new VideoYoutubeModel.fromJson(item);

      items.add(video);
    }
  }

  
}