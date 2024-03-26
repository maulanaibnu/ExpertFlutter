
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/usecases/serial/search_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
    late MockSerialRepository mockSerialRepository;
  late SearchSerial usecase;


  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = SearchSerial(mockSerialRepository);
  });

  final tSerial = <Serial>[];
  final tQuery = 'Hazbin Hotel';

  test('should get list of  serial from the repository', () async {
    // arrange
    when(mockSerialRepository.searchSerial(tQuery))
        .thenAnswer((_) async => Right(tSerial));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSerial));
  });

  
}