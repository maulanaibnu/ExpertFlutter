
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSerial usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetWatchlistSerial(mockSerialRepository);
  });

  final tSerialList = [tSerial];

  test('should get list of serial from the repository', () async {
    // arrange
    when(mockSerialRepository.getWatchlistSerial())
        .thenAnswer((_) async => Right(tSerialList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSerialList));
  });
}