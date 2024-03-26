// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_popular_serial.dart';
import 'package:equatable/equatable.dart';

part 'serial_popular_event.dart';
part 'serial_popular_state.dart';

class SerialPopularBloc
    extends Bloc<SerialPopularEvent, SerialPopularState> {
  final GetPopularSerial _getPopularSerial;

  SerialPopularBloc(this._getPopularSerial)
      : super(SerialPopularEmpty()) {
    on<OnSerialPopularEvent>(_onPopularEvent);
  }

  Future<void> _onPopularEvent(
      OnSerialPopularEvent event, Emitter<SerialPopularState> state) async {
    emit(SerialPopularLoading());

    final result = await _getPopularSerial.execute();

    result.fold(
      (failure) {
        emit(SerialPopularError(failure.message));
      },
      (popular) {
        if (popular.isEmpty) {
          emit(SerialPopularEmpty());
        } else {
          emit(SerialPopularHasData(popular));
        }
      },
    );
  }
}
