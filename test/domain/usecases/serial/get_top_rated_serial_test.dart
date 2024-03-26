
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_top_rated_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSerialRepository mockSerialRepository;
  late GetTopRatedSerial usecase;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetTopRatedSerial(mockSerialRepository);
  });

  final tSerial = <Serial>[];

  test('should get list of serial top rated from the repository', () async {
    // arrange
    when(mockSerialRepository.getTopRatedSerial())
        .thenAnswer((_) async => Right(tSerial));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSerial));
  });
}