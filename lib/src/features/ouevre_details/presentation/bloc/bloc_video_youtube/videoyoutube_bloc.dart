import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bunkalist/src/core/error/failures.dart';
import 'package:bunkalist/src/core/utils/get_validate_query.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/youtube_video_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_videos_youtube_details.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Query';

class VideoYoutubeBloc extends Bloc<VideoYoutubeEvent, VideoYoutubeState> {
  
  final GetListVideosYoutube getListVideosYoutube;

  VideoYoutubeBloc({
    @required GetListVideosYoutube videosYoutube 
    }) : 
    assert(videosYoutube != null),
    getListVideosYoutube = videosYoutube;
  
  
  @override
  VideoYoutubeState get initialState => Empty();

  @override
  Stream<VideoYoutubeState> mapEventToState(
    VideoYoutubeEvent event,
  ) async* {
    if(event is GetTrailersVideos){
        final queryFinal = '${event.query} Trailer';
        final inputEither = GetValidateQuery().getValidateQuery(queryFinal);

       yield* inputEither.fold(
         (failures) async*{

         yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);  

       },(query) async*{

         yield Loading();

         final failureOrVideo = await getListVideosYoutube( Params(query: query));

         yield* _eitherLoadedOrErrorState(failureOrVideo); 

       });

    }else if(event is GetReviewsVideos){

      final queryFinal = '${event.query} Review';
      final inputEither = GetValidateQuery().getValidateQuery(queryFinal);

       yield* inputEither.fold(
         (failures) async*{

         yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);  

       },(query) async*{

         yield Loading();

         final failureOrVideo = await getListVideosYoutube( Params(query: query));

         yield* _eitherLoadedOrErrorState(failureOrVideo); 

       });

    }else if(event is GetOpenningVideos){

      final queryFinal = '${event.query} Oppenings';
      final inputEither = GetValidateQuery().getValidateQuery(queryFinal);

       yield* inputEither.fold(
         (failures) async*{

         yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);  

       },(query) async*{

         yield Loading();

         final failureOrVideo = await getListVideosYoutube( Params(query: query));

         yield* _eitherLoadedOrErrorState(failureOrVideo); 

       });

    }
  }

  Stream<VideoYoutubeState> _eitherLoadedOrErrorState
  (Either<Failures, List<VideoYoutubeEntity>> either) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (video) => Loaded(videos: video)
    );
  }

   String _mapFailureToMessage(Failures failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
