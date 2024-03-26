
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/serial/remove_watchlist_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSerial usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = RemoveWatchlistSerial(mockSerialRepository);
  });

  test('should remove watchlist serial from repository', () async {
    // arrange
    when(mockSerialRepository.removeWatchlist(tSerialDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(tSerialDetail);
    // assert
    verify(mockSerialRepository.removeWatchlist(tSerialDetail));
    expect(result, Right('Removed from watchlist'));
  });
}