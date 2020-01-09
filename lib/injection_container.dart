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
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/anime_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/credits_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/review_details_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/datasources/serie_details_rec_sim_remote_data_source.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/anime_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/credits_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/movie_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/review_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/data/implementations/serie_details_rec_sim_impl.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details.rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/credits_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/movie_details_rec_sim_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/review_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_rec_sim_contracts.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_recommendation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_credits_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_recommedation.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_movie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_review_details.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_recommendations.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_serie_details_similar.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_credits/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_details/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_recommendations/recommendations_bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_reviews/bloc.dart';
import 'package:bunkalist/src/features/ouevre_details/presentation/bloc/bloc_similar/similar_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'src/features/ouevre_details/data/datasources/serie_details_remote_data_source.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Home Tops Features
  initTopsMovies();
  initTopsSeries();
  initTopsAnime();
  //! Ouevre Details Features
  initOuevreDetails();

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

    

  //? Init MoviesDetails, SeriesDetails, AnimeDetails, ReviewDetails, CreditsDetails, RecomAndSimilarDetails
  initMovieDetails();
  initSerieDetails();
  initAnimeDetails();
  initReviewsDetails();
  initCreditsDetails();
  initMovieRecomAndSimilarDetails();
  initSerieRecomAndSimilarDetails();
  initAnimeRecomAndSimilarDetails();
}

// initBlocAndUsesCasesRecommendation(){
//   //? Bloc
//   // serviceLocator.registerFactory(
//   //   () => RecommendationsBloc(
//   //     moviesRecom: serviceLocator(),
//   //     seriesRecom: serviceLocator(),
//   //     animeRecom: serviceLocator(),
//   //   ),
//   // );
//   //? Usescases 
//   serviceLocator.registerSingleton(() => GetMoviesRecommedations(serviceLocator()));
//   serviceLocator.registerSingleton(() => GetSeriesRecommedations(serviceLocator()));
//   serviceLocator.registerSingleton(() => GetAnimeRecommendation(serviceLocator()));
  
// }
// initBlocAndUsesCasesSimilar(){
//    //? Bloc
//   // serviceLocator.registerFactory(
//   //   () => SimilarBloc(
//   //     moviesSimilar: serviceLocator(),
//   //     seriesSimilar: serviceLocator(),
//   //     animeSimilar: serviceLocator(),
//   //   ),
//   // );
//   //? Usescases 
//   serviceLocator.registerSingleton(() => GetMoviesSimilar(serviceLocator()));
//   serviceLocator.registerSingleton(() => GetSeriesSimilar(serviceLocator()));
//   serviceLocator.registerSingleton(() => GetAnimeSimilar(serviceLocator()));

// }


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