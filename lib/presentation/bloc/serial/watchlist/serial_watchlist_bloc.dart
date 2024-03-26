import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_status_serial.dart';
import 'package:ditonton/domain/usecases/serial/remove_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/save_watchlist_serial.dart';

import 'package:equatable/equatable.dart';

part 'serial_watchlist_event.dart';
part 'serial_watchlist_state.dart';

class SerialWatchlistBloc
  extends Bloc<SerialWatchlistEvent, WatchlistSerialState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistSerial _getWatchlistSeria;
  final GetWatchListStatusSerial _getWatchlistStatusSeria;
  final RemoveWatchlistSerial _removeWatchlistSeria;
  final SaveWatchlistSerial _saveWatchlistSeria;

  SerialWatchlistBloc(
    this._getWatchlistSeria,
    this._getWatchlistStatusSeria,
    this._removeWatchlistSeria,
    this._saveWatchlistSeria,
  ) : super(WatchlistSerialInitial()) {
    on<OnGethWatchlistSerial>(_onFetchSerialWatchlist);
    on<FetchSerialWatchlistStatus>(_fetchWatchlistSerialStatus);
    on<AddSerialToWatchlist>(_addSerialToWatchlist);
    on<RemoveSerialFromWatchlist>(_removeSerialFromWatchlist);
  }

  Future<void> _onFetchSerialWatchlist(
    OnGethWatchlistSerial event,
    Emitter<WatchlistSerialState> emit,
  ) async {
    emit(WatchlistSerialLoading());

    final result = await _getWatchlistSeria.execute();

    result.fold(
      (failure) {
        emit(WatchlistSerialError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(WatchlistSerialEmpty())
            : emit(WatchlistSerialHasData(data));
      },
    );
  }

  Future<void> _fetchWatchlistSerialStatus(
    FetchSerialWatchlistStatus event,
    Emitter<WatchlistSerialState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatusSeria.execute(id);

    emit(SerialIsAddedToWatchlist(result));
  }

  Future<void> _addSerialToWatchlist(
    AddSerialToWatchlist event,
    Emitter<WatchlistSerialState> emit,
  ) async {
    final tv = event.serial;

    final result = await _saveWatchlistSeria.execute(tv);

    result.fold(
      (failure) {
        emit(WatchlistSerialError(failure.message));
      },
      (message) {
        emit(WatchlistSerialMessage(message));
      },
    );
  }

  Future<void> _removeSerialFromWatchlist(
    RemoveSerialFromWatchlist event,
    Emitter<WatchlistSerialState> emit,
  ) async {
    final serial = event.serial;

    final result = await _removeWatchlistSeria.execute(serial);

    result.fold(
      (failure) {
        emit(WatchlistSerialError(failure.message));
      },
      (message) {
        emit(WatchlistSerialMessage(message));
      },
    );
  }
}
