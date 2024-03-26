import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/get_popular_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSerialRepository mockSerialRepository;
  late GetPopularSerial usecase;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetPopularSerial(mockSerialRepository);
  });

  final tSerial = <Serial>[];

  test('should get list of serial  popular  from the repository', () async {
    // arrange
    when(mockSerialRepository.getPopularSerial())
        .thenAnswer((_) async => Right(tSerial));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSerial));
  });


}
