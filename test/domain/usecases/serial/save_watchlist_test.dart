
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/serial/save_watchlist_serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSerial usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = SaveWatchlistSerial(mockSerialRepository);
  });

  test('should save serial to the repository', () async {
    // arrange
    when(mockSerialRepository.saveWatchlist(tSerialDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tSerialDetail);
    // assert
    verify(mockSerialRepository.saveWatchlist(tSerialDetail));
    expect(result, Right('Added to Watchlist'));
  });
}