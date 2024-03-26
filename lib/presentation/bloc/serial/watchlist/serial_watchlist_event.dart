part of 'serial_watchlist_bloc.dart';

abstract class SerialWatchlistEvent extends Equatable {}

class OnGethWatchlistSerial extends SerialWatchlistEvent {
  @override
  List<Object> get props => [];
}

class FetchSerialWatchlistStatus extends SerialWatchlistEvent {
  final int id;

  FetchSerialWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
class AddSerialToWatchlist extends SerialWatchlistEvent {
  final SerialDetail serial;

  AddSerialToWatchlist(this.serial);

  @override
  List<Object> get props => [];
}

class RemoveSerialFromWatchlist extends SerialWatchlistEvent {
  final SerialDetail serial;

  RemoveSerialFromWatchlist(this.serial);

  @override
  List<Object> get props => [];
}
