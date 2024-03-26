// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_recomendations.dart';

import 'package:equatable/equatable.dart';

part 'serial_recommendation_event.dart';
part 'serial_recommendation_state.dart';

class SerialRecomendationBloc
    extends Bloc<SerialRecomendationEvent, SerialRecomendationState> {
  final GetSerialRecommendations _getSerialRecomendation;

  SerialRecomendationBloc(this._getSerialRecomendation)
      : super(SerialRecomendationEmpty()) {
    on<OnSerialRecomendationEvent>(_onSerialRecomendationEvent);
  }

  Future<void> _onSerialRecomendationEvent(OnSerialRecomendationEvent event,
      Emitter<SerialRecomendationState> state) async {
    final id = event.id;
    emit(SerialRecomendationLoading());

    final result = await _getSerialRecomendation.execute(id);

    result.fold(
      (failure) {
        emit(SerialRecomendationError(failure.message));
      },
      (recomendation) {
        if (recomendation.isEmpty) {
          emit(SerialRecomendationEmpty());
        } else {
          emit(SerialRecomendationHasData(recomendation));
        }
      },
    );
  }
}

