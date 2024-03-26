import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_now_playing_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSerialRepository mockSerialRepository;
  late GetNowPlayingSerial usecase;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetNowPlayingSerial(mockSerialRepository);
  });

  final tSerial = <Serial>[];

  test('should get list of  serial now playing from the repository',
      () async {
    // arrenge
    when(mockSerialRepository.getNowPlayingSerial())
        .thenAnswer((_) async => Right(tSerial));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSerial));
  });
}
