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
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Home Tops Features
  initMovies();
  initSeries();
  initAnime();

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

initMovies(){
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



initSeries(){
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


initAnime(){
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
