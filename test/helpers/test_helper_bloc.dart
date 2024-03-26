import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/detail/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/detail/serial_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/recommendation/serial_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/watchlist/serial_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUp(() {
    //movie
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());

    //serial
    registerFallbackValue(FakeSerialListEvent());
    registerFallbackValue(FakeSerialListState());
    registerFallbackValue(FakeSerialPopularEvent());
    registerFallbackValue(FakeSerialPopularState());
    registerFallbackValue(FakeSerialTopRatedEvent());
    registerFallbackValue(FakeSerialTopRatedState());
    TestWidgetsFlutterBinding.ensureInitialized();
  });
}

//movie
class MockTopRatedMoviesBloc extends MockBloc<TopRatedMovieEvent, TopRatedMovieState> implements TopRatedMovieBloc {}
class FakeTopRatedMoviesEvent extends Fake implements TopRatedMovieEvent {}
class FakeTopRatedMoviesState extends Fake implements TopRatedMovieState {}
class FakeMovieListEvent extends Fake implements NowPlayingMovieEvent {}
class FakeMovieListState extends Fake implements NowPlayingMovieState {}
class FakeMovieListBloc extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState> implements NowPlayingMovieBloc {}
class FakePopularMovieEvent extends Fake implements PopularMovieEvent {}
class FakePopularMovieState extends Fake implements PopularMovieState {}
class FakePopularMovieBloc extends MockBloc<PopularMovieEvent, PopularMovieState> implements PopularMovieBloc {}
class FakeTopRatedMovieEvent extends Fake implements TopRatedMovieEvent {}
class FakeTopRatedMovieState extends Fake implements TopRatedMovieState {}
class FakeTopRatedMovieBloc extends MockBloc<TopRatedMovieEvent, TopRatedMovieState> implements TopRatedMovieBloc {}
class FakeMovieDetailEvent extends Fake implements DetailMovieEvent {}
class FakeMovieDetailState extends Fake implements DetailMovieState {}
class FakeMovieDetailBloc extends MockBloc<DetailMovieEvent, DetailMovieState> implements DetailMovieBloc {}
class FakeRecommendationMovieEvent extends Fake implements RecomendationMovieEvent {}
class FakeRecommendationMovieState extends Fake implements RecomendationMovieState {}
class FakeRecommendationMovieBloc extends MockBloc<RecomendationMovieEvent, RecomendationMovieState> implements RecomendationMovieBloc {}
class FakeMovieWatchlistEvent extends Fake implements WatchlistMovieEvent {}
class FakeMovieWatchlistState extends Fake implements WatchlistMovieState {}
class FakeMovieWatchlistBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState> implements WatchlistMovieBloc {}


//serial
class FakeSerialListBloc extends MockBloc<SerialNowPlayingEvent, SerialNowPlayingState> implements SerialNowPlayingBloc {}
class FakeSerialListEvent extends Fake implements SerialNowPlayingEvent {}
class FakeSerialListState extends Fake implements SerialNowPlayingState {}
class FakeSerialPopularBloc extends MockBloc<SerialPopularEvent, SerialPopularState> implements SerialPopularBloc {}
class FakeSerialPopularEvent extends Fake implements SerialPopularEvent {}
class FakeSerialPopularState extends Fake implements SerialPopularState {}
class FakeSerialTopRatedBloc extends MockBloc<SerialRatedEvent, SerialRatedState> implements SerialRatedBloc {}
class FakeSerialTopRatedEvent extends Fake implements SerialRatedEvent {}
class FakeSerialTopRatedState extends Fake implements SerialRatedState {}
class FakeSerialDetailBloc extends MockBloc<SerialDetailEvent, SerialDetailState> implements SerialDetailBloc {}
class FakeSerialDetailEvent extends Fake implements SerialDetailEvent {}
class FakeSerialDetailState extends Fake implements SerialDetailState {}
class FakeSerialWatchlistBloc extends MockBloc<SerialWatchlistEvent, WatchlistSerialState> implements SerialWatchlistBloc {}
class FakeSerialWatchlistEvent extends Fake implements SerialWatchlistEvent {}
class FakeSerialWatchlistState extends Fake implements WatchlistSerialState {}
class FakeSerialRecommendatioBloc extends MockBloc<SerialRecomendationEvent, SerialRecomendationState> implements SerialRecomendationBloc {}
class FakeSerialRecommendationEvent extends Fake implements SerialRecomendationEvent {}
class FakeSerialRecommendatioState extends Fake implements SerialRecomendationState {}
