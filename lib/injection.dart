import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/serial_local_data_source.dart';
import 'package:ditonton/data/datasources/serial_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/serial/serial_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/serial_repository.dart';

import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/serial/get_now_playing_serial.dart';
import 'package:ditonton/domain/usecases/serial/get_popular_serial.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_detail.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_recomendations.dart';
import 'package:ditonton/domain/usecases/serial/get_top_rated_serial.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_status_serial.dart';
import 'package:ditonton/domain/usecases/serial/remove_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/save_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/search_serial.dart';
import 'package:ditonton/presentation/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/detail/serial_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/recommendation/serial_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/search/serial_search_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/watchlist/serial_watchlist_bloc.dart';


import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc movie
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => RecomendationMovieBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator(), locator(), locator(), locator()));
  
  // bloc serial
  locator.registerFactory(() => SerialNowPlayingBloc(locator()));
  locator.registerFactory(() => SerialPopularBloc(locator()));
  locator.registerFactory(() => SerialRatedBloc(locator()));
  locator.registerFactory(() => SerialDetailBloc(locator()));
  locator.registerFactory(() => SerialSearchBloc(locator()));
  locator.registerFactory(() => SerialRecomendationBloc(locator()));
  locator.registerFactory(() => SerialWatchlistBloc(locator(), locator(), locator(), locator()));

  

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // use case serial
  locator.registerLazySingleton(() => RemoveWatchlistSerial(locator()));
  locator.registerLazySingleton(() => GetNowPlayingSerial(locator()));
  locator.registerLazySingleton(() => GetPopularSerial(locator()));
  locator.registerLazySingleton(() => GetSerialRecommendations(locator()));
  locator.registerLazySingleton(() => GetSerialDetail(locator()));
  locator.registerLazySingleton(() => GetWatchlistSerial(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSerial(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSerial(locator()));
  locator.registerLazySingleton(() => GetTopRatedSerial(locator()));
  locator.registerLazySingleton(() => SearchSerial(locator()));
  

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SerialRepository>(
    () => SerialRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SerialLocalDataSource>(
      () => SerialLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SerialRemoteDataSource>(
      () => SerialRemoteDataSourceImpl(client: locator()));
  
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton<SSLPinningClient>(() => SSLPinningClient());
}
