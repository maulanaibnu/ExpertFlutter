// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_top_rated_serial.dart';
import 'package:equatable/equatable.dart';

part 'serial_rated_event.dart';
part 'serial_rated_state.dart';

class SerialRatedBloc
    extends Bloc<SerialRatedEvent, SerialRatedState> {
  final GetTopRatedSerial _getTopRatedSerial;

  SerialRatedBloc(this._getTopRatedSerial)
      : super(SerialRatedEmpty()) {
    on<OnSerialRatedEvent>(_onSerialRatedEvent);
  }

  Future<void> _onSerialRatedEvent(OnSerialRatedEvent event,
      Emitter<SerialRatedState> state) async {
    emit(SerialRatedLoading());

    final result = await _getTopRatedSerial.execute();

    result.fold(
      (failure) {
        emit(SerialRatedError(failure.message));
      },
      (toRated) {
        if (toRated.isEmpty) {
          emit(SerialRatedEmpty());
        } else {
          emit(SerialRatedHasData(toRated));
        }
      },
    );
  }
}

