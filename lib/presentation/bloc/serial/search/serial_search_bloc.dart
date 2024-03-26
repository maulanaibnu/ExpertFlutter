import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/search_serial.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movie_bloc.dart';
import 'package:equatable/equatable.dart';

part 'serial_search_event.dart';
part 'serial_search_state.dart';

class SerialSearchBloc
    extends Bloc<SerialSearchEvent, SerialSearchState> {
  final SearchSerial _searchTv;

  SerialSearchBloc(this._searchTv) : super(SerialSearchEmpty()) {
    on<OnSerialQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SerialSearchLoading());
      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SerialSearchError(failure.message));
        },
        (data) {
          emit(SerialSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
