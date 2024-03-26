
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/serial/get_now_playing_serial.dart';
import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import 'now_playing_serial_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSerial])
void main() {
  late MockGetNowPlayingSerial mockGetNowPlayingSerial;
  late SerialNowPlayingBloc serialBloc;

  setUp(() {
    mockGetNowPlayingSerial = MockGetNowPlayingSerial();
    serialBloc = SerialNowPlayingBloc(mockGetNowPlayingSerial);
  });

  test('initial state should be empty', () {
    expect(serialBloc.state, SerialNowPlayingEmpty());
  });

  blocTest<SerialNowPlayingBloc, SerialNowPlayingState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetNowPlayingSerial.execute())
          .thenAnswer((_) async => Right(testSerialList));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialNowPlayingEvent()),
    expect: () => [
      SerialNowPlayingLoading(),
      SerialNowPlayingHasData(testSerialList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingSerial.execute());
      return OnSerialNowPlayingEvent().props;
    },
  );

  blocTest<SerialNowPlayingBloc, SerialNowPlayingState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetNowPlayingSerial.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialNowPlayingEvent()),
    expect: () => [
      SerialNowPlayingLoading(),
      SerialNowPlayingError('Server Failure'),
    ],
    verify: (bloc) => SerialNowPlayingLoading(),
  );

  blocTest<SerialNowPlayingBloc, SerialNowPlayingState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetNowPlayingSerial.execute())
          .thenAnswer((_) async => const Right([]));
      return serialBloc;
    },
    act: (bloc) => bloc.add(OnSerialNowPlayingEvent()),
    expect: () => [
      SerialNowPlayingLoading(),
      SerialNowPlayingEmpty(),
    ],
  );
}