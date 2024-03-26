// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_now_playing_serial.dart';
import 'package:equatable/equatable.dart';
part 'serial_now_playing_state.dart';
part 'serial_now_playing_event.dart';

class SerialNowPlayingBloc
    extends Bloc<SerialNowPlayingEvent, SerialNowPlayingState> {
  final GetNowPlayingSerial _getNowPlayingSerial;

  SerialNowPlayingBloc(this._getNowPlayingSerial)
      : super(SerialNowPlayingEmpty()) {
    on<OnSerialNowPlayingEvent>(_onNowPlayingEvent);
  }

  Future<void> _onNowPlayingEvent(
      OnSerialNowPlayingEvent event, Emitter<SerialNowPlayingState> state) async {
    emit(SerialNowPlayingLoading());

    final result = await _getNowPlayingSerial.execute();

    result.fold(
      (failure) {
        emit(SerialNowPlayingError(failure.message));
      },
      (nowPlaying) {
        if (nowPlaying.isEmpty) {
          emit(SerialNowPlayingEmpty());
        } else {
          emit(SerialNowPlayingHasData(nowPlaying));
        }
      },
    );
  }
}

