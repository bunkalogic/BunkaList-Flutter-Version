import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_anime_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_movie_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_series_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/anime_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/movie_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/series_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/anime_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/serie_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_anime.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_movies.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/tops_series_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/tops_animes_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/tops_movies_bloc.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_auth_remote_data_source.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_auth_token_remote_data_source.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_auth_with_google_remote_data_source.dart';
import 'package:bunkalist/src/features/login/data/datasources/user_register_remote_data_source.dart';
import 'package:bunkalist/src/features/login/data/implementations/user_auth_impl.dart';
import 'package:bunkalist/src/features/login/data/implementations/user_auth_token_impl.dart';
import 'package:bunkalist/src/features/login/data/implementations/user_auth_with_google_impl.dart';
import 'package:bunkalist/src/features/login/data/implementations/user_register_impl.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_contract.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_token_contract.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_auth_with_google_contract.dart';
import 'package:bunkalist/src/features/login/domain/contracts/user_register_auth_contract.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_auth_with_google.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_delete_token.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_has_token.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_persist_token.dart';
import 'package:bunkalist/src/features/login/domain/usescases/get_user_register.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/credits_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_credits_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_social_media_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/review_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/season_info_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/serie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/video_youtube_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/credits_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/people_credits_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/people_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/people_social_media_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/review_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/season_info_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/youtube_video_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details.rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/credits_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/get_season_info_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_rec_sim_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_credits_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_social_media_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/review_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/video_youtube_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_credits_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_recommedation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_credits.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_people_social_media.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_review_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_season_info_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_recommendations.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_videos_youtube_details.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_credits/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_people/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_recommendations/recommendations_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_reviews/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_season_info/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_similar/similar_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_video_youtube/bloc.dart';
import 'package:bunkalist/src/features/profile/data/datasources/crud_ouevre_remote_data_source.dart';
import 'package:bunkalist/src/features/profile/data/implementations/add_ouevre_impl.dart';
import 'package:bunkalist/src/features/profile/data/implementations/delete_ouevre_impl.dart';
import 'package:bunkalist/src/features/profile/data/implementations/get_ouevre_impl.dart';
import 'package:bunkalist/src/features/profile/data/implementations/update_ouevre_impl.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/add_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/delete_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/get_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/update_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_add_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_delete_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_get_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_update_ouevre.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_delete/bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_update/update_bloc.dart';
import 'package:bunkalist/src/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:bunkalist/src/features/search/data/implementations/search_result_impl.dart';
import 'package:bunkalist/src/features/search/domain/contracts/search_result_contract.dart';
import 'package:bunkalist/src/features/search/domain/usescases/get_search.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'src/features/login/presentation/bloc/bloc_auth/bloc.dart';
import 'src/features/login/presentation/bloc/bloc_login/bloc.dart';
import 'src/features/ouevre_details/data/datasources/serie_details_remote_data_source.dart';
import 'src/features/search/presentation/bloc/bloc.dart';


import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Home Tops Features
  initTopsMovies();
  initTopsSeries();
  initTopsAnime();
  //! Ouevre Details Features
  initOuevreDetails();
  //! Search Features
  initSearch();
  initLogin();
  //! Profile Features
  initProfile();
  
  //? Core

  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  //? External

  

  serviceLocator.registerLazySingleton(() => http.Client());

  serviceLocator.registerLazySingleton(() => DataConnectionChecker());







  // //? Blocs
  // serviceLocator.registerLazySingleton(
  //   () => TopsMoviesBloc(
  //     movies: serviceLocator(),
  //     ),
  //   );  

  // serviceLocator.registerLazySingleton(
  //   () => TopsSeriesBloc(
  //     series: serviceLocator()
  //   ),
  // );
  // serviceLocator.registerLazySingleton(
  //   () => TopsAnimesBloc(
  //     animes: serviceLocator()
  //     )
  //   );
  // //?UsesCases
  // serviceLocator.registerLazySingleton(() => GetTopsMovies(serviceLocator()));
  // serviceLocator.registerLazySingleton(() => GetTopsSeries(serviceLocator()));
  // serviceLocator.registerLazySingleton(() => GetTopsAnime(serviceLocator()));

  // //? Repository - Contracts
  // serviceLocator.registerLazySingleton<MovieTopsRepository>(
  //   () => MovieTopsRepositoryImpl(
  //     remoteDataSource: serviceLocator(),
  //     networkInfo: serviceLocator()
  //     ),
  //   );
  // serviceLocator.registerLazySingleton<SeriesTopsRepository>(
  //   () => SeriesTopRepositoryImpl(
  //     remoteDataSource: serviceLocator(),
  //     networkInfo: serviceLocator()
  //     ),
  //   );
  // serviceLocator.registerLazySingleton<AnimeTopsRepository>(
  //   () => AnimeTopRepositoryImpl(
  //     remoteDataSource: serviceLocator(),
  //     networkInfo: serviceLocator()
  //     ),
  //   );

  // //? Data Sources
  // serviceLocator.registerLazySingleton<TopsMovieRemoteDataSource>(
  //   () => TopsMoviesRemoteDataSourceImpl(client: serviceLocator())
  // );

  // serviceLocator.registerLazySingleton<TopsSeriesRemoteDataSource>(
  //   () => TopsSeriesRemoteDataSourceImpl(client: serviceLocator())
  // );

  // serviceLocator.registerLazySingleton<TopsAnimeRemoteDataSource>(
  //   () => TopsAnimeRemoteDataSourceImpl(client: serviceLocator())
  // );

  // //? Core

  // serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  // //? External

  

  // serviceLocator.registerLazySingleton(() => http.Client());

  // serviceLocator.registerLazySingleton(() => DataConnectionChecker());

}

initTopsMovies(){
  //? BLoc
  serviceLocator.registerFactory(
    () => TopsMoviesBloc(
      movies: serviceLocator(),
      ),
    ); 
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetTopsMovies(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<MovieTopsRepository>(
    () => MovieTopsRepositoryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<TopsMovieRemoteDataSource>(
    () => TopsMoviesRemoteDataSourceImpl(client: serviceLocator())
  );  
  
}


initTopsSeries(){
  //? Blocs
  serviceLocator.registerFactory(
    () => TopsSeriesBloc(
      series: serviceLocator()
    ),
  );
  //? UseCases
  serviceLocator.registerLazySingleton(() => GetTopsSeries(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<SeriesTopsRepository>(
    () => SeriesTopRepositoryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    );
  //? Data Sources
  serviceLocator.registerLazySingleton<TopsSeriesRemoteDataSource>(
    () => TopsSeriesRemoteDataSourceImpl(client: serviceLocator())
  );
  
}


initTopsAnime(){
  //? Blocs
  serviceLocator.registerFactory(
    () => TopsAnimesBloc(
      animes: serviceLocator()
      )
    );
  //? UseCases
  serviceLocator.registerLazySingleton(() => GetTopsAnime(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<AnimeTopsRepository>(
    () => AnimeTopRepositoryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    );

  //? Data Sources
  serviceLocator.registerLazySingleton<TopsAnimeRemoteDataSource>(
    () => TopsAnimeRemoteDataSourceImpl(client: serviceLocator())
  );

  
}


initSearch(){
  //? Blocs
  serviceLocator.registerFactory(
    () => SearchBloc(
      search: serviceLocator()
      )
    );
  //? UseCases
  serviceLocator.registerLazySingleton(() => GetSearch(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<SearchResultContract>(
    () => SearchResultImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    );

  //? Data Sources
  serviceLocator.registerLazySingleton<SearchResultRemoteDataSource>(
    () => SearchResultRemoteDataSourceImpl(client: serviceLocator())
  );
}

initLogin(){
  //? Blocs
  serviceLocator.registerFactory(
    () => AuthenticationBloc(
      hasToken: serviceLocator(),
      deleteToken: serviceLocator(),
      persistToken: serviceLocator()
      )
    );

  serviceLocator.registerFactory(
    () => LoginBloc(
      authBloc: serviceLocator(),
      userAuth: serviceLocator(),
      userRegister: serviceLocator(),
      googleAuth: serviceLocator(),
      )
    );

  //? UseCases
  serviceLocator.registerLazySingleton(() => GetUserRegister(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserAuth(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserHasToken(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserDeleteToken(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserPersistToken(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserWithGoogleAuth(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<UserEmailAuthContract>(
    () => UserEmailAuthImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

  serviceLocator.registerLazySingleton<UserAuthTokenContracts>(
    () => UserAuthTokenImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

  serviceLocator.registerLazySingleton<UserRegisterContract>(
    () => UserRegisterImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

    serviceLocator.registerLazySingleton<UserWithGoogleAuthContract>(
    () => UserWithGoogleAuthImpl(
      remoteDataSource: serviceLocator(),
      ),
    );  


  //? Data Sources
  serviceLocator.registerLazySingleton<UserAuthRemoteDataSource>(
    () => UserAuthRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );

  serviceLocator.registerLazySingleton<UserAuthTokenRemoteDataSource>(
    () => UserAuthTokenRemoteDataSourceImpl()
  );

  serviceLocator.registerLazySingleton<UserRegisterRemoteDataSource>(
    () => UserRegisterRemoteDataSourceImpl()
  );
  serviceLocator.registerLazySingleton<UserWithGoogleAuthRemoteDataSource>(
    () => UserWithGoogleAuthRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );

}



initProfile(){
  //? Blocs
  serviceLocator.registerFactory(
    () => AddOuevreBloc(
      addOuevre: serviceLocator()
      )
    );

  serviceLocator.registerFactory(
    () => DeleteBloc(
      deleteOuevre: serviceLocator()
      )
    );

  serviceLocator.registerFactory(
    () => UpdateBloc(
      updateOuevre: serviceLocator()
      )
    );

  serviceLocator.registerFactory(
    () => GetListsBloc(
      allOuevre: serviceLocator()
      )
    );      

  

  //? UseCases
  serviceLocator.registerLazySingleton(() => GetAllOuevre(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAddOuevre(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetDeleteOuevre(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUpdateOuevre(serviceLocator()));
  
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<GetOuevreContract>(
    () => GetOuevreImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

  serviceLocator.registerLazySingleton<AddOuevreContract>(
    () => AddOuevreImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

  serviceLocator.registerLazySingleton<UpdateOuevreContract>(
    () => UpdateOuevreImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

    serviceLocator.registerLazySingleton<DeleteOuevreContract>(
    () => DeleteOuevreImpl(
      remoteDataSource: serviceLocator(),
      ),
    );  


  //? Data Sources
  serviceLocator.registerLazySingleton<CrudOuevreRemoteDataSource>(
    () => CrudOuevreRemoteDataSourceImpl()
  );

}

initOuevreDetails(){
  //? BLoc
  serviceLocator.registerFactory(
    () => OuevreDetailsBloc(
      movie: serviceLocator(),
      serie: serviceLocator(),
      anime: serviceLocator()
      ),
    );
    
  serviceLocator.registerFactory(
      () => ReviewsBloc(
        reviews: serviceLocator()
      ),
    ); 

  serviceLocator.registerFactory(
      () => CreditsBloc(
        credits: serviceLocator()
      ),
    );

  serviceLocator.registerFactory(
    () => RecommendationsBloc(
      moviesRecom: serviceLocator(),
      seriesRecom: serviceLocator(),
      animeRecom: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SimilarBloc(
      moviesSimilar: serviceLocator(),
      seriesSimilar: serviceLocator(),
      animeSimilar: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => VideoYoutubeBloc(
      videosYoutube: serviceLocator()
    ),
  ); 

  serviceLocator.registerFactory(
    () => SeasonInfoBloc(
      episodes: serviceLocator()
      ),
  );

  serviceLocator.registerFactory(
    () => PeopleInfoBloc(
      peopleCredits: serviceLocator(),
      peopleDetails: serviceLocator(),
      peopleSocialMedia: serviceLocator()
    ),
  ); 

  //? Init MoviesDetails, SeriesDetails, AnimeDetails, ReviewDetails, CreditsDetails, RecomAndSimilarDetails, VideoYoutubeDetails
  initMovieDetails();
  initSerieDetails();
  initAnimeDetails();
  initReviewsDetails();
  initCreditsDetails();
  initMovieRecomAndSimilarDetails();
  initSerieRecomAndSimilarDetails();
  initAnimeRecomAndSimilarDetails();
  initVideoYoutubeDetails();
  initSeasonInfo();
  initPeopleDetails();
  initPeopleSocialMedia();
  initPeopleCredits();
  
}



initMovieDetails(){
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetMovieDetails(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<MovieDetailsContract>(
    () => MovieDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<MovieDetailsRemoteDataSource>(
    () => MovieDetailsRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initSerieDetails(){
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetSerieDetails(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<SerieDetailsContract>(
    () => SerieDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<SerieDetailsRemoteDataSource>(
    () => SerieDetailsRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initAnimeDetails(){
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetAnimeDetails(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<AnimeDetailsContract>(
    () => AnimeDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<AnimeDetailsRemoteDataSource>(
    () => AnimeDetailsRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initReviewsDetails(){
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetReviewDetails(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<ReviewDetailsContracts>(
    () => ReviewDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<ReviewDetailsRemoteDataSource>(
    () => ReviewDetailsRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initCreditsDetails(){
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetCreditsDetails(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<CreditsDetailsContract>(
    () => CreditsDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<CreditsDetailsRemoteDataSource>(
    () => CreditsDetailsRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initMovieRecomAndSimilarDetails(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetMoviesRecommedations(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetMoviesSimilar(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<MoviesDetailsRecommendationAndSimilarContracts>(
    () => MoviesRecommendationAndSimilarImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    )
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<MoviesRecommendationAndSimilarRemoteDataSource>(
    () => MoviesRecommendationAndSimilarRemoteDataSourceImpl(client: serviceLocator())
  );


}

initSerieRecomAndSimilarDetails(){
  //? Usescases
  
  serviceLocator.registerLazySingleton(() => GetSeriesRecommedations(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetSeriesSimilar(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<SeriesDetailsRecommendationAndSimilarContracts>(
    () => SeriesRecommendationAndSimilarImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    )
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<SeriesRecommendationAndSimilarRemoteDataSource>(
    () => SeriesRecommendationAndSimilarRemoteDataSourceImpl(client: serviceLocator())
  );

}

initAnimeRecomAndSimilarDetails(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetAnimeRecommendation(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAnimeSimilar(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<AnimeDetailsRecommendationAndSimilarContracts>(
    () => AnimeRecommendationAndSimilarImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    )
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<AnimeRecommendationAndSimilarRemoteDataSource>(
    () => AnimeRecommendationAndSimilarRemoteDataSourceImpl(client: serviceLocator())
  );

}

initVideoYoutubeDetails(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetListVideosYoutube(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<VideoYoutubeDetailsContract>(
    () => VideoYoutubeDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<VideoYoutubeDetailsRemoteDataSource>(
    () => VideoYoutubeDetailsRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}

initSeasonInfo(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetSeasonInfo(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<SeasonInfoDetailsContract>(
    () => SeasonInfoDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<SeasonInfoDetailsRemoteDataSource>(
    () => SeasonInfoDetailsRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}

initPeopleDetails(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetPeopleDetails(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<PeopleDetailsContract>(
    () => PeopleDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<PeopleDetailsRemoteDataSource>(
    () => PeopleDetailsRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}

initPeopleSocialMedia(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetPeopleSocialMedia(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<PeopleSocialMediaContract>(
    () => PeopleSocialMediaImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<PeopleSocialMediaRemoteDataSource>(
    () => PeopleSocialMediaRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}

initPeopleCredits(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetPeopleCredits(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<PeopleCreditsContract>(
    () => PeopleCreditsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<PeopleCreditsRemoteDataSource>(
    () => PeopleCreditsRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}