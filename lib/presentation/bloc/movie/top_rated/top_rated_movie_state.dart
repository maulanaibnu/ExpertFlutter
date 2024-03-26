// ignore_for_file: override_on_non_overriding_member

part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {}

class TopRatedMovieLoading extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}

class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieHasData extends TopRatedMovieState {
  final List<Movie> result;

  TopRatedMovieHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class TopRatedMovieEmpty extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}
