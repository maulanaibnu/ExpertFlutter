
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_detail.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSerialDetail usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetSerialDetail(mockSerialRepository);
  });

  final tId = 1;

  test('should get detail serial from the repository', () async {
    // arrange
    when(mockSerialRepository.getSerialDetail(tId))
        .thenAnswer((_) async => Right(tSerialDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSerialDetail));
  });
}