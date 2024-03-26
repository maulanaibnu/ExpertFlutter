
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/serial/get_top_rated_serial.dart';
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import 'top_rated_serial_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSerial])
void main() {
  late MockGetTopRatedSerial mockGetTopRatedSerial;
  late SerialRatedBloc serialBloc;

  setUp(() {
    mockGetTopRatedSerial = MockGetTopRatedSerial();
    serialBloc = SerialRatedBloc(mockGetTopRatedSerial);
  });

  test('initial state should be empty', () {
    expect(serialBloc.state, SerialRatedEmpty());
  });

  blocTest<SerialRatedBloc, SerialRatedState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetTopRatedSerial.execute())
          .thenAnswer((_) async => Right(testSerialList));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialRatedEvent()),
    expect: () => [
      SerialRatedLoading(),
      SerialRatedHasData(testSerialList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSerial.execute());
      return OnSerialRatedEvent().props;
    },
  );

  blocTest<SerialRatedBloc, SerialRatedState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetTopRatedSerial.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialRatedEvent()),
    expect: () => [
      SerialRatedLoading(),
      SerialRatedError('Server Failure'),
    ],
    verify: (bloc) => SerialRatedLoading(),
  );

  blocTest<SerialRatedBloc, SerialRatedState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetTopRatedSerial.execute())
          .thenAnswer((_) async => const Right([]));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialRatedEvent()),
    expect: () => [
      SerialRatedLoading(),
      SerialRatedEmpty(),
    ],
  );
}