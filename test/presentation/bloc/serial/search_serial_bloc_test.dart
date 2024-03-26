import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/search_serial.dart';
import 'package:ditonton/presentation/bloc/serial/search/serial_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import 'search_serial_bloc_test.mocks.dart';

@GenerateMocks([SearchSerial])
void main() {
  late SerialSearchBloc searchSerialBloc;
  late MockSearchSerial mockSearchSerial;

  setUp(() {
    mockSearchSerial = MockSearchSerial();
    searchSerialBloc = SerialSearchBloc(mockSearchSerial);
  });

  test('initial state should be empty', () {
    expect(searchSerialBloc.state, SerialSearchEmpty());
  });

  final tList = <Serial>[tSerial];
  final tQuery = 'Hazbin Hotel';

  test('initial state should be empty', () {
    expect(searchSerialBloc.state, SerialSearchEmpty());
  });

  blocTest<SerialSearchBloc, SerialSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSerial.execute(tQuery))
          .thenAnswer((_) async => Right(tList));
      return searchSerialBloc;
    },
    act: (bloc) => bloc.add(OnSerialQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SerialSearchLoading(),
      SerialSearchHasData(tList),
    ],
    verify: (bloc) {
      verify(mockSearchSerial.execute(tQuery));
    },
  );

  blocTest<SerialSearchBloc, SerialSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchSerial.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchSerialBloc;
    },
    act: (bloc) => bloc.add(OnSerialQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SerialSearchLoading(),
      SerialSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSerial.execute(tQuery));
    },
  );
}