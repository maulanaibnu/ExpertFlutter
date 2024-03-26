part of 'serial_watchlist_bloc.dart';

abstract class WatchlistSerialState extends Equatable {}

class WatchlistSerialInitial extends WatchlistSerialState {
  @override
  List<Object> get props => [];
}

class WatchlistSerialEmpty extends WatchlistSerialState {
  @override
  List<Object> get props => [];
}

class WatchlistSerialLoading extends WatchlistSerialState {
  @override
  List<Object> get props => [];
}

class WatchlistSerialError extends WatchlistSerialState {
  final String message;

  WatchlistSerialError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSerialHasData extends WatchlistSerialState {
  final List<Serial> result;

  WatchlistSerialHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SerialIsAddedToWatchlist extends WatchlistSerialState {
  final bool isAdded;

  SerialIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistSerialMessage extends WatchlistSerialState {
  final String message;

  WatchlistSerialMessage(this.message);

  @override
  List<Object> get props => [message];
}
