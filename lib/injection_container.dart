import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:bunkalist/src/features/base/data/datasources/crud_user_remote_data_source.dart';
import 'package:bunkalist/src/features/base/data/implementations/crud_user_data_impl.dart';
import 'package:bunkalist/src/features/base/domain/contracts/crud_data_user_contract.dart';
import 'package:bunkalist/src/features/base/domain/usescases/add_user_data.dart';
import 'package:bunkalist/src/features/base/domain/usescases/get_user_data.dart';
import 'package:bunkalist/src/features/base/domain/usescases/update_user_data.dart';
import 'package:bunkalist/src/features/base/presentation/bloc/bloc/userdata_bloc.dart';
import 'package:bunkalist/src/features/explorer/data/datasources/anime_explorer_remote_data_source.dart';
import 'package:bunkalist/src/features/explorer/data/datasources/movies_explorer_remote_data_source.dart';
import 'package:bunkalist/src/features/explorer/data/datasources/series_explorer_remote_source.dart';
import 'package:bunkalist/src/features/explorer/data/implementations/anime_explorer_impl.dart';
import 'package:bunkalist/src/features/explorer/data/implementations/movies_explorer_impl.dart';
import 'package:bunkalist/src/features/explorer/data/implementations/series_explorer_impl.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/anime_explorer_contract.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/movie_explorer_contract.dart';
import 'package:bunkalist/src/features/explorer/domain/contracts/serie_explorer_contract.dart';
import 'package:bunkalist/src/features/explorer/domain/usescases/get_explorer_animes.dart';
import 'package:bunkalist/src/features/explorer/domain/usescases/get_explorer_movies.dart';
import 'package:bunkalist/src/features/explorer/domain/usescases/get_explorer_series.dart';
import 'package:bunkalist/src/features/explorer/presentation/bloc/bloc_explorer_animes/animes_explorer_bloc.dart';
import 'package:bunkalist/src/features/explorer/presentation/bloc/bloc_explorer_movies/moviesexplorer_bloc.dart';
import 'package:bunkalist/src/features/explorer/presentation/bloc/bloc_explorer_series/series_explorer_bloc.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/movie_cinema_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_anime_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_movie_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/datasources/tops_series_remote_data_source.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/anime_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/movie_cinema_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/movie_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/data/implementations/series_tops_repos_impl.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/anime_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_cinema_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/serie_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_cinema_movie.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_anime.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_movies.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime_season/animeseason_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_cinema_movie/cinemamovie_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_animes/selectionanimes_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_movies/selectionmovies_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_selection_series/selectionseries_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series/tops_series_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_anime/tops_animes_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_movies/tops_movies_bloc.dart';
import 'package:bunkalist/src/features/home_tops/presentation/bloc/bloc_series_air_month/seriesair_bloc.dart';
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
import 'package:bunkalist/src/features/login/presentation/bloc/bloc_register/register_bloc.dart';
import 'package:bunkalist/src/features/options/data/datasources/update_user_info_remote_data_source.dart';
import 'package:bunkalist/src/features/options/data/implementations/changed_profile_image_impl.dart';
import 'package:bunkalist/src/features/options/data/implementations/changed_username_impl.dart';
import 'package:bunkalist/src/features/options/domain/contracts/changed_profile_image_contract.dart';
import 'package:bunkalist/src/features/options/domain/contracts/changed_username_contract.dart';
import 'package:bunkalist/src/features/options/domain/usescases/get_changed_profile_image.dart';
import 'package:bunkalist/src/features/options/domain/usescases/get_changed_username.dart';
import 'package:bunkalist/src/features/options/presentation/bloc/bloc_edit_profile/editprofile_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/credits_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/images_poster_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/keywords_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_credits_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/people_social_media_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/review_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/season_info_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/serie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/video_youtube_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/watch_provider_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/credits_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/images_poster_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/keyword_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/people_credits_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/people_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/people_social_media_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/review_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/season_info_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/watch_provider_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/youtube_video_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details.rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/credits_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/get_season_info_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/images_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/keywords_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_rec_sim_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_credits_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/people_social_media_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/review_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/video_youtube_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/watch_provider_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_credits_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_images_poster_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_keywords_details.dart';
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
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_watch_provider_details.dart';
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
import 'package:bunkalist/src/features/profile/data/implementations/get_total_by_status_impl.dart';
import 'package:bunkalist/src/features/profile/data/implementations/update_ouevre_impl.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/add_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/delete_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/get_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/get_total_by_status_contract.dart';
import 'package:bunkalist/src/features/profile/domain/contracts/update_ouevre_contract.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_add_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_delete_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_get_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_total_by_status.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_update_ouevre.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_add/addouevre_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_delete/bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_get_lists/getlists_bloc.dart';
import 'package:bunkalist/src/features/profile/presentation/bloc/bloc_update/update_bloc.dart';
import 'package:bunkalist/src/features/search/data/datasources/search_result_remote_data_source.dart';
import 'package:bunkalist/src/features/search/data/implementations/search_result_impl.dart';
import 'package:bunkalist/src/features/search/domain/contracts/search_result_contract.dart';
import 'package:bunkalist/src/features/search/domain/usescases/get_search.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/datasources/anime_personal_top_remote_data_source.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/datasources/movie_personal_top_remote_data_source.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/datasources/serie_personal_top_remote_data_source.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/implementations/anime_personal_top_impl.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/implementations/movie_personal_top_impl.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/data/implementations/serie_personal_top_impl.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/anime_personal_top_contract.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/movie_personal_top_contract.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/contracts/serie_personal_top_contract.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/usescases/get_personal_top_anime.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/usescases/get_personal_top_movies.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/domain/usescases/get_personal_top_series.dart';
import 'package:bunkalist/src/premium_features/home_tops_premium/presentation/bloc/bloc/personaltop1_bloc.dart';
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
  initCinemaMovie();
  initTopsSeries();
  initTopsAnime();
  //! Home Tops Premium Features
  initPremiumHomeTops();
  //! Explorer Features
  initExplorerMovies();
  initExplorerSeries();
  initExplorerAnimes();
  //! Ouevre Details Features
  initOuevreDetails();
  //! Search Features
  initSearch();
  initLogin();
  //! Profile Features
  initProfile();
  // initProfileUpdate();
  //! Setting Features
  initEditProfile();
  //! Base Features
  initDataUser();
  
  //? Core

  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  //? External

  

  serviceLocator.registerLazySingleton(() => http.Client());

  serviceLocator.registerLazySingleton(() => DataConnectionChecker());


}



initTopsMovies(){
  //? BLoc
  serviceLocator.registerFactory(
    () => TopsMoviesBloc(
      movies: serviceLocator(),
      ),
    ); 
  serviceLocator.registerFactory(
    () => SelectionmoviesBloc(
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

initCinemaMovie(){
  //? BLoc
  serviceLocator.registerFactory(
    () => CinemaMovieBloc(
      cinemaMovies: serviceLocator(),
      ),
    ); 
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetCinemaMovies(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<MoviesCinemaRepository>(
    () => MovieCinemaRepositoryImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<CinemaMovieRemoteDataSource>(
    () => CinemaMovieRemoteDataSourceImpl(client: serviceLocator())
  );  
  
}


initTopsSeries(){
  //? Blocs
  serviceLocator.registerFactory(
    () => TopsSeriesBloc(
      series: serviceLocator()
    ),
  );

  serviceLocator.registerFactory(
    () => SeriesAirBloc(
      series: serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
    () => SelectionseriesBloc(
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

  serviceLocator.registerFactory(
    () => AnimeSeasonBloc(
      animes: serviceLocator()
      )
    );  
  serviceLocator.registerFactory(
    () => SelectionanimesBloc(
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


initPremiumHomeTops(){
  //? BLoc
  serviceLocator.registerFactory(
    () => Personaltop1Bloc(
      personalTopsMovies: serviceLocator(),
      personalTopsSeries: serviceLocator(),
      personalTopsAnime: serviceLocator()
      ),
    ); 
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetPersonalTopsMovies(serviceLocator())); 
  serviceLocator.registerLazySingleton(() => GetPersonalTopsSeries(serviceLocator())); 
  serviceLocator.registerLazySingleton(() => GetPersonalTopsAnime(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<MoviePersonalTopsContract>(
    () => MoviesPersonalTopsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  serviceLocator.registerLazySingleton<SeriePersonalTopsContract>(
    () => SeriesPersonalTopsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  serviceLocator.registerLazySingleton<AnimePersonalTopsContract>(
    () => AnimesPersonalTopsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    );     
  //? Data Sources
  serviceLocator.registerLazySingleton<MoviesPersonalTopsRemoteDataSource>(
    () => MoviesPersonalTopsRemoteDataSourceImpl(client: serviceLocator())
  );

  serviceLocator.registerLazySingleton<SeriesPersonalTopsRemoteDataSource>(
    () => SeriesPersonalTopsRemoteDataSourceImpl(client: serviceLocator())
  );

  serviceLocator.registerLazySingleton<AnimesPersonalTopsRemoteDataSource>(
    () => AnimesPersonalTopsRemoteDataSourceImpl(client: serviceLocator())
  );
}


initExplorerMovies(){
  //? BLoc
  serviceLocator.registerFactory(
    () => MoviesExplorerBloc(
      explorerMovies: serviceLocator(),
      ),
    ); 
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetExplorerMovies(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<MovieExplorerContract>(
    () => MoviesExplorerImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<MoviesExplorerRemoteDataSource>(
    () => MoviesExplorerRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initExplorerSeries(){
  //? BLoc
  serviceLocator.registerFactory(
    () => SeriesExplorerBloc(
      explorerSeries: serviceLocator(),
      ),
    ); 
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetExplorerSeries(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<SerieExplorerContract>(
    () => SeriesExplorerImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<SeriesExplorerRemoteDataSource>(
    () => SeriesExplorerRemoteDataSourceImpl(client: serviceLocator())
  );  
}

initExplorerAnimes(){
  //? BLoc
  serviceLocator.registerFactory(
    () => AnimesExplorerBloc(
      explorerAnime: serviceLocator(),
      ),
    ); 
  //?UsesCases
  serviceLocator.registerLazySingleton(() => GetExplorerAnime(serviceLocator())); 
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<AnimeExplorerContract>(
    () => AnimesExplorerImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
      ),
    ); 
  //? Data Sources
  serviceLocator.registerLazySingleton<AnimesExplorerRemoteDataSource>(
    () => AnimesExplorerRemoteDataSourceImpl(client: serviceLocator())
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
      googleAuth: serviceLocator(),
      )
    );

  serviceLocator.registerFactory(
    () => RegisterBloc(
      userRegister: serviceLocator()
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

initDataUser(){
  //? Blocs
  serviceLocator.registerFactory(
    () => UserdataBloc(
      addUser: serviceLocator(),
      getUser: serviceLocator(),
      updateUser: serviceLocator()
      )
    );      

  

  //? UseCases
  serviceLocator.registerLazySingleton(() => AddUserData(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUserData(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateUserData(serviceLocator()));
  
  
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<CrudDataUserContract>(
    () => CrudUserDataImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

  //? Data Sources
  serviceLocator.registerLazySingleton< CrudUserRemoteDataSource>(
    () =>  CrudUserRemoteDataSourceImpl()
  );

}

// initProfileUpdate(){
//   //? Blocs
//   serviceLocator.registerFactory(
//     () => UpdateBloc(
//       updateOuevre: serviceLocator()
//       )
//     );
//   //? UseCases
//   serviceLocator.registerLazySingleton(() => GetUpdateOuevre(serviceLocator()));
//   //? Repository - Contracts
//   serviceLocator.registerLazySingleton<UpdateOuevreContract>(
//     () => UpdateOuevreImpl(
//       remoteDataSource: serviceLocator(),
//       ),
//     );
//   //  //? Data Sources
//   // serviceLocator.registerLazySingleton<CrudOuevreRemoteDataSource>(
//   //   () => CrudOuevreRemoteDataSourceImpl()
//   // );
// }

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
      allOuevre: serviceLocator(),
      totalByStatus: serviceLocator()
      )
    );      

  

  //? UseCases
  serviceLocator.registerLazySingleton(() => GetAllOuevre(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAddOuevre(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetDeleteOuevre(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetUpdateOuevre(serviceLocator()));
   serviceLocator.registerLazySingleton(() => GetTotalByStatus(serviceLocator()));
  
  
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

    serviceLocator.registerLazySingleton<GetTotalByStatusContract>(
    () => GetTotalByStatusImpl(
      remoteDataSource: serviceLocator(),
      ),
    );  


  //? Data Sources
  serviceLocator.registerLazySingleton<CrudOuevreRemoteDataSource>(
    () => CrudOuevreRemoteDataSourceImpl()
  );

}

initEditProfile(){
  //? Blocs
  serviceLocator.registerFactory(
    () => EditprofileBloc(
      changedUsername: serviceLocator(),
      changedProfileImage: serviceLocator()
      )
    );
  //? UseCases
  serviceLocator.registerLazySingleton(() => GetChangedUsername(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetChangedProfileImage(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<ChangeUsernameContract>(
    () => ChangedUsernameImpl(
      remoteDataSource: serviceLocator(),
      ),
    );
   serviceLocator.registerLazySingleton<ChangeProfileImageContract>(
    () => ChangedProfileImageImpl(
      remoteDataSource: serviceLocator(),
      ),
    );

  //? Data Sources
  serviceLocator.registerLazySingleton<UpdateUserInfoRemoteDataSource>(
    () => UpdateUserInfoRemoteDataSourceImpl()
  );
}

initOuevreDetails(){
  
  
  
  //? BLoc
  serviceLocator.registerFactory(
    () => OuevreDetailsBloc(
      movie: serviceLocator(),
      serie: serviceLocator(),
      anime: serviceLocator(),
      keywords: serviceLocator(),
      poster: serviceLocator(),
      watchProvider: serviceLocator()
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
      season: serviceLocator()
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
  initKeywords();
  initWatchProvider();
  initImagesPoster();
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


initKeywords(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetKeywordsDetails(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<KeywordsDetailsContract>(
    () => KeywordsDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<KeywordsRemoteDataSource>(
    () => KeywordsRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}


initWatchProvider(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetWatchProviderDetails(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<WatchProviderDetailsContract>(
    () => WatchProviderDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<WatchProviderRemoteDataSource>(
    () => WatchProviderRemoteDataSourceImpl(
      client: serviceLocator()
    )
  );
}

initImagesPoster(){
  //? Usescases
  serviceLocator.registerLazySingleton(() => GetPosterImagesDetails(serviceLocator()));
  //? Repository - Contracts
  serviceLocator.registerLazySingleton<ImagesPosterDetailsContract>(
    () => ImagesPosterDetailsImpl(
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator()
    ),
  );
  //? Data Sources
  serviceLocator.registerLazySingleton<ImagesDetailsRemoteDataSource>(
    () => ImagesDetailsRemoteDataSourceImpl(
      client: serviceLocator()
    )
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


