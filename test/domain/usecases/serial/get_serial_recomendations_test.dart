
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_recomendations.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSerialRecommendations usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetSerialRecommendations(mockSerialRepository);
  });

  final tId = 1;
  final tTv = <Serial>[];

  test('should get list of tv  recommendations from the repository',
      () async {
    // arrange
    when(mockSerialRepository.getSerialRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}