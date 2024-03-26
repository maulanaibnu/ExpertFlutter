import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
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
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/bottomnav.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/serial/detail_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/now_playing_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/popular_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/search_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/serial_list_page.dart';
import 'package:ditonton/presentation/pages/serial/top_rated_serial_page.dart';
import 'package:ditonton/presentation/pages/serial/watchlist_serial_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        //movie
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()), 
        BlocProvider(create: (_) => di.locator<RecomendationMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),

        //serial
        BlocProvider(create: (_) => di.locator<SerialRatedBloc>()),
        BlocProvider(create: (_) => di.locator<SerialDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SerialNowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<SerialRecomendationBloc>()),
        BlocProvider(create: (_) => di.locator<SerialPopularBloc>()),
        BlocProvider(create: (_) => di.locator<SerialSearchBloc>()),

        BlocProvider(create: (_) => di.locator<SerialWatchlistBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: BottomNavPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case DetailSerialPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailSerialPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
              case WatchlistSerialPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSerialPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case NowPlayingSerialPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => NowPlayingSerialPage());
            case SerialListPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SerialListPage());
            case PopularSerialPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSerialPage());
            case TopRatedSerialPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSerialPage());
            case SearchSerialPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchSerialPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
