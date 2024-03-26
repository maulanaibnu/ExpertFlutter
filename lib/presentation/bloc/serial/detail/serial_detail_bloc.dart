// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_detail.dart';
import 'package:equatable/equatable.dart';

part 'serial_detail_event.dart';
part 'serial_detail_state.dart';

class SerialDetailBloc extends Bloc<SerialDetailEvent, SerialDetailState> {
  final GetSerialDetail _getSerialDetail;

  SerialDetailBloc(this._getSerialDetail) : super(SerialDetailEmpty()) {
    on<OnSerialDetailEvent>(_onSerialDetailEvent);
  }

  Future<void> _onSerialDetailEvent(
      OnSerialDetailEvent event, Emitter<SerialDetailState> state) async {
    final id = event.id;
    emit(SerialDetailLoading());

    final result = await _getSerialDetail.execute(id);

    result.fold(
      (failure) {
        emit(SerialDetailError(failure.message));
      },
      (detail) {
        emit(SerialDetailHasData(detail));
      },
    );
  }
}
