
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/serial/get_popular_serial.dart';
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import 'popular_serial_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSerial])
void main() {
  late MockGetPopularSerial mockGetPopularSerial;
  late SerialPopularBloc serialBloc;

  setUp(() {
    mockGetPopularSerial = MockGetPopularSerial();
    serialBloc = SerialPopularBloc(mockGetPopularSerial);
  });

  test('initial state should be empty', () {
    expect(serialBloc.state, SerialPopularEmpty());
  });

  blocTest<SerialPopularBloc, SerialPopularState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetPopularSerial.execute())
          .thenAnswer((_) async => Right(testSerialList));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialPopularEvent()),
    expect: () => [
      SerialPopularLoading(),
      SerialPopularHasData(testSerialList),
    ],
    verify: (bloc) {
      verify(mockGetPopularSerial.execute());
      return OnSerialPopularEvent().props;
    },
  );

  blocTest<SerialPopularBloc, SerialPopularState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetPopularSerial.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialPopularEvent()),
    expect: () => [
      SerialPopularLoading(),
      SerialPopularError('Server Failure'),
    ],
    verify: (bloc) => SerialPopularLoading(),
  );

  blocTest<SerialPopularBloc, SerialPopularState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetPopularSerial.execute())
          .thenAnswer((_) async => const Right([]));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialPopularEvent()),
    expect: () => [
      SerialPopularLoading(),
      SerialPopularEmpty(),
    ],
  );
}